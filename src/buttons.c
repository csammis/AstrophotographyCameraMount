#include "buttons.h"
#include <msp430.h>


#define BUTTON_REG              P2IN
#define BUTTON_PRESSED_LEVEL    FALSE

typedef struct
{
    uint8_t             mask;
    boolean             state;
} button_info_t;

static button_info_t button_states[BUTTON_COUNT];

void buttons_init(void)
{
    button_info_t* b;

    b = &button_states[BUTTON_OK];
    b->mask = BIT1;
    b->state = ! BUTTON_PRESSED_LEVEL;

    b = &button_states[BUTTON_SELECT];
    b->mask = BIT0;
    b->state = ! BUTTON_PRESSED_LEVEL;

    // Set the button pins to internal pullups
    P2OUT |= BIT1 | BIT0;
    P2REN |= BIT1 | BIT0;
}

void buttons_update_state(void)
{
    int i = 0;
    button_info_t* b;
    uint8_t p2state = BUTTON_REG;

    for(; i < BUTTON_COUNT; i++)
    {
        b = &button_states[i];
        b->state = (p2state & b->mask);
    }
}

boolean is_button_pressed(button_type_t button)
{
    return button_states[button].state == BUTTON_PRESSED_LEVEL;
}
