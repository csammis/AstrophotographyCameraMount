#include <msp430.h>

#include "driver.h"
#include "gps.h"
#include "graphics.h"
#include "lcd.h"
#include "pins.h"
#include "sensors.h"

void init_startup_peripherals(void);

int main(void)
{
    WDTCTL = WDTPW | WDTHOLD;   // Stop watchdog

    axis_type mag;
    axis_type acc;

    init_startup_peripherals();

    //graphics_draw_world_map();
    //lcd_draw_string_n(0, 5, "Searching...", 12);
    //graphics_update_world_sweeper(25);
    //sensors_read_accel(&acc);
    //sensors_read_mag(&mag);

    driver_start();

    __bis_SR_register(LPM0_bits);

    return 0;
}

void init_startup_peripherals(void)
{
    init_pins();

    __bis_SR_register(GIE);

    driver_init();

    //sensors_init();

    //lcd_init();
    //gps_init();
}
