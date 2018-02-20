#include "pins.h"
#include <msp430.h>

// I would really like something like
//           Name       Port    Pin,    Func,   Dir
// MAKE_PIN( LCD_RST,   3,      2,      GPIO,   OUTPUT )
//
// but it seems practically impossible (or just stupid) to do with macros alone.
// If there is spare program space when all is done, a small set of functions
// can do the work.

// GPS: No GPIO
#define GPS_PORT1_DIR   (0)
#define GPS_PORT2_DIR   (0)
#define GPS_PORT3_DIR   (0)

// GPS: Mux P1.4 and P1.5 as UCA0 UART
#define GPS_PORT1_SEL0  (BIT4 | BIT5)
#define GPS_PORT1_SEL1  (0)
#define GPS_PORT2_SEL0  (0)
#define GPS_PORT2_SEL1  (0)
#define GPS_PORT3_SEL0  (0)
#define GPS_PORT3_SEL1  (0)

// LCD: Set P2.7 and P3.2 as outputs
#define LCD_PORT1_DIR   (0)
#define LCD_PORT2_DIR   (BIT7)
#define LCD_PORT3_DIR   (BIT2)

// LCD: Mux P2.4, P2.6, and P3.1 as UCA1 SPI (except SOMI)
#define LCD_PORT1_SEL0  (0)
#define LCD_PORT1_SEL1  (0)
#define LCD_PORT2_SEL0  (BIT4 | BIT6)
#define LCD_PORT2_SEL1  (0)
#define LCD_PORT3_SEL0  (BIT1)
#define LCD_PORT3_SEL1  (0)

// Sensors: No GPIO (maybe a load switch eventually?)
#define SNS_PORT1_DIR   (0)
#define SNS_PORT2_DIR   (0)
#define SNS_PORT3_DIR   (0)

// Sensors: Mux P1.2 and P1.3 as UCB0 I2C
#define SNS_PORT1_SEL0  (BIT2 | BIT3)
#define SNS_PORT1_SEL1  (0)
#define SNS_PORT2_SEL0  (0)
#define SNS_PORT2_SEL1  (0)
#define SNS_PORT3_SEL0  (0)
#define SNS_PORT3_SEL1  (0)

// Driver: No GPIO (haha just kidding, lots of it)
#define DRV_PORT1_DIR   (0)
#define DRV_PORT2_DIR   (0)
#define DRV_PORT2_DIR   (0)

// Driver: Leave pins at GPIO function
#define DRV_PORT1_SEL0  (0)
#define DRV_PORT1_SEL1  (0)
#define DRV_PORT2_SEL0  (0)
#define DRV_PORT2_SEL1  (0)
#define DRV_PORT3_SEL0  (0)
#define DRV_PORT3_SEL1  (0)

void init_pins(void)
{
    // Set pin directions
    P1DIR =     LCD_PORT1_DIR   | SNS_PORT1_DIR     | GPS_PORT1_DIR;
    P2DIR =     LCD_PORT2_DIR   | SNS_PORT2_DIR     | GPS_PORT2_DIR;
    P3DIR =     LCD_PORT3_DIR   | SNS_PORT3_DIR     | GPS_PORT3_DIR;

    // Set mux selections
    P1SEL0 =    LCD_PORT1_SEL0  | SNS_PORT1_SEL0    | GPS_PORT1_SEL0;
    P1SEL1 =    LCD_PORT1_SEL1  | SNS_PORT1_SEL1    | GPS_PORT1_SEL1;
    P2SEL0 =    LCD_PORT2_SEL0  | SNS_PORT2_SEL0    | GPS_PORT2_SEL0;
    P2SEL1 =    LCD_PORT2_SEL1  | SNS_PORT2_SEL1    | GPS_PORT2_SEL1;
    P3SEL0 =    LCD_PORT3_SEL0  | SNS_PORT3_SEL0    | GPS_PORT3_SEL0;
    P3SEL1 =    LCD_PORT3_SEL1  | SNS_PORT3_SEL1    | GPS_PORT3_SEL1;

    // Finally, unlock the default high-impedance state and set current configurations
    PM5CTL0 &= ~LOCKLPM5;
}
