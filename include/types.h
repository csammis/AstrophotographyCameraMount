/*
 * types.h
 */

#ifndef _TYPES_H_
#define _TYPES_H_

#include <stdint.h>
#include "QmathLib.h"

typedef uint8_t         boolean;

#define TRUE            1
#define FALSE           0

typedef struct
{
    _q10 x;
    _q10 y;
    _q10 z;
} axis_type;

#define init_axis_type(a) do { a.x = a.y = a.z = 0; } while(0);


#endif
