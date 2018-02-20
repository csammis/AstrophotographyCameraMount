/*
 * graphics.c
 */

#include "graphics.h"
#include "lcd.h"
#include "types.h"

/***** The world map shown when acquiring a GPS fix ******/
#define WORLD_MAP_HEIGHT    5
#define WORLD_MAP_WIDTH     84
#define WORLD_MAP_LENGTH    (WORLD_MAP_HEIGHT * WORLD_MAP_WIDTH)

const uint8_t world_map_data[] = {
0x00,0xe0,0xb0,0x98,0xd8,0x48,0xc8,0x08,0x08,0x08,0x08,0x08,0x08,0x08,0x08,0x08,0x08,0x78,0xd8,0x64,0x2e,0x6c,0xda,0x1a,0x06,0x3a,0x22,0x22,0x32,0x12,0x1a,0x0a,0x16,0xc2,0xc0,0x40,0xf0,0x70,0x58,0x98,0x08,0x08,0x18,0x30,0x30,0x10,0x18,0x08,0x08,0x08,0x08,0x0c,0x04,0x04,0x04,0x04,0x0c,0x08,0x08,0x08,0x08,0x08,0x08,0x08,0x08,0x08,0x88,0xd8,0x58,0xf0,0xb0,0x30,0x10,0x10,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x78,0xcf,0x80,0x00,0x00,0x80,0xc0,0x40,0xc0,0x82,0x82,0xf0,0x10,0x18,0x0c,0x06,0x02,0x03,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x80,0xdc,0x55,0x6a,0x3a,0x35,0x18,0x30,0x20,0x38,0x60,0xd2,0x92,0x04,0x00,0x22,0x30,0x60,0x40,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x08,0x9c,0xf0,0x1f,0x43,0x66,0x3a,0x00,0x01,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x03,0x06,0x0c,0x09,0x1b,0xd6,0x7c,0x18,0x0a,0x0b,0x1a,0x16,0x34,0x60,0xc0,0x80,0x80,0x00,0x00,0x00,0x00,0x00,0x1e,0x13,0x30,0x20,0x20,0x20,0xe0,0x80,0x00,0x00,0x00,0x00,0x00,0x07,0x0c,0xf8,0x10,0x1e,0x02,0x03,0x01,0x01,0x03,0x0e,0x18,0x1c,0x06,0x03,0x03,0x6e,0xf8,0xd9,0x8f,0x01,0x00,0x60,0xd8,0x00,0xc0,0x80,0x00,0x80,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x03,0x06,0x0c,0x18,0xf0,0x00,0x00,0x00,0x80,0xc0,0x70,0x1f,0x03,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x7f,0x80,0x80,0x00,0xc0,0x70,0x1c,0x67,0x70,0x18,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x81,0xe3,0x33,0x18,0x08,0x0c,0x04,0x04,0x0d,0x19,0xf1,0x03,0x01,0x06,0x00,0x00,0x00,0x00,0x08,0x10,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x07,0x1c,0x30,0x1f,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x01,0x01,0x01,0x01,0x01,0x03,0x02,0x02,0x03,0x01,0x08,0x0c,0x06,0x02,0x02,0x00,0x00,0x00,0x00,0x00,0x00
};

const unsigned char sweeper_data[2] = { 0xFF, 0xFF };

void graphics_draw_world_map(void)
{
    lcd_draw_bitmap(0, 0, world_map_data, WORLD_MAP_LENGTH);
}

void graphics_update_world_sweeper(uint32_t elapsed_time)
{
    uint32_t x_current      = elapsed_time % WORLD_MAP_WIDTH;
    uint32_t x_previous     = (x_current == 0) ? WORLD_MAP_WIDTH - 1 : x_current - 1;
    uint32_t sweeper_width  = (x_current + 1 < WORLD_MAP_WIDTH) ? 2 : 1;
    uint32_t i              = 0;

    for(; i < WORLD_MAP_HEIGHT; i++)
    {
        lcd_draw_bitmap(x_previous, i, world_map_data + ((i * WORLD_MAP_WIDTH) + x_previous), 1);
        lcd_draw_bitmap(x_current, i, sweeper_data, sweeper_width);
    }
}
