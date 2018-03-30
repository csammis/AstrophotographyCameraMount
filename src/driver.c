#include "driver.h"
#include <msp430.h>

#define set_dir_forward()   (P1OUT |=  BIT7)
#define set_dir_reverse()   (P1OUT &= &BIT7)


/*-----------------------------------------------
At a gear ratio of 11 : 29, the driver must issue
an 1/8th step every 14ms...ish. The PWM_PERIOD is
experimentally confirmed to result in 1RPM at the
screw gear. OUTMOD_7 results in a rising edge
PWM_PERIOD.
-----------------------------------------------*/

#define PWM_PERIOD  14750
#define TMR_CLK_SRC TASSEL__SMCLK

void driver_init(void)
{
    TA0CCR0     = PWM_PERIOD - 1;
    TA0CCTL1    = OUTMOD_7;
    TA0CCR1     = PWM_PERIOD / 2;
}

void driver_start(void)
{
    set_dir_forward();
    TA0CTL = TMR_CLK_SRC | MC__UP | TACLR;
}

void driver_stop(void)
{
    TA0CTL = TMR_CLK_SRC | MC__STOP;
}
