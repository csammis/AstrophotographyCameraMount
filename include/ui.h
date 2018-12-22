#ifndef _UI_H_
#define _UI_H_

#include <stdint.h>

typedef uint8_t ui_state_t; enum
{
    UI_STATE_NOT_STARTED,
    UI_STATE_IN_SETUP
};

void ui_init(void);
void ui_process_ok_press(void);
void ui_process_select_press(void);
void ui_set_state(ui_state_t state);
void ui_update(void);

#endif
