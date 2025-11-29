// UV_Transform.cginc
#ifndef UV_TRANSFORM_INCLUDED
#define UV_TRANSFORM_INCLUDED

#include "IsThisMask.cginc"

float smoothen(float a, float smoothMultiplier){
    if (smoothMultiplier > 0){
        if (a < 1){
            a = smoothstep(0, 1, saturate(a * 1/smoothMultiplier));
        }
    }else{
        a = 1;
    }
    return a;
}

float2 uvRotation(float2 uv, float rt, float2 origin, float alpha, float smoothMultiplier){
    alpha = smoothen(alpha, smoothMultiplier);

    float radians = rt * UNITY_PI / 180.0 * alpha;
    float2 uvRelativeToCenter = uv - origin;

    float2 uvRotatedRelativeToCenter = float2(cos(radians) * uvRelativeToCenter.x - sin(radians) * uvRelativeToCenter.y,
    sin(radians) * uvRelativeToCenter.x + cos(radians) * uvRelativeToCenter.y);
    return uvRotatedRelativeToCenter + origin;
}

float2 uvPosition(float2 uv, float2 move, float2 origin, float alpha, float smoothMultiplier){
    alpha = smoothen(alpha, smoothMultiplier);
    float2 uvRelativeToCenter = uv - origin;
    return lerp(uvRelativeToCenter,uvRelativeToCenter+move,alpha) + origin;
}

float2 uvScale(float2 uv, float2 scale, float2 origin, float alpha, float smoothMultiplier){
    alpha = smoothen(alpha, smoothMultiplier);
    float2 uvRelativeToCenter = uv - origin;
    return lerp(uvRelativeToCenter.xy,uvRelativeToCenter.xy * 1/scale.xy,alpha) + origin;
}

float2 uvTransform(float2 uv, float a, float originX, float originY, float rotate, float positionX, float positionY, float scaleX, float scaleY, float smoothMultiplier, float3 maskRGB, float3 thisRGB, inout bool alreadyComparedResult){
    if (IsThisMask(maskRGB, thisRGB, alreadyComparedResult)){
        uv = uvRotation(uv, rotate, float2(originX,originY), a, smoothMultiplier);
        uv = uvPosition(uv, float2(positionX,positionY), float2(originX,originY), a, smoothMultiplier);
        uv = uvScale(uv, float2(scaleX,scaleY), float2(originX,originY), a, smoothMultiplier);
    }
    return uv;
}

#endif