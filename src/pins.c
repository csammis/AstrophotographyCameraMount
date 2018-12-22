#include "pins.h"
#include <msp430.h>

/*-----------------------------------------------
 * Pin Allocations
 *
 * P1.0
 * P1.1 DRV TA0.1 PWM       Function 10, output
 * P1.2
 * P1.3
 * P1.4
 * P1.5
 * P1.6
 * P1.7 DRV GPIO OUTPUT     DRV_DIR
 * P2.0
 * P2.1
 * P2.2
 * P2.3
 * P2.4 LCD UCA1 SPI SCLK   Function 01
 * P2.5 LCD LED
 * P2.6 LCD UCA1 SPI SIMO   Function 01
 * P2.7 LCD GPIO OUTPUT     LCD_DC
 * P3.0
 * P3.1 LCD UCA1 SPI STE    Function 01
 * P3.2 LCD GPIO OUTPUT     LCD_RST
 *
-----------------------------------------------*/

#define PORT1_DIR       (BIT0 | BIT1 | BIT6 | BIT7)
#define PORT2_DIR       (BIT5 | BIT7)
#define PORT3_DIR       (BIT2)

#define PORT1_SEL0      (  0  |   0  | BIT2 | BIT3 | BIT4 | BIT5 |   0  |   0 )
#define PORT1_SEL1      (  0  | BIT1 |   0  |   0  |   0  |   0  |   0  |   0 )

#define PORT2_SEL0      (  0  |   0  |   0  |   0  | BIT4 |   0  | BIT6 |   0 )
#define PORT2_SEL1      (  0  |   0  |   0  |   0  |   0  |   0  |   0  |   0 )

#define PORT3_SEL0      (  0  | BIT1 |   0 )
#define PORT3_SEL1      (  0  |   0  |   0 )

void init_pins(void)
{
    // Set pin directions and mux selections
    P1DIR   = PORT1_DIR;
    P2DIR   = PORT2_DIR;
    P3DIR   = PORT3_DIR;

    P1SEL0  = PORT1_SEL0;
    P1SEL1  = PORT1_SEL1;
    P2SEL0  = PORT2_SEL0;
    P2SEL1  = PORT2_SEL1;
    P3SEL0  = PORT3_SEL0;
    P3SEL1  = PORT3_SEL1;

    // Finally, unlock the default high-impedance state and set current configurations
    PM5CTL0 &= ~LOCKLPM5;
}
