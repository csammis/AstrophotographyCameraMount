/*
 * lcd.c
 */

#include "lcd.h"
#include "charset.h"
#include <msp430.h>

// Convenience macros
#define set_rst()   (P3OUT |=  BIT2)
#define clr_rst()   (P3OUT &= ~BIT2)
#define set_dc()    (P2OUT |=  BIT7)
#define clr_dc()    (P2OUT &= ~BIT7)
#define set_led()   (P2OUT |=  BIT5)
#define clr_led()   (P2OUT &= ~BIT5)

// PCD8544 command set
#define PCD8544_POWERDOWN               0x04
#define PCD8544_ENTRYMODE               0x02
#define PCD8544_EXTENDEDINSTRUCTION     0x01
#define PCD8544_NORMALINSTRUCTION       0x00
#define PCD8544_DISPLAYCONTROL          0x08
#define PCD8544_DISPLAYBLANK            0x00
#define PCD8544_DISPLAYNORMAL           0x04
#define PCD8544_DISPLAYALLON            0x01
#define PCD8544_DISPLAYINVERTED         0x05
#define PCD8544_FUNCTIONSET             0x20
#define PCD8544_SETYADDR                0x40
#define PCD8544_SETXADDR                0x80
#define PCD8544_SETTEMP                 0x04
#define PCD8544_SETBIAS                 0x10
#define PCD8544_SETVOP                  0x80

#define PCD8544_HPIXELS     84
#define PCD8544_VBANKS      6
#define PCD8544_MAXBYTES    (PCD8544_HPIXELS * PCD8544_VBANKS)

// Pointers to transfer data
#define MAX_CMD_BYTES       6
uint8_t     cmd_buffer[MAX_CMD_BYTES];
uint8_t*    tx_buffer;
uint32_t    tx_size;
uint32_t    tx_index;

#define STATUS_SPI_DONE         0
#define STATUS_SPI_IN_PROGRESS  (1 << 0)

static uint8_t status;
static boolean write_zeros;

#define signal_transfer_complete()              \
    do {                                        \
        status = STATUS_SPI_DONE;               \
        __bic_SR_register_on_exit(LPM0_bits);   \
    } while (0);

static void set_cursor_position(uint8_t x, uint8_t y);
static void wait_for_transfer(void);
static void write_buffer(uint8_t* buffer, uint32_t size);
static void write_command_buffer(uint8_t* buffer, uint32_t size);
static void write_data_buffer(uint8_t* buffer, uint32_t size);

void lcd_init(void)
{
    write_zeros = FALSE;

    // Initialize uSCSI A1 as SPI master
    UCA1CTLW0 |= UCSWRST;

    UCA1CTLW0 |= UCSYNC      |   // Synchronous mode (SPI)
                 UCMODE_2    |   // 4-pin SPI CS active low
                 UCMST       |   // Master mode
                 UCSSEL_2    |   // Source BRCLK from SMCLK
                 UCMSB       |   // MSB first
                 UCSTEM;         // STE as chip select

    UCA1BRW = 0x0000;   // Let it roll at BRCLK for now
    UCA1IE  = 0x0000;   // No interrupts for now

    UCA1CTLW0 &= ~UCSWRST;

    // Reset the LCD
    set_rst();
    clr_rst();
    set_rst();

    // Set the initial LCD state
    cmd_buffer[0] = PCD8544_FUNCTIONSET     | PCD8544_EXTENDEDINSTRUCTION;
    cmd_buffer[1] = PCD8544_SETVOP          | 0xBF;
    cmd_buffer[2] = PCD8544_SETTEMP         | 0x02;
    cmd_buffer[3] = PCD8544_SETBIAS         | 0x03;
    cmd_buffer[4] = PCD8544_FUNCTIONSET     | PCD8544_NORMALINSTRUCTION;
    cmd_buffer[5] = PCD8544_DISPLAYCONTROL  | PCD8544_DISPLAYNORMAL;
    write_command_buffer(cmd_buffer, 6);
}

void lcd_clear(void)
{
    lcd_clear_banks(0, PCD8544_VBANKS);
}

void lcd_clear_banks(uint8_t y, uint8_t num_rows)
{
    wait_for_transfer();
    set_cursor_position(0, y);
    write_zeros = TRUE;
    write_data_buffer(0, PCD8544_HPIXELS * num_rows);
}

void lcd_draw_bitmap(uint8_t x, uint8_t y, const uint8_t* bitmap, uint32_t bitmap_length)
{
    wait_for_transfer();

    set_cursor_position(x, y);
    write_data_buffer((uint8_t*)bitmap, bitmap_length);
}

void lcd_draw_string_n(uint8_t x, uint8_t y, const char* str, uint32_t len)
{
    uint32_t i = 0;
    char* c = 0;

    wait_for_transfer();

    set_cursor_position(x, y);
    for(; i < len; i++)
    {
        c = get_char_buffer(get_char_index(str[i]));
        write_data_buffer((uint8_t*)c, CHARWIDTH);
    }
}

void lcd_set_led(boolean on)
{
    if (on)
    {
        set_led();
    }
    else
    {
        clr_led();
    }
}

static void set_cursor_position(uint8_t x, uint8_t y)
{
    cmd_buffer[0] = PCD8544_SETXADDR | x;
    cmd_buffer[1] = PCD8544_SETYADDR | y;
    write_command_buffer(cmd_buffer, 2);
}

static void wait_for_transfer(void)
{
    while (status != STATUS_SPI_DONE)
    {
        __bis_SR_register(LPM0_bits | GIE);
    }
}

static void write_buffer(uint8_t* buffer, uint32_t size)
{
    tx_buffer   = buffer;
    tx_size     = size;
    tx_index    = 0;
    status      = STATUS_SPI_IN_PROGRESS;
    UCA1IE      = UCTXIE | UCRXIE;
    wait_for_transfer();
}

static void write_command_buffer(uint8_t* buffer, uint32_t size)
{
    clr_dc();
    write_buffer(buffer, size);
}

static void write_data_buffer(uint8_t* buffer, uint32_t size)
{
    set_dc();
    write_buffer(buffer, size);
}

#pragma vector = USCI_A1_VECTOR
__interrupt void USCIA1_ISR(void)
{
    switch (__even_in_range(UCA1IV, USCI_SPI_UCTXIFG))
    {
    case USCI_SPI_UCTXIFG:
        if (tx_index < tx_size)
        {
            if (write_zeros == TRUE)
            {
                UCA1TXBUF = 0x00;
                tx_index++;
            }
            else
            {
                UCA1TXBUF = tx_buffer[tx_index++];
            }
        }
        break;

    case USCI_SPI_UCRXIFG:
        if (tx_index == tx_size)
        {
            UCA1IE = 0;
            write_zeros = FALSE;
            signal_transfer_complete();
        }
        break;
    }
}
