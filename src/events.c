#include "events.h"
#include <msp430.h>

#define MAX_SLEEP_MS    10

#define TMR_CLK_SRC     TASSEL__SMCLK
#define make_ccr0(x)    (x * 1000)

static event_t events[EVENT_COUNT] =
{
    /*          ID                  Period      */
    /* EVENT_DISPLAY_UPDATE */  {   100     },
    /* EVENT_SENSOR_UPDATE  */  {   50      },
};

boolean event_has_triggered(event_source_t event)
{
    return events[event].remaining_ticks <= 0;
}

void events_init(void)
{
    uint8_t i;
    for (i = 0; i < EVENT_COUNT; i++)
    {
        events[i].remaining_ticks = events[i].period;
    }
}

void update_events_and_sleep(void)
{
    uint8_t i;
    uint16_t next_wakeup;

    // Reset any events which have elapsed
    for (i = 0; i < EVENT_COUNT; i++)
    {
        if (event_has_triggered(i))
        {
            events[i].remaining_ticks = events[i].period;
        }
    }

    // Calculate the next wakeup time
    next_wakeup = MAX_SLEEP_MS;
    for (i = 0; i < EVENT_COUNT; i++)
    {
        if (events[i].remaining_ticks < next_wakeup)
        {
            next_wakeup = events[i].remaining_ticks;
        }
    }

    if (next_wakeup > 0)
    {
        // Decrement the remaining time on the events
        for (i = 0; i < EVENT_COUNT; i++)
        {
            events[i].remaining_ticks -= next_wakeup;
        }

        // Set Timer1 to generate an interrupt
        TA1CCTL0    = CCIE;
        TA1CCR0     = make_ccr0(next_wakeup);
        TA1CTL      = TMR_CLK_SRC | MC__UP | TACLR;

        // Night night time!
        __bis_SR_register(LPM0_bits | GIE);
    }
}

#pragma vector = TIMER1_A0_VECTOR
__interrupt void TIMER1_ISR(void)
{
    TA1CTL    = MC__STOP;
    __bic_SR_register_on_exit(LPM0_bits);
}
