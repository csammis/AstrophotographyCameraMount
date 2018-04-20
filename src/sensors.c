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
#define CTRL_REG_4          0x1E
#define ACC_CTRL_REG5       0x1F
#define ACC_CTRL_REG6       0x20
#define ACC_CTRL_REG7       0x21
#define ACC_CTRL_REG8       0x22
#define MAG_OUTPUT_DATA     0x28
#define ACC_STATUS_REG      0x27
#define ACC_STATUS_REG_XLDA 0x01
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

#define signal_transfer_complete()  do { status = STATUS_I2C_DONE; __bic_SR_register_on_exit(LPM0_bits); } while (0);
#define write_accel_reg(r, d)       i2c_write_reg(ACC_ADDRESS, r, d)
#define write_mag_reg(r, d)         i2c_write_reg(MAG_ADDRESS, r, d)
#define enable_power()              (P1OUT |=  BIT0)
#define disable_power()             (P1OUT &= ~BIT0)

static void i2c_read_reg(uint8_t addr, uint8_t reg, uint8_t data_size);
static void i2c_write_reg(uint8_t addr, uint8_t reg, uint8_t data);
static void reset_interrupt_enables(void);
static void set_slave_addr(uint8_t address);
static void set_tbcnt(uint16_t size);
static void wait_for_stop(void);
static void wait_for_transfer(void);

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

    enable_power();

    __delay_cycles(1000);

    write_accel_reg(ACC_CTRL_REG8,  0b00000101);    // Reboot the accel/gyro
    write_mag_reg(  MAG_CTRL_REG2,  0b00001100);    // Reboot the magnetometer

    __delay_cycles(1000);

    write_accel_reg(CTRL_REG_4,     0b00000000);    // Shut off gyroscope
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
    tx_buffer[0] = reg;
    tx_size = 1;
    rx_size = data_size;
    tx_index = 0;
    rx_index = 0;

    wait_for_stop();
    set_slave_addr(addr);

    set_tbcnt(rx_size);
    reset_interrupt_enables();

    // Transmit register selection
    status = STATUS_I2C_REGISTER_SEL;
    UCB0CTLW0 |= UCTR | UCTXSTT;
    wait_for_transfer();

    // Receive data
    status = STATUS_I2C_IN_PROGRESS;
    UCB0CTLW0 &= ~UCTR;
    UCB0CTLW0 |= UCTXSTT;
    wait_for_transfer();
}

static void i2c_write_reg(uint8_t addr, uint8_t reg, uint8_t data)
{
    tx_buffer[0] = reg;
    tx_buffer[1] = data;
    tx_size = 2;
    tx_index = 0;

    wait_for_stop();
    set_slave_addr(addr);

    set_tbcnt(tx_size);
    reset_interrupt_enables();

    status = STATUS_I2C_IN_PROGRESS;
    UCB0CTLW0 |= UCTR | UCTXSTT;
    wait_for_transfer();
}

static inline void set_slave_addr(uint8_t address)
{
    UCB0I2CSA = address;
}

static inline void set_tbcnt(uint16_t size)
{
    UCB0CTLW0   |= UCSWRST;
    UCB0TBCNT    = size;
    UCB0CTLW0   &= ~UCSWRST;
}

static void reset_interrupt_enables(void)
{
    UCB0IE = UCTXIE0 | UCRXIE0 | UCNACKIE | UCBCNTIE;
}

static inline void wait_for_stop(void)
{
    while (UCB0CTLW0 & UCTXSTP) { ; }
}

static inline void wait_for_transfer(void)
{
    while (status != STATUS_I2C_DONE)
    {
        __bis_SR_register(LPM0_bits | GIE);
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
        if (tx_index < tx_size)
        {
            UCB0TXBUF = tx_buffer[tx_index++];
            if (tx_index == tx_size && status == STATUS_I2C_REGISTER_SEL)
            {
                // There won't be an automatic stop after the register selection data so signal complete manually
                signal_transfer_complete();
            }
        }
        break;
    case USCI_I2C_UCRXIFG0:
        if (rx_index < rx_size)
        {
            rx_buffer[rx_index++] = UCB0RXBUF;
        }
        else
        {
            while (1)
            {
                /* trap */ ;
            }
        }
        break;
    case USCI_I2C_UCBCNTIFG:
        signal_transfer_complete();
        break;
    }
}
