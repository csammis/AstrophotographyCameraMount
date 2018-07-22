#ifndef _POSITIONING_H_
#define _POSITIONING_H_

#include "QmathLib.h"
#include "types.h"

#define POSITION_INVALID _Q10(0xBEEF)

void positioning_init();
void positioning_set_accel_reading(axis_type* axes);
void positioning_set_mag_reading(axis_type* axes);
void positioning_set_coordinates(coordinate_type* coordinates);

_q10 positioning_get_current_pitch();
_q10 positioning_get_current_roll();
_q10 positioning_get_current_heading();

#endif
