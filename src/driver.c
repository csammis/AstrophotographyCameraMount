#include "driver.h"
#include <msp430.h>

#define set_dir_forward()   (P1OUT &= ~BIT7)
#define set_dir_reverse()   (P1OUT |=  BIT7)

#define PWM_PERIOD  1000
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
