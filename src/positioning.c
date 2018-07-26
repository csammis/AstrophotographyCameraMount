#include "positioning.h"

static axis_type        current_accel_reading;
static axis_type        current_mag_reading;
static coordinate_type  current_lat_lon;

static boolean      got_accel_reading;
static boolean      got_mag_reading;
static boolean      got_lat_lon;

static _q10         current_pitch;
static _q10         current_roll;
static _q10         current_heading;

static _iq          accel_divisor;
static _iq          mag_divisor;

static void normalize(axis_type* original, axis_type* normal);

static void normalize(axis_type* original, axis_type* normal)
{
    _iq16 x2 = _IQrmpy(original->x, original->x);
    _iq16 y2 = _IQrmpy(original->y, original->y);
    _iq16 z2 = _IQrmpy(original->z, original->z);
    _iq16 magnitude = _IQ16sqrt(x2 + y2 + z2);
    if (magnitude == 0)
    {
        normal->x = normal->y = normal->z = 0;
    }
    else
    {
        normal->x = _IQdiv(original->x, magnitude);
        normal->y = _IQdiv(original->y, magnitude);
        normal->z = _IQdiv(original->z, magnitude);
    }
}

void positioning_init()
{
    got_accel_reading   = FALSE;
    got_mag_reading     = FALSE;
    got_lat_lon         = FALSE;
    current_pitch       = POSITION_INVALID;
    current_roll        = POSITION_INVALID;
    current_heading     = POSITION_INVALID;

    accel_divisor       = _IQ(0.000732f);
    mag_divisor         = _IQ(0.00058f);
}

_q10 positioning_get_current_pitch()
{
    if (current_pitch == POSITION_INVALID)
    {
        if (got_accel_reading)
        {
            _q10 x = _IQtoQ10(current_accel_reading.x);
            current_pitch = _Q10asin(_Q10mpy(x, _Q10(-1)));
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
            _q10 y = _IQtoQ10(current_accel_reading.y);
            current_roll = _Q10asin(_Q10div(y, _Q10cos(p)));
        }
    }
    return current_roll;
}

_q10 positioning_get_current_heading()
{
    return current_heading;
}

void positioning_set_accel_reading(axis_type* axes)
{
    axis_type scaled;
    scaled.x = _IQrsmpy(axes->x, accel_divisor);
    scaled.y = _IQrsmpy(axes->y, accel_divisor);
    scaled.z = _IQrsmpy(axes->z, accel_divisor);

    normalize(&scaled, &current_accel_reading);
    got_accel_reading = TRUE;

    /*-------------------------------------------
    Invalidate any cached readings that depend on
    the accelerometer
    -------------------------------------------*/
    current_pitch   = POSITION_INVALID;
    current_roll    = POSITION_INVALID;
}

void positioning_set_mag_reading(axis_type* axes)
{
    axis_type scaled;
    scaled.x = _IQrsmpy(axes->x, mag_divisor);
    scaled.y = _IQrsmpy(axes->y, mag_divisor);
    scaled.z = _IQrsmpy(axes->z, mag_divisor);

    normalize(&scaled, &current_mag_reading);
    got_mag_reading = TRUE;
}

void positioning_set_coordinates(coordinate_type* coordinates)
{
    current_lat_lon = *coordinates;
    got_lat_lon = TRUE;
}
