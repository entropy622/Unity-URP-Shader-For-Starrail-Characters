#ifndef OUTLINE_HLSL
#define OUTLINE_HLSL

#pragma vertex vert  
#pragma fragment frag
float GetCameraFOV()
{
//Shader中获取相机FOV
//https://answers.unity.com/questions/770838/how-can-i-extract-the-fov-information-from-the-pro.html
    float t = unity_CameraProjection._m11;
    float Rad2Deg = 180 / 3.1415;
    float fov = atan(1.0f / t) * 2.0 * Rad2Deg;
    return fov;
}
float ApplyOutlineDistanceFadeOut(float distanceVS)
{
    return max(0.0, (50.0 - distanceVS) * 0.1);
}
float GetOutlineCameraFOVAndDistanceFixMultiplier(float positionVS_Z)/////From NiloToon
{
    float distanceFix;
    if(unity_OrthoParams.w == 0)
    {
        //透视相机
        float distance = abs(positionVS_Z);
        distanceFix = ApplyOutlineDistanceFadeOut(distance);
        distanceFix *= GetCameraFOV();
    }
    else
    {
        //正交相机
        float distance = abs(unity_OrthoParams.z);
        distanceFix = ApplyOutlineDistanceFadeOut(distance); //参考NiloToon的数值
    }
    return distanceFix;
}
v2f vert(a2v input)
{

    v2f output;
    float4 ScaledScreenParams = GetScaledScreenParams();
    float ScreenAspectRatio = abs(ScaledScreenParams.x/ScaledScreenParams.y);
    input.normalOS.x *=ScreenAspectRatio;
    
    /*VertexPositionInputs vertex_position_inputs = GetVertexPositionInputs(input.positionOS);
    float3 NormalDirWS = TransformObjectToWorldNormal(input.normalOS,true);//When rendering back fragmant,the normal should be reversed.
    float3 TangentDirWS = TransformObjectToWorldDir(input.tangentOS,true);
    float3 BinormalDirWS = cross(NormalDirWS,TangentDirWS)*input.tangentOS.w;
    float3 positiongWS = vertex_position_inputs.positionWS;
    output.TtoW0 = float4(TangentDirWS.x,BinormalDirWS.x,NormalDirWS.x,positiongWS.x);
    output.TtoW1 = float4(TangentDirWS.y,BinormalDirWS.y,NormalDirWS.y,positiongWS.z);
    output.TtoW2 = float4(TangentDirWS.z,BinormalDirWS.z,NormalDirWS.z,positiongWS.y);
    SAMPLE_TEXTURE2D(_BumpMap,sampler_BumpMap,input.uv);
    float3 normalTS = UnpackNormal(SAMPLE_TEXTURE2D(_BumpMap,sampler_BumpMap,input.uv)).xyz;
    normalTS.z = sqrt(1.0-saturate(dot(normalTS.xy,normalTS.xy)));
    float3 normalWS = SafeNormalize(float3(dot(output.TtoW0.xyz,normalTS),dot(output.TtoW1.xyz,normalTS),dot(output.TtoW2.xyz,normalTS)));
    float normalOS = normalize(TransformWorldToObject(normalWS));*///描边时运用法线贴图
    
    float OutlineWidth =_OutlineWidth;
    float3 PosisionVS = TransformWorldToView(TransformObjectToWorld(input.positionOS));
    float disdanceFix = GetOutlineCameraFOVAndDistanceFixMultiplier(PosisionVS.z);
    output.positionCS = TransformObjectToHClip(float4(input.positionOS+input.normalOS*OutlineWidth*disdanceFix*0.000002));
    output.uv =input.uv;
    return output;
}
float4 frag(v2f input):SV_Target
{
	float4 LightMapColor = SAMPLE_TEXTURE2D(_LightMap,sampler_LightMap,input.uv);

     //分离lightmap.a各材质
    float lightmapA1 = step(0.08, LightMapColor.a);  
    float lightmapA2 = step(0.21, LightMapColor.a);  
    float lightmapA3 = step(0.33, LightMapColor.a); 
    float lightmapA4 = step(0.46, LightMapColor.a);
    float lightmapA5 = step(0.58, LightMapColor.a);
    float lightmapA6 = step(0.70, LightMapColor.a);
    float lightmapA7 = step(0.83, LightMapColor.a);
    float lightmapA8 = step(0.96, LightMapColor.a);  

    //重组lightmap.a
    float3 outlineColor = _outlineColor0;  //0.0
    outlineColor = lerp(outlineColor, _outlineColor1, lightmapA1);  
    outlineColor = lerp(outlineColor, _outlineColor2, lightmapA2);  
    outlineColor = lerp(outlineColor, _outlineColor3, lightmapA3);  
    outlineColor = lerp(outlineColor, _outlineColor4, lightmapA4);  
    outlineColor = lerp(outlineColor, _outlineColor5, lightmapA5);  
    outlineColor = lerp(outlineColor, _outlineColor6, lightmapA6);  
    outlineColor = lerp(outlineColor, _outlineColor7, lightmapA7);  
	return float4(outlineColor.rgb,1.0);
}

#endif
