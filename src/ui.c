#include "ui.h"

#include "buttons.h"
#include "charset.h"
#include "graphics.h"
#include "lcd.h"
#include "options.h"

#define MAX_WIDTH               (84 / 5)
#define SELECTION_INDICATOR     "*"
#define CHAR_HEIGHT             8
#define ROW_TO_Y_OFFSET(i)      (i * CHAR_HEIGHT)

typedef uint8_t menu_id_t; enum
{
    UI_MENU_NONE,
    UI_MENU_MAIN,
    UI_MENU_SPEED,
    UI_MENU_TIMER
};

typedef struct
{
    menu_id_t   id;
    char**      items;
    uint8_t     item_count;
    uint8_t     current_selection;
} menu_t;

// All menu items must start with two spaces to accommodate the * selection indicator
#define MAIN_MENU_ITEMS     4
static const char* main_menu[MAIN_MENU_ITEMS] =
{
    "  Start",
    "  Set timer",
    "  Set speed",
    "  Off"
};

#define TIMER_MENU_ITEMS    5
static const char* timer_menu[TIMER_MENU_ITEMS] =
{
    "  10 seconds",
    "  30 seconds",
    "  60 seconds",
    "  90 seconds",
    "  120 seconds"
};

#define SPEED_MENU_ITEMS    2
static const char* speed_menu[SPEED_MENU_ITEMS] =
{
    "  Sidereal",
    "  Lunar"
};

static ui_state_t   ui_state;
static ui_state_t   next_ui_state;
static menu_t       active_menu;
static boolean      ok_has_been_pressed;
static boolean      select_has_been_pressed;

static void render_menu(menu_t* menu);
static void clear_menu_item_selection(uint8_t row);
static void set_active_menu(menu_id_t menu, uint8_t selected_row);
static void set_menu_item_selection(uint8_t row);

static uint16_t strlen(const char* s);
static uint16_t strlen(const char* s)
{
    char* e = (char*)s;
    while(*e) { e++; }
    return e - s;
}

static void render_menu(menu_t* menu)
{
    uint8_t i;

    lcd_clear();

    // Don't need to worry about paging here
    for (i = 0; i < menu->item_count; i++)
    {
        lcd_draw_string_n(0, i, menu->items[i], strlen(menu->items[i]));
    }

    set_menu_item_selection(menu->current_selection);
}

static void clear_menu_item_selection(uint8_t row)
{
    lcd_draw_string_n(0, row, " ", 1);
}

static void set_menu_item_selection(uint8_t row)
{
    lcd_draw_string_n(0, row, SELECTION_INDICATOR, 1);
}

static void set_active_menu(menu_id_t menu, uint8_t selected_row)
{
    switch(menu)
    {
        case UI_MENU_MAIN:
            active_menu.items = (char**)main_menu;
            active_menu.item_count = MAIN_MENU_ITEMS;
            break;
        case UI_MENU_TIMER:
            active_menu.items = (char**)timer_menu;
            active_menu.item_count = TIMER_MENU_ITEMS;
            break;
        case UI_MENU_SPEED:
            active_menu.items = (char**)speed_menu;
            active_menu.item_count = SPEED_MENU_ITEMS;
            break;
    }
    active_menu.id = menu;
    active_menu.current_selection = selected_row;
    render_menu(&active_menu);
}

void ui_init(void)
{
    ui_state = UI_STATE_NOT_STARTED;
    next_ui_state = UI_STATE_NOT_STARTED;
    active_menu.id = UI_MENU_NONE;
    ok_has_been_pressed = FALSE;
    select_has_been_pressed = FALSE;
}

void ui_process_ok_press(void)
{
    switch (active_menu.id)
    {
    case UI_MENU_MAIN:
        switch (active_menu.current_selection)
        {
            case 0:
                // Start
                break;
            case 1:
                set_active_menu(UI_MENU_TIMER, options_get_shutter_speed());
                break;
            case 2:
                set_active_menu(UI_MENU_SPEED, options_get_rotation_speed());
                break;
            case 3:
                // Off
                break;
        }
        break;
    case UI_MENU_TIMER:
        options_set_shutter_speed(active_menu.current_selection);
        set_active_menu(UI_MENU_MAIN, 0);
        break;
    case UI_MENU_SPEED:
        options_set_rotation_speed(active_menu.current_selection);
        set_active_menu(UI_MENU_MAIN, 0);
        break;
    case UI_MENU_NONE:
        // Cancel whatever's going on
        set_active_menu(UI_MENU_MAIN, 0);
        break;
    }
}

void ui_process_select_press(void)
{
    if (active_menu.id != UI_MENU_NONE)
    {
        clear_menu_item_selection(active_menu.current_selection);
        active_menu.current_selection++;
        if (active_menu.current_selection == active_menu.item_count)
        {
            active_menu.current_selection = 0;
        }
        set_menu_item_selection(active_menu.current_selection);
    }
}

void ui_set_state(ui_state_t state)
{
    next_ui_state = state;
}

void ui_update(void)
{
    switch (ui_state)
    {
    case UI_STATE_NOT_STARTED:
        set_active_menu(UI_MENU_MAIN, 0);
        next_ui_state = UI_STATE_IN_SETUP;
        break;
    case UI_STATE_IN_SETUP:
        if (is_button_pressed(BUTTON_OK))
        {
            if (ok_has_been_pressed == FALSE)
            {
                ui_process_ok_press();
                ok_has_been_pressed = TRUE;
            }
        }
        else
        {
            ok_has_been_pressed = FALSE;
        }

        if (is_button_pressed(BUTTON_SELECT))
        {
            if (select_has_been_pressed == FALSE)
            {
                ui_process_select_press();
                select_has_been_pressed = TRUE;
            }
        }
        else
        {
            select_has_been_pressed = FALSE;
        }
    }

    ui_state = next_ui_state;
}
