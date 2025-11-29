// IsThisMask.cginc
#ifndef ISTHISMASK_INCLUDED
#define ISTHISMASK_INCLUDED

bool IsThisMask(float3 maskRGB, float3 thisRGB, inout bool alreadyComparedResult){
    if (!alreadyComparedResult){
        if (maskRGB.r==thisRGB.r && maskRGB.g==thisRGB.g && maskRGB.b == thisRGB.b){
            alreadyComparedResult = true;
            return true;
        }else{
            return false;
        }
    }else{
        return true;
    }
}

#endif