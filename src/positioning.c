#include "positioning.h"

static axis_type    current_accel_reading;

static boolean      got_accel_reading;

static _q10         current_pitch;
static _q10         current_roll;

static void normalize(axis_type* original, axis_type* normal);

static void normalize(axis_type* original, axis_type* normal)
{
    _q10 magnitude = _Q10sqrt(_Q10rmpy(original->x, original->x) +
                              _Q10rmpy(original->y, original->y) +
                              _Q10rmpy(original->z, original->z));
    if (magnitude == 0)
    {
        normal->x = normal->y = normal->z = 0;
    }
    else
    {
        normal->x = _Q10div(original->x, magnitude);
        normal->y = _Q10div(original->y, magnitude);
        normal->z = _Q10div(original->z, magnitude);
    }
}

void positioning_init()
{
    got_accel_reading = FALSE;
    current_pitch = POSITION_INVALID;
    current_roll = POSITION_INVALID;
}

_q10 positioning_get_current_pitch()
{
    if (current_pitch == POSITION_INVALID)
    {
        if (got_accel_reading)
        {
            current_pitch = _Q10asin(_Q10mpy(current_accel_reading.x, _Q10(-1)));
        }
    }
    return current_pitch;
}

_q10 positioning_get_current_roll()
{
    if (current_roll == POSITION_INVALID)
    {
        _q10 p = positioning_get_current_pitch();
        if (p != POSITION_INVALID)
        {
            current_roll = _Q10asin(_Q10div(current_accel_reading.y, _Q10cos(p)));
        }
    }
    return current_roll;
}

void positioning_set_accel_reading(axis_type* axes)
{
    normalize(axes, &current_accel_reading);
    got_accel_reading = TRUE;

    /*-------------------------------------------
    Invalidate any cached readings that depend on
    the accelerometer
    -------------------------------------------*/
    current_pitch   = POSITION_INVALID;
    current_roll    = POSITION_INVALID;
}
