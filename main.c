#include <msp430.h>

#include "driver.h"
#include "events.h"
#include "gps.h"
#include "lcd.h"
#include "pins.h"
#include "positioning.h"
#include "sensors.h"
#include "ui.h"

void init_startup_peripherals(void);
void update_sensors(void);

int main(void)
{
    WDTCTL = WDTPW | WDTHOLD;   // Stop watchdog

    init_startup_peripherals();

    event_enable(EVENT_DISPLAY_UPDATE);
    driver_start();
    //event_enable(EVENT_GPS_UPDATE);

    ui_set_state(UI_GPS_ACQUIRING_FIX);

    while (1)
    {
        /*if (event_has_triggered(EVENT_SENSOR_UPDATE))
        {
            update_sensors();
        }*/

        if (event_has_triggered(EVENT_DISPLAY_UPDATE))
        {
            ui_update();
        }

        /*if (event_has_triggered(EVENT_GPS_UPDATE))
        {
            if (gps_has_fix())
            {
                coordinate_type coordinates;
                gps_get_coordinates(&coordinates);
                positioning_set_coordinates(&coordinates);

                ui_set_state(UI_POS_ADJUST_TILT);

                // Now that we have a fix, start updating the accel/mag
                // sensors to produce a heading and tilt
                event_disable(EVENT_GPS_UPDATE);
                event_enable(EVENT_SENSOR_UPDATE);
            }
        }*/

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
    /*positioning_init();
    sensors_init();
    gps_init();*/
}
