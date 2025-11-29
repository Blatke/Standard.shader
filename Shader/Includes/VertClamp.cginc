// VertClamp.cginc
/*
vert = vertClamp(
    uv,
    uvMode,
    vertClampMapInvert,
    vertClampMap_d,
    vertClampMapMultiplier,
    vertClampBoundRotateAxis,
    vertClampMapRotate,
    vertClampMorphDistance,
    vertClampMorphStr,
    vertClampMultiplier,
    vertClampOcclusion,
    vertModified,
    vcLower,
    vcUpper,
    dumping,
    isVertClamped,
    vertClampInvert,
    normal
);
*/

#ifndef VERTCLAMP_INCLUDED
#define VERTCLAMP_INCLUDED

#include "UnityCG.cginc"
#include "UV_Transform.cginc"

#ifndef VERT_CLAMP_MAP
    #define VERT_CLAMP_MAP _VertClampMap
#endif

#ifndef VERT_CLAMP_MAP_ST
    #define VERT_CLAMP_MAP_ST _VertClampMap_ST
#endif

uniform sampler2D VERT_CLAMP_MAP;
uniform float4 VERT_CLAMP_MAP_ST;

#define SAMPLE_vertClamp(uv) tex2Dlod(VERT_CLAMP_MAP, float4(uv, 0, 0))

float3 VertClampMorphDistance(float3 vertModified, float3 vcLower, float3 vcUpper, float vertClampMorphDistance, float vertClampMorphStr, float vertClampMultiplier, float3 normal){
    // Morphing by Distance.
    float _d = vertClampMorphDistance * vertClampMultiplier;
    float X;
    float parabolaFactor;
    for (int i=0; i<3; i++){
        if (vertModified[i] > (vcUpper[i] - _d) && vertModified[i] < vcUpper[i]){
            X = (vcUpper[i] - vertModified[i]) / _d;
            parabolaFactor = saturate(4 * X * (1 - X));
            vertModified = lerp(vertModified, vertModified + normal * vertClampMorphStr, parabolaFactor);
        }
        if (vertModified[i] < (vcLower[i] + _d) && vertModified[i] > vcLower[i]){
            float X = (vertModified[i] - vcLower[i]) / _d;
            float parabolaFactor = saturate(4 * X * (1 - X));
            vertModified = lerp(vertModified, vertModified + normal * vertClampMorphStr, parabolaFactor);
        }
    }
    return vertModified;
}

float3x3 GetRotationMatrix(int axis, float angle) {
    float rad = radians(angle);
    float sina = sin(rad);
    float cosa = cos(rad);
    switch (axis){
        case 1: // X
            return float3x3(
                1,   0,    0,
                0, cosa, -sina,
                0, sina,  cosa
            );
            break;
        case 2: // Y
            return float3x3(
                cosa, 0, sina,
                0,    1,   0,
                -sina, 0, cosa
            );
            break;
        case 3:
        default: // Z
            return float3x3(
                cosa, -sina, 0,
                sina,  cosa, 0,
                0,     0,    1
            );
            break;
    }
    return float3x3(1,0,0,0,1,0,0,0,1);
}

