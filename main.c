#include <msp430.h>

#include "driver.h"
#include "events.h"
#include "gps.h"
#include "graphics.h"
#include "lcd.h"
#include "pins.h"
#include "positioning.h"
#include "sensors.h"

#include "QmathLib.h"

void init_startup_peripherals(void);
void update_sensors(void);

int main(void)
{
    WDTCTL = WDTPW | WDTHOLD;   // Stop watchdog

    init_startup_peripherals();

    graphics_draw_world_map();
    lcd_draw_string_n(0, 5, "Searching...", 12);
    graphics_update_world_sweeper(25);

    driver_start();

    while (1)
    {
        if (event_has_triggered(EVENT_SENSOR_UPDATE))
        {
            update_sensors();
        }

        if (event_has_triggered(EVENT_DISPLAY_UPDATE))
        {
            graphics_update_world_sweeper(30);
        }

        update_events_and_sleep();
    }

    return 0;
}

void update_sensors(void)
{
    axis_type acc;
    axis_type mag;

    sensors_read_accel(&acc);
    sensors_read_mag(&mag);

    positioning_set_accel_reading(&acc);
    positioning_set_mag_reading(&mag);
}

void init_startup_peripherals(void)
{
    init_pins();

    __bis_SR_register(GIE);

    driver_init();
    events_init();
    lcd_init();
    positioning_init();
    sensors_init();
    //gps_init();
}
