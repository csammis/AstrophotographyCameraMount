#include "options.h"

static rotation_speed_t rotation_speed;
static shutter_speed_t shutter_speed;

void options_init(void)
{
    rotation_speed = ROTATION_SIDEREAL;
    shutter_speed = SHUTTER_10_S;
}

rotation_speed_t options_get_rotation_speed(void)
{
    return rotation_speed;
}

void options_set_rotation_speed(rotation_speed_t speed)
{
    rotation_speed = speed;
}

shutter_speed_t options_get_shutter_speed(void)
{
    return shutter_speed;
}

void options_set_shutter_speed(shutter_speed_t speed)
{
    shutter_speed = speed;
}
