#include "pins.h"
#include <msp430.h>

/*-----------------------------------------------
 * Pin Allocations
 *
 * P1.0
 * P1.1 SNS GPIO OUTPUT     SNS_EN
 * P1.2 SNS UCB0 I2C SDA    Function 01
 * P1.3 SNS UCB0 I2C SCL    Function 01
 * P1.4 GPS UCA0 UART TX    Function 01
 * P1.5 GPS UCA0 UART RX    Function 01
 * P1.6
 * P1.7
 * P2.0
 * P2.1
 * P2.2
 * P2.3
 * P2.4 LCD UCA1 SPI SCLK   Function 01
 * P2.5
 * P2.6 LCD UCA1 SPI SIMO   Function 01
 * P2.7 LCD GPIO OUTPUT     LCD_DC
 * P3.0
 * P3.1 LCD UCA1 SPI STE    Function 01
 * P3.2 LCD GPIO OUTPUT     LCD_RST
 *
-----------------------------------------------*/

#define PORT1_DIR       (BIT1)
#define PORT2_DIR       (BIT7)
#define PORT3_DIR       (BIT2)

#define PORT1_SEL0      (BIT2 | BIT3 | BIT4 | BIT5)
#define PORT1_SEL1      (0)
#define PORT2_SEL0      (BIT4 | BIT6)
#define PORT2_SEL1      (0)
#define PORT3_SEL0      (BIT1)
#define PORT3_SEL1      (0)

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
