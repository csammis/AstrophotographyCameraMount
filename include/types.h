/*
 * types.h
 */

#ifndef _TYPES_H_
#define _TYPES_H_

#include <stdint.h>

#define GLOBAL_IQ       16

#include "IQmathLib.h"
#include "QmathLib.h"

typedef uint8_t         boolean;

#define TRUE            1
#define FALSE           0

typedef struct
{
    _iq16 x;
    _iq16 y;
    _iq16 z;
} axis_type;

typedef struct
{
    _q7 latitude;
    _q7 longitude;
} coordinate_type;

#define init_axis_type(a) do { a.x = a.y = a.z = 0; } while(0);
#define init_coordinate_type(c) do { c.latitude = c.longitude = 0; } while(0);


#endif
