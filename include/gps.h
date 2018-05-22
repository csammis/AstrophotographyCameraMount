#ifndef _GPS_H_
#define _GPS_H_

#include "types.h"

void gps_init(void);
boolean gps_has_fix(void);
boolean gps_get_coordinates(coordinate_type* coordinates);

#endif
