#include <msp430.h>

#include "driver.h"
#include "gps.h"
#include "graphics.h"
#include "lcd.h"
#include "pins.h"
#include "positioning.h"
#include "sensors.h"

#include "QmathLib.h"

void init_startup_peripherals(void);

int main(void)
{
    axis_type acc;
    _q10 r;

    WDTCTL = WDTPW | WDTHOLD;   // Stop watchdog

    init_startup_peripherals();

    graphics_draw_world_map();
    lcd_draw_string_n(0, 5, "Searching...", 12);
    graphics_update_world_sweeper(25);

    driver_start();

    while (1)
    {
        init_axis_type(acc);

        sensors_read_accel(&acc);
        positioning_set_accel_reading(&acc);

        r = positioning_get_current_roll();

        __delay_cycles(2000);
    }

    __bis_SR_register(LPM0_bits);

    return 0;
}

void init_startup_peripherals(void)
{
    init_pins();

    __bis_SR_register(GIE);

    driver_init();
    lcd_init();
    positioning_init();
    sensors_init();
    //gps_init();
}
