#include "gps.h"

#define FAKE_IT_TIL_I_MAKE_IT   TRUE

void gps_init(void)
{
    //cstodo: initialize uSCSI_A0 as UART
}

boolean gps_has_fix(void)
{
#if FAKE_IT_TIL_I_MAKE_IT
    // Simulate not having a fix for a while
    static uint8_t fix_samples = 0;

    if (fix_samples++ >= 5)
    {
        return TRUE;
    }
#endif
    return FALSE;
}

boolean gps_get_coordinates(coordinate_type* coordinates)
{
    if (gps_has_fix() == FALSE)
    {
        return FALSE;
    }

#if FAKE_IT_TIL_I_MAKE_IT
    coordinates->latitude = _Q7(39.088699);
    coordinates->longitude = _Q7(-94.585556);
#endif

    return TRUE;
}
