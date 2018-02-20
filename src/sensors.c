/*
 * New addition to types.h:
 *  typedef bool uint8_t
 *  #define TRUE    1
 *  #define FALSE   0
 *
 * New addition to somewhere:
 *  #define ALLOW_SLEEP_DURING_WAIT 0
 *
 * New addition to somewhere else:
 *  assert?
*/

#include "sensors.h"
#include "types.h"
#include <msp430.h>

// IMU registers and addresses
#define MAG_ADDRESS         0x1E
#define ACC_ADDRESS         0x6B
#define MAG_CTRL_REG1       0x20
#define MAG_CTRL_REG2       0x21
#define MAG_CTRL_REG3       0x22
#define MAG_CTRL_REG4       0x23
#define MAG_CTRL_REG5       0x24
#define ACC_CTRL_REG5       0x1F
#define ACC_CTRL_REG6       0x20
#define ACC_CTRL_REG7       0x21
#define MAG_OUTPUT_DATA     0x28
#define ACC_OUTPUT_DATA     0x28

// Constant sized buffers for RX and TX
#define MAX_I2C_WRITE       2
#define MAX_I2C_READ        6
uint8_t     tx_buffer[MAX_I2C_WRITE];
uint8_t     tx_index;
uint8_t     tx_size;
uint8_t     rx_buffer[MAX_I2C_READ];
uint8_t     rx_index;
uint8_t     rx_size;

// I2C constants
#define STATUS_I2C_DONE         0
#define STATUS_I2C_IN_PROGRESS  (1 << 0)
#define STATUS_I2C_REGISTER_SEL (1 << 1)

static uint8_t  status;
#define READ_OP                 1
#define WRITE_OP                0

#define write_accel_reg(r, d)   i2c_write_reg(ACC_ADDRESS, r, d)
#define write_mag_reg(r, d)     i2c_write_reg(MAG_ADDRESS, r, d)

static void i2c_read_reg(uint8_t addr, uint8_t reg, uint8_t data_size);
static void i2c_select_reg_for_read(uint8_t addr, uint8_t reg);
static void i2c_write_reg(uint8_t addr, uint8_t reg, uint8_t data);
static void start_read(void);
static void start_write(void);
static inline void set_slave_addr(uint8_t address);
static inline void wait_for_stop(void);
static inline void wait_for_transfer(void);
static inline void reset_interrupt_enables(void);

void sensors_init(void)
{
    // Initialize uSCSI B0 as I2C master
    UCB0CTLW0 |= UCSWRST;

    UCB0CTLW0 |= UCMST      |   // Bus master
                 UCMODE_3   |   // I2C
                 UCSYNC     |
                 UCSSEL_2;      // Source from SMCLK
    UCB0CTLW1 |= UCASTP_2;      // Send and interrupt on automatic stops

    UCB0BRW = 0x000A;   // SMCLK / 10 = ~100kHz
    UCB0CTLW0 &= ~UCSWRST;

    write_accel_reg(ACC_CTRL_REG5,  0b00111000);    // Enable X, Y, Z axes
    write_accel_reg(ACC_CTRL_REG6,  0b01101000);    // ODR @ 119Hz, set full scale to +/- 16G

    write_mag_reg(MAG_CTRL_REG1,    0b11011000);    // Enable temperature compensation, set to high perf mode, ODR @ 40Hz
    write_mag_reg(MAG_CTRL_REG2,    0b01000000);    // Set full scale to +/- 12 gauss
    write_mag_reg(MAG_CTRL_REG3,    0b00000000);    // Continuous conversion mode
    write_mag_reg(MAG_CTRL_REG4,    0b00001000);    // Enable high performance in Z-axis only, X and Y at low power
}

void sensors_read_accel(axis_type* axes)
{
    i2c_read_reg(ACC_ADDRESS, ACC_OUTPUT_DATA, 6);
    axes->x = (rx_buffer[1] << 8) | rx_buffer[0];
    axes->y = (rx_buffer[3] << 8) | rx_buffer[2];
    axes->z = (rx_buffer[5] << 8) | rx_buffer[4];
}

