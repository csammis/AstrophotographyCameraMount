/*
 * lcd.c
 */

#include "lcd.h"
#include "charset.h"
#include <msp430.h>

#define RST_PORT        P3
#define RST_PIN         2
#define DC_PORT         P2
#define DC_PIN          7

// Convenience macros
#define set_rst()   (P3OUT |=  BIT2)
#define clr_rst()   (P3OUT &= ~BIT2)
#define set_dc()    (P2OUT |=  BIT7)
#define clr_dc()    (P2OUT &= ~BIT7)

// PCD8544 command set
#define PCD8544_POWERDOWN               0x04
#define PCD8544_ENTRYMODE               0x02
#define PCD8544_EXTENDEDINSTRUCTION     0x01
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

static void set_cursor_position(uint8_t x, uint8_t y);
static void write_command_byte(uint8_t command);
static void write_data_byte(uint8_t data);
static void write_single_byte(uint8_t byte);

void lcd_init(void)
{
    // Initialize uSCSI A1 as SPI master
    UCA1CTLW0 |= UCSWRST;

    UCA1CTLW0 |= UCSYNC      |   // Synchronous mode (SPI)
                 UCMODE_2    |   // 4-pin SPI CS active low
                 UCMST       |   // Master mode
                 UCSSEL_2    |   // Source BRCLK from SMCLK
                 UCMSB       |   // MSB first
                 UCSTEM;         // STE as chip select

    UCA1BRW = 0x0000;   // Let it roll at BRCLK for now, cstodo figure out divider
    UCA1IE  = 0x0000;   // No interrupts for now

    UCA1CTLW0 &= ~UCSWRST;

    // Reset the LCD
    set_rst();
    clr_rst();
    set_rst();

    // Set the initial LCD state
    write_command_byte(PCD8544_FUNCTIONSET | PCD8544_EXTENDEDINSTRUCTION);
    write_command_byte(PCD8544_SETVOP   | 0xBF);
    write_command_byte(PCD8544_SETTEMP  | 0x02);
    write_command_byte(PCD8544_SETBIAS  | 0x03);
    write_command_byte(PCD8544_FUNCTIONSET);
    write_command_byte(PCD8544_DISPLAYCONTROL | PCD8544_DISPLAYNORMAL);
}

void lcd_draw_bitmap(uint8_t x, uint8_t y, const uint8_t* bitmap, uint32_t bitmap_length)
{
    uint32_t i = 0;

    set_cursor_position(x, y);
    for(; i < bitmap_length; i++)
    {
        write_data_byte(bitmap[i]);
    }
}

void lcd_draw_string_n(uint8_t x, uint8_t y, const char* str, uint32_t len)
{
    uint32_t i = 0, j = 0;
    char* c = 0;

    set_cursor_position(x, y);
    for(; i < len; i++)
    {
        c = (char*)charset[get_char_index(str[i])];
        for(j = 0; j < CHARWIDTH; j++)
        {
            write_data_byte(c[j]);
        }
    }
}

static void set_cursor_position(uint8_t x, uint8_t y)
{
    write_command_byte(PCD8544_SETXADDR | x);
    write_command_byte(PCD8544_SETYADDR | y);
}

static void write_command_byte(uint8_t command)
{
    clr_dc();
    write_single_byte(command);
}

static void write_data_byte(uint8_t data)
{
    set_dc();
    write_single_byte(data);
}

static void write_single_byte(uint8_t byte)
{
    UCA1TXBUF = byte;
    while(!(UCA1IFG & UCTXIFG)) { };    // Technically everything's clocked out successfully when RXIFG is set
                                        // but for TX only I probably don't care? Buffer's not going to flush
                                        // into the shift register before everything's done...right??
}
