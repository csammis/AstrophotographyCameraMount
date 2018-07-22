#ifndef _UI_H_
#define _UI_H_

#include <stdint.h>

typedef uint8_t ui_state_t; enum
{
    UI_NOT_STARTED,
    UI_GPS_ACQUIRING_FIX,
    UI_POS_ADJUST_HEADING,
    UI_POS_ADJUST_TILT,
    UI_DRIVER_RUNNING
};

void ui_init(void);
void ui_set_state(ui_state_t state);
void ui_update(void);

#endif
