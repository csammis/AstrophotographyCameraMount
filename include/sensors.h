#ifndef _SENSORS_H_
#define _SENSORS_H_

#include "types.h"

typedef struct
{
    uint16_t x;
    uint16_t y;
    uint16_t z;
} axis_type;

void sensors_init(void);

void sensors_read_accel(axis_type* axes);
void sensors_read_mag(axis_type* axes);

#endif
