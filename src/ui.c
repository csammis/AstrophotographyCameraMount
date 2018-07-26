#include "ui.h"

#include "charset.h"
#include "gps.h"
#include "graphics.h"
#include "lcd.h"
#include "positioning.h"

#define SEARCHING           "Searching..."
#define SEARCHING_LEN       12

#define HEADING             "Heading: "
#define HEADING_LEN         9

#define TILT                "Tilt: "
#define TILT_LEN            6

#define HEADING_VAL_START   ((HEADING_LEN) * CHARWIDTH)
#define TILT_VAL_START      ((TILT_LEN) * CHARWIDTH)

#define INVALID_VALUE       "?       "
#define INVALID_VALUE_LEN   8

static ui_state_t   ui_state;
static ui_state_t   next_ui_state;
static uint32_t     sweeper_pos;
static boolean      label_drawn;

#define QTOA_FORMAT     "%3.2f"
#define MAX_CHAR_WIDTH  8
static char             qtoa_buffer[MAX_CHAR_WIDTH];
#define clear_qtoa_buffer() do { uint8_t i; for (i = 0; i < MAX_CHAR_WIDTH; i++) { qtoa_buffer[i] = ' '; } } while(0);

void ui_init(void)
{
    ui_state = UI_NOT_STARTED;
    label_drawn = FALSE;
    clear_qtoa_buffer();
}

void ui_set_state(ui_state_t state)
{
    next_ui_state = state;
    label_drawn = FALSE;
}

void ui_update(void)
{
    switch (ui_state)
    {
    case UI_NOT_STARTED:
        graphics_draw_world_map();
        if (label_drawn == FALSE)
        {
            lcd_draw_string_n(0, 5, SEARCHING, SEARCHING_LEN);
            label_drawn = TRUE;
        }
        sweeper_pos = 0;
        break;
    case UI_GPS_ACQUIRING_FIX:
        graphics_update_world_sweeper(sweeper_pos++);
        break;
    case UI_POS_ADJUST_HEADING:
        {
            if (label_drawn == FALSE)
            {
                lcd_draw_string_n(0, 5, HEADING, HEADING_LEN);
                label_drawn = TRUE;
            }
            
            _q10 heading = positioning_get_current_heading();
            if (heading == POSITION_INVALID)
            {
                lcd_draw_string_n(HEADING_VAL_START, 5, INVALID_VALUE, INVALID_VALUE_LEN);
            }
        }
        break;
    case UI_POS_ADJUST_TILT:
        {
            if (label_drawn == FALSE)
            {
                lcd_draw_string_n(0, 5, TILT, TILT_LEN);
                label_drawn = TRUE;
            }

            _q10 pitch = positioning_get_current_pitch();
            if (pitch == POSITION_INVALID)
            {
                lcd_draw_string_n(TILT_VAL_START, 5, INVALID_VALUE, INVALID_VALUE_LEN);
            }
            else
            {
                clear_qtoa_buffer();
                _Q10toa(qtoa_buffer, QTOA_FORMAT, pitch);
                lcd_draw_string_n(TILT_VAL_START, 5, qtoa_buffer, 8);
            }
        }
        break;
    }

    ui_state = next_ui_state;
}
