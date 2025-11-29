// RecalculateNormals.cginc
#ifndef RECALCULATENORMALS_INCLUDED
#define RECALCULATENORMALS_INCLUDED

// RecalculateNormals(v.vertex.xyz, v.tangent.xyz, v.normal, vertModified, _vertModifiedDistance);

void RecalculateNormals(inout float3 vertex, float3 tangent, inout float3 normal, float3 vertModified, float3 _vertModifiedDistance){
    float3 pos = vertex;
    float3 posPlusTangent = pos + tangent * 0.01;
    float3 posPlusBitangent = pos + cross(normal, tangent) * 0.01;
    _vertModifiedDistance += vertModified - vertex;
    posPlusTangent += _vertModifiedDistance;
    posPlusBitangent += _vertModifiedDistance;
    float3 newTangent = normalize(posPlusTangent - vertModified);
    float3 newBitangent = normalize(posPlusBitangent - vertModified);
    float3 modifiedNormal = cross(newTangent, newBitangent);
    modifiedNormal = normalize(modifiedNormal);
    normal = modifiedNormal;
    vertex = vertModified;
}

#endif