#include "driver.h"
#include "options.h"
#include <msp430.h>

#define set_dir_forward()   (P1OUT |=  BIT0)
#define set_dir_reverse()   (P1OUT &= ~BIT0)
#define set_rate(x)         \
 TA0CCR0 =  x - 1;          \
 TA0CCR1 = (x - 1) / 2;

/*************************************************
Sourced from SMCLK running at 1MHz:
    * 5385 pulses of TA0 comes out to 185.7 pps
    * Stepper motor is running at 1/8th step pp
    * 23.2125 steps == 41.7825 degrees
    * 0.1160625 rotations per second, 6.96375 RPM
...and so on for the lunar rate
*************************************************/
#define SIDEREAL_PWM_PERIOD 5385
#define LUNAR_PWM_PERIOD    5516

#define TMR_CLK_SRC TASSEL__SMCLK

void driver_init(void)
{
    TA0CCTL1 = OUTMOD_7;
}

void driver_start(void)
{
    driver_stop();
    set_dir_forward();
    switch (options_get_rotation_speed())
    {
    case ROTATION_LUNAR:
        set_rate(LUNAR_PWM_PERIOD);
        break;
    case ROTATION_SIDEREAL:
        set_rate(SIDEREAL_PWM_PERIOD);
        break;
    }
    TA0CTL = TMR_CLK_SRC | MC__UP | TACLR;
}

void driver_stop(void)
{
    TA0CTL = TMR_CLK_SRC | MC__STOP;
}

boolean driver_running(void)
{
    return (TA0CTL & 0x30) != 0;
}
