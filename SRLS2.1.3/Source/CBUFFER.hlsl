CBUFFER_START(UnityPerMaterial)
    float _is_front;
    float4 _BaseMap_ST;
    float4 _SpecularColor;
    float4  _EmissiongColor;
    float4 _RimColor;
    float _Smoothness;
    float _ShadowShiftForRamp;
    float _shadowSmooth;
    float _ShadowCenterShift;
    float _ShadowSmoothness;
    float _ShadowRange;

   /* float _lightmapA0; 
    float _lightmapA1;  
    float _lightmapA2; 
    float _lightmapA3;  
    float _lightmapA4;
    float _lightmapA5;
    float _lightmapA6;
    float _lightmapA7;*/

    float _BrightRange;
    float _SpecularStrenth;
    float _MetalSpecular;
    float _NonMetalSpecular;
    float _MetalRange;
    float _BnmpIntemsity;
    float _EmissiongIntensity;
    float _RimStrenth;
    float _fresnelRange;
    float _fresnelThreshold;
    float _OffsetMul;
    float _rimThreshold;
    float _FlushStrenth;
    float _OutlineWidth;
    float _SkinSaturation;
    float _AlphaForStencil;
    float _StockingsTransitionPower;
    float _StockingsTransitionHardness;
    float _StockingsTransitionThrehold;
    float3 _StockingsDarkColor;
    float3 _StockingsTransitionColor;
    float3  _StockingsLightColor;
    float3 _FlushColor;
    float3 _outlineColor0;  //描边颜色1
    float3 _outlineColor1;  //描边颜色2
    float3 _outlineColor2;  //描边颜色3
    float3 _outlineColor3;  //描边颜色4
    float3 _outlineColor4;  //描边颜色5
    float3 _outlineColor5;
    float3 _outlineColor6;
    float3 _outlineColor7;
    TEXTURE2D(_BaseMap);
    SAMPLER(sampler_BaseMap);

    TEXTURE2D(_LightMap);
    SAMPLER(sampler_LightMap);

    TEXTURE2D(_MetalMap);
    SAMPLER(sampler_MetalMap);

    TEXTURE2D(_BumpMap);
    SAMPLER(sampler_BumpMap);

    
    SAMPLER(sampler_FaceMap);
    TEXTURE2D(_FaceMap);

    TEXTURE2D(_RampMap_Warm);
    SAMPLER(sampler_RampMap_Warm);
    TEXTURE2D(_RampMap_Cool);
    SAMPLER(sampler_RampMap_Cool);

    TEXTURE2D(_StockingsMap);
    SAMPLER(sampler_StockingsMap);
    float4 _StockingsMap_ST;

    float3 _Front = float3(0.0,0.0,1.0);
    float3 _Right = float3(1.0,0.0,0.0);

CBUFFER_END