void sensors_read_mag(axis_type* axes)
{
    i2c_read_reg(MAG_ADDRESS, MAG_OUTPUT_DATA, 6);
    axes->x = (rx_buffer[1] << 8) | rx_buffer[0];
    axes->y = (rx_buffer[3] << 8) | rx_buffer[2];
    axes->z = (rx_buffer[5] << 8) | rx_buffer[4];
}

static void i2c_read_reg(uint8_t addr, uint8_t reg, uint8_t data_size)
{
    i2c_select_reg_for_read(addr, reg);
    rx_size = data_size;
    start_read();
}

static void i2c_select_reg_for_read(uint8_t addr, uint8_t reg)
{
    tx_buffer[0] = reg;
    tx_size = 1;

    wait_for_stop();
    set_slave_addr(addr);

    // Automatic stops aren't wanted here, so just fire up the transmit without setting UCB0TBCNT
    status = STATUS_I2C_REGISTER_SEL;
    tx_index = 0;
    reset_interrupt_enables();
    UCB0CTLW0 |= UCTR | UCTXSTT;
    wait_for_transfer();
}

static void i2c_write_reg(uint8_t addr, uint8_t reg, uint8_t data)
{
    tx_buffer[0] = reg;
    tx_buffer[1] = data;
    tx_size = 2;

    wait_for_stop();
    set_slave_addr(addr);
    start_write();
}

static inline void set_slave_addr(uint8_t address)
{
    UCB0I2CSA = address;
}

#define signal_transfer_complete() do { status = STATUS_I2C_DONE; __bic_SR_register_on_exit(LPM0_bits); } while (0);

static void reset_interrupt_enables(void)
{
    UCB0IE = UCTXIE0 | UCRXIE0 | UCNACKIE | UCBCNTIE;
}

static void start_read(void)
{
    status = STATUS_I2C_IN_PROGRESS;
    rx_index = 0;

    // Set the data length for automatic stops
    UCB0CTLW0 |= UCSWRST;
    UCB0TBCNT = rx_size;
    UCB0CTLW0 &= ~UCSWRST;
    reset_interrupt_enables();
    // Set as receiver and send a START
    UCB0CTLW0 &= ~UCTR;
    UCB0CTLW0 |= UCTXSTT;

    wait_for_transfer();
}

static void start_write(void)
{
    status = STATUS_I2C_IN_PROGRESS;
    tx_index = 0;
    // Set the data length for automatic stops
    UCB0CTLW0 |= UCSWRST;
    UCB0TBCNT = tx_size;
    UCB0CTLW0 &= ~UCSWRST;
    reset_interrupt_enables();
    // Set as transmitter and send a START
    UCB0CTLW0 |= UCTR | UCTXSTT;

    wait_for_transfer();
}

static inline void wait_for_stop(void)
{
    while (UCB0CTLW0 & UCTXSTP) { ; }
}

static inline void wait_for_transfer(void)
{
    while (status != STATUS_I2C_DONE)
    {
        #if 1
        __bis_SR_register(LPM0_bits);
        #endif
    }
}

#pragma vector = USCI_B0_VECTOR
__interrupt void USCIB0_ISR(void)
{
    switch (__even_in_range(UCB0IV, USCI_I2C_UCBIT9IFG))
    {
    case USCI_I2C_UCNACKIFG:
        // Received NACK: resend the START
        UCB0CTL1 |= UCTXSTT;
        break;
    case USCI_I2C_UCTXIFG0:
        // TX ready
        if (tx_index < tx_size)
        {
            UCB0TXBUF = tx_buffer[tx_index++];
        }
        else if (status == STATUS_I2C_REGISTER_SEL)
        {
            // Not going to get an automatic stop so signal done
            signal_transfer_complete();
        }
        break;
    case USCI_I2C_UCRXIFG0:
        rx_buffer[rx_index++] = UCB0RXBUF;
        break;
    case USCI_I2C_UCBCNTIFG:
        signal_transfer_complete();
        break;
    }
}
