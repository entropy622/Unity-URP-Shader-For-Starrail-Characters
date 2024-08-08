#ifndef CORE_HLSL
#define CORE_HLSL

#pragma fragment frag
float3 EnhanceSaturation(float3 color,float saturation)
{
    float gray = dot(color, float3(0.299, 0.587, 0.114));
    return  lerp(gray, color, saturation); 
}
float4 TransformHClipToViewPortPos(float4 positionCS)
{
    float4 output = positionCS*0.5f;
    output.xy=float2(output.x,output.y*_ProjectionParams.x)+output.w;
    output.zw =positionCS.zw;
    return  output/output.w;
}
struct Gradient
{
    int GradientLength;
    float4 color[8];
};
Gradient GradientConstruct()
{
    Gradient g;
    g.GradientLength = 3;
    for (int i = 0; i < 3; ++i)
    {
        g.color[i]=float4(1,1,1,0);
    }
    return g;
}
float3 SamplerGradient(Gradient Gradient,float Time)
{
    float3 color = Gradient.color[0].rgb;
    for (int i = 1; i < 3; ++i)
    {
        float colorpos = saturate((Time-Gradient.color[i-1].w)/Gradient.color[i].w-Gradient.color[i-1].w)*step(color,Gradient.GradientLength-1);
        color = lerp(color,Gradient.color[i].rgb,colorpos);
    }
    return color;
}
float IsSkin(float2 UV)
{
    #if _IS_HAIR
        return 0;
    #else
        #if _IS_FACE || _IS_Eye
            half4 FaceMapColor = SAMPLE_TEXTURE2D(_FaceMap,sampler_FaceMap,UV);
            half4 FaceMapReverseColor = SAMPLE_TEXTURE2D(_FaceMap,sampler_FaceMap,float2(1-UV.x,UV.y));
            return saturate(step(FaceMapColor.a,0.9)+step(FaceMapReverseColor.a,0.9));
        #else
            half4 LightMapColor = SAMPLE_TEXTURE2D(_LightMap,sampler_LightMap,UV);
            return step(LightMapColor.a,0.1);
        #endif
    #endif
}
float GetShadow(float NdotL,float4 LightMapColor,float3 lightdirWS,float2 UV,float vertexColorR)
{
    float shadow;
    #if _IS_FACE || _IS_Eye//do SDF
        float FrontL = dot(normalize(_Front.xz), normalize(lightdirWS.xz));
        float RightL = dot(normalize(_Right.xz), normalize(lightdirWS.xz));
        float Bright_Side_is_Right =step(0,RightL);
        RightL = (0.5 - acos(RightL)/3.14159265)*2;//If we take the angle between the lightdir and rightdir as W. Then 1 present W is 0; 0 present W is 90 point
        float2 FaceUV;
        FaceUV.x = lerp(1-UV.x,UV.x,Bright_Side_is_Right);
        FaceUV.y = UV.y;
        float4 FaceMapColor = SAMPLE_TEXTURE2D(_FaceMap,sampler_FaceMap,FaceUV);
        shadow = (FrontL > 0) * min((FaceMapColor.a > RightL),(FaceMapColor.a > -RightL));
        float is_Eye = step(0.1,SAMPLE_TEXTURE2D(_FaceMap,sampler_FaceMap,UV));
        shadow = lerp(shadow,1,is_Eye);
    #else
        float AO = LightMapColor.r;
        #if _USE_VERTEX_COLOR
            AO*=vertexColorR;
        #endif
        float NdotL01 = NdotL*0.5+0.5;
        shadow = smoothstep(1-LightMapColor.g+_ShadowCenterShift-_shadowSmooth,1-LightMapColor.g+_ShadowCenterShift+_shadowSmooth,NdotL01);
        shadow *= AO;
    #endif
    shadow =shadow*(1-_ShadowShiftForRamp)+_ShadowShiftForRamp;
    return shadow;
}
float3 GetRamp(float RampU,float4 LightMapColor)
{
    float RampV;
    #if _IS_HAIR
        RampV = 0.5;
    #else
        #if _IS_FACE || _IS_Eye
            RampV = 0.0625;
        #else
            /////////用公式计算Ramp,但似乎在佩拉身上不准确(比如帽子部分)////////////////////
            float rawIndex=round(LightMapColor.a*8.04+0.81);
            float rampRowIndex=lerp(fmod((rawIndex+4),8),rawIndex,fmod(rawIndex,2));
            RampV = (2 * rampRowIndex - 1)  / 16;
            //////////Fine-tune the ramp manually//////////////////
            /*float ramp0 = _lightmapA0 * -0.125 + 1.0625 ;  //0.02
            float ramp1 = _lightmapA1 * -0.125 + 1.0625 ;  //0.15
            float ramp2 = _lightmapA2 * -0.125 + 1.0625 ;  //0.27
            float ramp3 = _lightmapA3 * -0.125 + 1.0625 ;  //0.40
            float ramp4 = _lightmapA4 * -0.125 + 1.0625 ;  //0.52
            float ramp5 = _lightmapA5 * -0.125 + 1.0625 ;  //0.65
            float ramp6 = _lightmapA6 * -0.125 + 1.0625 ;  //0.78
            float ramp7 = _lightmapA7 * -0.125 + 1.0625 ;  //0.90
            float lightmapA1 = step(0.08, LightMapColor.a);  
            float lightmapA2 = step(0.21, LightMapColor.a);  
            float lightmapA3 = step(0.33, LightMapColor.a); 
            float lightmapA4 = step(0.46, LightMapColor.a);
            float lightmapA5 = step(0.58, LightMapColor.a);
            float lightmapA6 = step(0.70, LightMapColor.a);
            float lightmapA7 = step(0.83, LightMapColor.a);  
            RampV = ramp0;  
            RampV = lerp(RampV, ramp1, lightmapA1); 
            RampV = lerp(RampV, ramp2, lightmapA2); 
            RampV = lerp(RampV, ramp6, lightmapA6);
            RampV = lerp(RampV, ramp7, lightmapA7);
            RampV = lerp(RampV, ramp3, lightmapA3);  
            RampV = lerp(RampV, ramp4, lightmapA4);
            RampV = lerp(RampV, ramp5, lightmapA5);*/
        #endif
    #endif

    #if _USE_WARM_TINT
        float3 ramp =  SAMPLE_TEXTURE2D(_RampMap_Warm,sampler_RampMap_Warm,float2(RampU,RampV));
    #else
        float3 ramp =  SAMPLE_TEXTURE2D(_RampMap_Cool,sampler_RampMap_Cool,float2(RampU,RampV));
    #endif

    return ramp;
}
float3 GetDiffuse(float3 Ramp,float4 BaseMapColor,float NdotL,float4 LightMapColor,float2 UV)//The final diffuse for each materials
{
    float3 diffuse=BaseMapColor*Ramp;
    diffuse = lerp(diffuse,EnhanceSaturation(diffuse,_SkinSaturation),IsSkin(UV));
    #if _IS_FACE || _IS_Eye
        diffuse +=BaseMapColor.a*_EmissiongColor*_EmissiongIntensity;//Emission for Eyes
    #endif
    return diffuse;
}
float3 GetSpecular(float4 LightMapColor,float2 matcapUV,float blingphong,float4 BaseMapColor)
{
    float3 specular;
    #if _IS_FACE || _IS_Eye
        specular = 0.0;
    #else
        float is_metal;
        #if _IS_HAIR
            is_metal=0.0;
        #else
            is_metal = step(0,(LightMapColor.b-0.45));//around 0.52 reprents the metal
        #endif
        float3 MatCap = SAMPLE_TEXTURE2D(_MetalMap,sampler_MetalMap,matcapUV);
        float3 MetalicSpec = blingphong*LightMapColor.b*_MetalSpecular*MatCap.r*BaseMapColor;
        float3 NonMetalicSpec = LightMapColor.b*step(1.04-blingphong,LightMapColor.b)*_NonMetalSpecular*BaseMapColor;
        specular = lerp(NonMetalicSpec,MetalicSpec,is_metal);
    #endif
    return specular;
}
float3 GetRim(float2 ScreenUV,float3 positionVS,float3 normalVS,float NdotV)//等距屏幕空间边缘光+菲涅尔
{
    float depth =SampleSceneDepth(ScreenUV);
    float linear_depth = LinearEyeDepth(depth,_ZBufferParams);
    float3 offsetPositionVS = float3(positionVS.xy+normalVS.xy*_OffsetMul,positionVS.z);
    float4 offsetPositionCS = TransformWViewToHClip(offsetPositionVS);
    float4 offsetPositionVP = TransformHClipToViewPortPos(offsetPositionCS);
    float linear_offsetdepth = LinearEyeDepth(SampleSceneDepth(offsetPositionVP),_ZBufferParams);
    float diff = linear_offsetdepth-linear_depth;
    float Fresnel = step(_fresnelThreshold,pow(1-NdotV,_fresnelRange));
    return _RimColor*step(_rimThreshold,diff)*_RimStrenth*Fresnel;
}
float3 GetStockins(float NdotV,float2 UV)
{
    float4 StockingsMapColor = SAMPLE_TEXTURE2D(_StockingsMap,sampler_StockingsMap, UV);
    StockingsMapColor.b = SAMPLE_TEXTURE2D(_StockingsMap,sampler_StockingsMap, TRANSFORM_TEX(UV,_StockingsMap)).b;
    float fac = pow(saturate(NdotV),_StockingsTransitionPower);
    fac = saturate((fac-_StockingsTransitionHardness/2)*(1-_StockingsTransitionHardness));
    fac = lerp(fac,1,StockingsMapColor.g);
    //fac *= StockingsMapColor.b;  //用的时候感觉很奇怪,没加b通道细节.
    Gradient curve = GradientConstruct();
    curve.GradientLength = 3;
    curve.color[0]=float4(_StockingsDarkColor,0);
    curve.color[1]=float4(_StockingsTransitionColor,_StockingsTransitionThrehold);
    curve.color[2]=float4(_StockingsLightColor,1);
    float3 stockingsColor = SamplerGradient(curve,fac);
    stockingsColor = lerp(1,stockingsColor,StockingsMapColor.r);
    return  stockingsColor;
}

