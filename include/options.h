#ifndef _OPTIONS_H_
#define _OPTIONS_H_

#include <stdint.h>

typedef uint8_t rotation_speed_t; enum
{
    ROTATION_SIDEREAL,
    ROTATION_LUNAR
};

typedef uint8_t shutter_speed_t; enum
{
    SHUTTER_10_S,
    SHUTTER_30_S,
    SHUTTER_60_S,
    SHUTTER_90_S,
    SHUTTER_120_S
};

void options_init(void);

rotation_speed_t options_get_rotation_speed(void);
void options_set_rotation_speed(rotation_speed_t speed);

shutter_speed_t options_get_shutter_speed(void);
void options_set_shutter_speed(shutter_speed_t speed);

#endif
