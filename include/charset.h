#ifndef _CHARSET_H_
#define _CHARSET_H_

#include <stdint.h>

#define get_char_index(c)   ((uint32_t)(c - ' '))
#define CHARWIDTH   5

char* get_char_buffer(uint32_t index);

#endif