float4 frag(v2f input):SV_Target
{
    #include "share/BasicCalculation.hlsl"
    float shadow = GetShadow(NdotL,LightMapColor,lightdirWS,input.uv,input.vertexcolor.r);
    float3 ramp = GetRamp(shadow,LightMapColor);
    float3 diffuse = GetDiffuse(ramp,BaseMapColor,NdotL,LightMapColor,input.uv);
    float3 Stockings = GetStockins(NdotV,input.uv);
    diffuse *= Stockings;
    float3 rim = GetRim(ScreenUV,positionVS,normalVS,NdotV);
    float3 specular = GetSpecular(LightMapColor,matcapUV,BlingPhong,BaseMapColor);
    
    float4 outcolor;
    #if  _IS_FACE || _IS_Eye
        outcolor = float4(specular+diffuse+rim,1.0);
    #elif _IS_HAIR
        float NdotF = dot(normalize(viewdirWS.xz),normalize(_Front.xz));
        float AlphaForStencil = (1-(saturate(NdotF)))*(_AlphaForStencil)+1-_AlphaForStencil;
        AlphaForStencil = lerp(1.0,AlphaForStencil,input.is_overlay*step(0,NdotF));
        outcolor = float4(specular+diffuse+rim,AlphaForStencil);
    #else
        outcolor = float4(specular+diffuse+rim,BaseMapColor.a);
    #endif
    return outcolor ;
}

#endif