float3 vertClamp(
    float2 uv, 
    int uvMode, 
    int vertClampMapInvert, 
    float vertClampMap_d, 
    float vertClampMapMultiplier, 
    float3 vertClampBoundRotateAxis, 
    float vertClampMapRotate, 
    float vertClampMorphDistance, 
    float vertClampMorphStr, 
    float vertClampMultiplier,
    float vertClampOcclusion, 
    float3 vertModified, 
    inout float3 vcLower, 
    inout float3 vcUpper, 
    float dumping, 
    inout float isVertClamped, 
    int vertClampInvert, 
    float3 normal
){
    bool isChanged = false;
    float3 t;
    float3 t_l = float3(0,0,0);
    float3 t_u = float3(0,0,0);
    if (uvMode>0){
        uv = uvRotation(uv, vertClampMapRotate, float2(0.5,0.5), 1, 1);
        uv = TRANSFORM_TEX(uv, VERT_CLAMP_MAP);
        t = SAMPLE_vertClamp(uv).rgb;
        switch (vertClampMapInvert){
            case 0: default: break;
            case 1: t.r = 1 - t.r; break;
            case 2: t.g = 1 - t.g; break;
            case 3: t.b = 1 - t.b; break;
            case 4: t.r = 1 - t.r; t.g = 1 - t.g; break;
            case 5: t.r = 1 - t.r; t.b = 1 - t.b; break;
            case 6: t.g = 1 - t.g; t.b = 1 - t.b; break;
            case 7: t.r = 1 - t.r; t.g = 1 - t.g; t.b = 1 - t.b; break;
        }
        float _d = vertClampMap_d;
        float3 _dividen = (_d-1)*t+1;
        t = (_dividen==0)?_d*t: (_d*t)/_dividen;
        if (uvMode==1){ // vcUpper only.
            t_u = t.rgb;
        }else if (uvMode==2){   // vcLower only.
            t_l = -t.rgb;
        }else{   // Both.
            t_u = t.rgb;
            t_l = -t.rgb;
        }
    }
    vcLower += t_l * vertClampMapMultiplier;
    vcUpper += t_u * vertClampMapMultiplier;
    if (vertClampInvert>0){
        float3 _invert = vcLower;
        vcLower = -vcUpper;
        vcUpper = -_invert;
    }
    // Vertices Rotate to clamp with Bound by vcUpper & vcLower.
    float2 _rvcu[3] = {
        float2(vertClampBoundRotateAxis.z,3),
        float2(vertClampBoundRotateAxis.y,2),
        float2(vertClampBoundRotateAxis.x,1)
    };
    bool _doVertClampRotate = (_rvcu[0]!=0 || _rvcu[1]!=0 || _rvcu[2]!=0);
    float3x3 invRotMat = float3x3(1,0,0,0,1,0,0,0,1);
    float3 clampedRot = vertModified;
    float3 rotatedNormal = normal;
    if (_doVertClampRotate){
        int ii = 0;
        float max_x_abs = abs(_rvcu[0].x);          
        for (int j = 0; j < 3; j++) {
            if (abs(_rvcu[j].x) > max_x_abs) {
                ii = j;
                max_x_abs = abs(_rvcu[j].x);
            }
        }
        float3x3 rotMat; 
        float3 rotVert;          
        if (_rvcu[ii].x != 0){
            rotMat = GetRotationMatrix(_rvcu[ii].y, _rvcu[ii].x);
        }else{
            rotMat = float3x3(1,0,0,0,1,0,0,0,1);
        }
        invRotMat = transpose(rotMat);
        rotVert = mul(rotMat, vertModified);
        clampedRot = rotVert;
        rotatedNormal = normalize(mul(rotMat, normal));
    }
    // Vert Clamping.
    UNITY_UNROLL
    for (int i = 0; i < 3; i++){
        if (clampedRot[i] > vcUpper[i]){
            clampedRot[i] = vcUpper[i] + (clampedRot[i] - vcUpper[i]) * dumping;
            isChanged = true;
        }else if (clampedRot[i] < vcLower[i]){
            clampedRot[i] = vcLower[i] + (clampedRot[i] - vcLower[i]) * dumping;
            isChanged = true;
        }
    }
    if (isChanged){
        vertModified = _doVertClampRotate? mul(invRotMat, clampedRot): clampedRot;
        isVertClamped = vertClampOcclusion;
    }
    if (vertClampMorphDistance>0 && vertClampMorphStr!=0){
        clampedRot = VertClampMorphDistance(clampedRot, vcLower, vcUpper, vertClampMorphDistance, vertClampMorphStr, vertClampMultiplier, rotatedNormal);
        vertModified = _doVertClampRotate? mul(invRotMat, clampedRot) : clampedRot;
    }
    return vertModified;
}

#endif