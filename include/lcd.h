/*
 * lcd.h
 */

#ifndef _LCD_H_
#define _LCD_H_

#include "types.h"

void lcd_init(void);

void lcd_draw_bitmap(uint8_t x, uint8_t y, const uint8_t* bitmap, uint32_t bitmap_length);

void lcd_draw_string_n(uint8_t x, uint8_t y, const char* str, uint32_t len);

#endif
