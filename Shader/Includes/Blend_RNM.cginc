// Blend_RNM.cginc
#ifndef BLEND_RNM_INCLUDED
#define BLEND_RNM_INCLUDED

float3 blend_rnm(float3 n1, float3 n2, float s1, float s2){
    /*
    Where n1 and n2 are unpacked normals 1 and 2; s1 and s2 are the strengths of n1 and n2.
    Reoriented Normal Mapping, sourced from:
    //https://blog.selfshadow.com/publications/blending-in-detail/
    https://github.com/bgolus/Normal-Mapping-for-a-Triplanar-Shader/blob/master/TriplanarSurfaceShader.shader
    */
        float3 r = float3(0,0,1);
        if (s1>0 && s2>0){
            n1.z += 1;
            n2.xy = -n2.xy;
            n1.xy *= s1;
            n2.xy *= s2;
            r = n1 * dot(n1, n2) / n1.z - n2;
        }else if((s1==0) && (n2.z>0 && s2>0)){
            r.xy = n2.xy*s2;
            r.z = n2.z;
        }else if((s1>0) && (n2.z==0 || s2==0)){
            r.xy = n1.xy*s1;
            r.z = n1.z;
        }
        return r;
}

#endif