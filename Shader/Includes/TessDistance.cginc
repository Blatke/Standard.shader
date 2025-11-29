// TessDistance.cginc
#ifndef TESSDISTANCE_INCLUDED
#define TESSDISTANCE_INCLUDED

#include "UnityCG.cginc"
#include "Tessellation.cginc"

#ifndef TESSELLATION_FACTOR
    #define TESSELLATION_FACTOR _Tessellation
#endif
uniform int TESSELLATION_FACTOR;

float4 tessDistance(appdata_full v0, appdata_full v1, appdata_full v2) {
    if (TESSELLATION_FACTOR >= 2) {
        float minDist = 10.0;
        float maxDist = 25.0;
        return UnityDistanceBasedTess(
            v0.vertex,
            v1.vertex,
            v2.vertex,
            minDist,
            maxDist,
            TESSELLATION_FACTOR
        );
    } else {
        return float4(1, 1, 1, 1);
    }
}

#endif