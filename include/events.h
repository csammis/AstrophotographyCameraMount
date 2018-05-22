#ifndef _EVENTS_H_
#define _EVENTS_H_

#include <stdint.h>
#include "types.h"

typedef uint8_t event_source_t; enum
{
    EVENT_DISPLAY_UPDATE,
    EVENT_SENSOR_UPDATE,

    EVENT_COUNT
};

typedef struct
{
    const uint8_t   period;
    int16_t         remaining_ticks;
} event_t;

boolean event_has_triggered(event_source_t event);
void events_init(void);
void update_events_and_sleep(void);

#endif
