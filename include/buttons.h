#ifndef _BUTTONS_H_
#define _BUTTONS_H_

#include <stdint.h>
#include "types.h"

typedef uint8_t button_type_t; enum
{
    BUTTON_OK,
    BUTTON_SELECT,
    BUTTON_COUNT
};

void buttons_init(void);
void buttons_update_state(void);
boolean is_button_pressed(button_type_t button);

#endif
