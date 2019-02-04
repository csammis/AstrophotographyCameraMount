#include <msp430.h>

#include "buttons.h"
#include "driver.h"
#include "events.h"
#include "lcd.h"
#include "pins.h"
#include "ui.h"

void init_startup_peripherals(void);
void update_sensors(void);

int main(void)
{
    WDTCTL = WDTPW | WDTHOLD;   // Stop watchdog

    init_startup_peripherals();

    lcd_set_led(TRUE);

    event_enable(EVENT_DISPLAY_UPDATE);
    event_enable(EVENT_BUTTON_CHECK);

    while (1)
    {
        if (event_has_triggered(EVENT_BUTTON_CHECK))
        {
            buttons_update_state();
        }

        if (event_has_triggered(EVENT_DISPLAY_UPDATE))
        {
            ui_update();
        }

        update_events_and_sleep();
    }

    return 0;
}

void init_startup_peripherals(void)
{
    init_pins();

    __bis_SR_register(GIE);

    driver_init();
    buttons_init();
    events_init();
    lcd_init();
    ui_init();
}
