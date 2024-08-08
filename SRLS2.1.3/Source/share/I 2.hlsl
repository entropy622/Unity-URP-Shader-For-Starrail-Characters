
Shader "Unlit/SRLS1.0"
{
    Properties
    {
        _BaseMap ("Base Texture",2D) = "white"{}
        _LightMap("LightMap(If face,select FaceMap)",2D) = "white"{}
        [Toggle(_USE_VERTEX_COLOR)]_Use_Vertex_Color("Use VertexColor(For mmd model,turn off)",Float)=0
        [Toggle(_IS_HAIR)]_isHair("isHair",float)=0
        [Toggle(_IS_FACE)]_isFace("isFace",float)=0
        [Toggle(_IS_Eye)]_isEye("isEye",float)=0
        //_BumpMap("BumpMap",2D) = "bump"{}
        //_BnmpIntemsity("BnmpIntemsity",Range(0.0,1.0))=1.0
        _EmissiongIntensity("EmissiongIntensity",Range(0.0,10.0))=0.75
        _EmissiongColor("EmissiongColor",Color)=(1,1,1,1)
        _SkinSaturation("SkinSaturation",Range(0.0,5.0))=1.7
        
        
        
        [Header(Metal and Speculer)]
        //[Toggle(_USE_METAL)]_Use_Metal("Use metal",float)=1
        _MetalMap ("MetalMap",2D) = "white"{}
        _Smoothness("Smoothness",Float) = 7
        _NonMetalSpecular("NonMetalSpecular",Range(0.0,10.0))=5
        _MetalSpecular("MetalSpecular",Range(0.0,10.0))=5
        
        [Header(Shadow and Ramp)]
        [Toggle(_USE_WARM_TINT)]_Use_Warm_Tint("Use Warm Tint Ramp",float)=1
        _RampMap_Cool ("RampMap(cool)",2D) = "white"{}
        _RampMap_Warm ("RampMap(warm)",2D) = "white"{}
        //_ShadowAttenuation("ShadowAttenuation",Range(-1,1))=0.5
        //_ShadowCenterShift("ShadowCenterShift",Range(-1.0,1.0))=0
        _ShadowShiftForRamp("_ShadowShiftForRamp",range(0.0,1.0))=0.75
        _shadowSmooth("_shadowSmooth",Range(0.0,1.0))=0.1
        
        /*_lightmapA0("0.02_Ramp条数" , Range(1, 8)) = 1
        _lightmapA1("0.15_Ramp条数" , Range(1, 8)) = 6
        _lightmapA2("0.27_Ramp条数" , Range(1, 8)) = 3
        _lightmapA3("0.40_Ramp条数" , Range(1, 8)) = 8
        _lightmapA4("0.52_Ramp条数" , Range(1, 8)) = 5
        _lightmapA5("0.65_Ramp条数" , Range(1, 8)) = 2
        _lightmapA6("0.78_Ramp条数" , Range(1, 8)) = 7
        _lightmapA7("0.90_Ramp条数" , Range(1, 8)) = 4*/
        
        [Header(OutLine)]
        _OutlineWidth("OutlineWidth",Float) = 0.5   //For mmd model,the recommanded value is 16
        _outlineColor0( "描边颜色1" , color) = (1.0, 0.0, 0.0, 0.0)
        _outlineColor1( "描边颜色2" , color) = (0.0, 1.0, 0.0, 0.0)
        _outlineColor2( "描边颜色3" , color) = (0.0, 0.0, 1.0, 0.0)
        _outlineColor3( "描边颜色4" , color) = (1.0, 1.0, 0.0, 0.0)
        _outlineColor4( "描边颜色5" , color) = (0.5, 0.0, 1.0, 0.0)
        
        [Header(Face)]

        _FaceMap("FaceMap",2D) = "white"{}
        
        [Header(Rim)]
        _RimStrenth("RimStrenth",Range(0.0,1.0))=0.35
        _fresnelRange("fresnelRange",Float) = 1.2
        _fresnelThreshold("fresnelThreshold",Float)=0.65
        _OffsetMul("_RimWidth:offsetMul", Range(0, 100)) = 0.002
        _rimThreshold("_RimThreshold", Range(0, 1)) = 0.542
        _RimColor("RimColor",Color)=(1,1,1,1)
        
        [Header(Stencil)]
        _StencilRef("StencilRef",Range(0,255)) = 0
        //StencilRef ("Stencil reference (Default 0)", Range(0,255))=0
        [Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil comparison (Default disabled)",Int ) = 0
        [Enum(UnityEngine.Rendering.StencilOp)]_StencilPassOp ("Stencil pass operation (Default keep)",Int ) = 0
        [Enum(UnityEngine.Rendering.StencilOp)]_StencilFailOp ("Stencil fail operation (Default keep)", Int) = 0
        [Enum(UnityEngine.Rendering.Stencil0p)]_StencilZFailOp ("Stencil Z fail operation (Default keep)",Int) = 0[Header(Surface Options)]
        
        [Enum(UnityEngine.Rendering.CullMode)]_Cull ("Cull (Default back)", Float) = 2
        [Enum(UnityEngine.Rendering.BlendMode)]_SrcBlendMode ("Src blend mode (Default One)",Float) = 1
        [Enum(UnityEngine.Rendering.BlendMode)]_DstBlendMode ("Dst blend mode (Default Zero)", Float) = 0
        [Enum(UnityEngine.Rendering.BlendOp)]_Blendop ("Blend operation (Default Add)", Float) = 0
        [Enum(Off, 0, On, 1)] _Zwrite("ZWrite (Default On)", Float) = 1

        [Header(Draw Overlay)]
        [Toggle(_DRAW_OVERLAY_ON)] _UseDrawOverlay("Use draw overlay (Default NO)", float) = 0
        [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendModeOverlay ("Overlay pass src blend mode (Default One)",Float ) = 1
        [Enum(UnityEngine.Rendering.BlendMode)] _DstBlendModeOverlay ("Overlay pass dst blend mode (Default Zero)",Float ) = 0
        [Enum(UnityEngine.Rendering.Blend0p)] _BlendOpOverlay ("Overlay pass blend operation (Default Add)",Float ) = 0
        StencilRefOverlay ("Overlay pass stencil reference (Default 0)", Range(0,255)) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)]StencilCompOverlay ("Overlay pass stencil comparison (Default disabled)",Int) = 0

        //[Enum(UnityEngine.Rendering.)] _DstBlendAlpha("Dst Blend (A)", Float) = 0
        [Header(Stokings)]
        _StockingsMap("StockingsMap",2D) = "black"{}
        _StockingsTransitionPower("StockingsTransitionPower",Float)=1
        _StockingsTransitionHardness("StockingsTransitionHardness",Float)=0
        _StockingsTransitionThrehold("StockingsTransitionThrehold",Range(0.0,1.0))=0.58
        _StockingsDarkColor("StockingsDarkColor",Color)=(0,0,0,1)
        _StockingsTransitionColor("StockingsTransitionColor",Color)=(0.360381, 0.242986, 0.358131,1)
        _StockingsLightColor("StockingsLightColor",Color)=(1.8, 1.48299, 0.856821,1)
        
        
    }
    SubShader
    {
        Tags{"RenderPipeline" = "UniversalPipeline"}
        HLSLINCLUDE
        #pragma shader_feature_local_fragment _IS_FACE
        #pragma  shader_feature_local_fragment _USE_METAL
        #pragma  shader_feature_local_fragment _IS_HAIR
        #pragma  shader_feature_local_fragment _USE_WARM_TINT
        #pragma  shader_feature_local _USE_VERTEX_COLOR
        #pragma  shader_feature_local _IS_Eye
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareDepthTexture.hlsl"

        #include "CBUFFER.hlsl"

        struct a2v
        {
            float4 positionOS :POSITION;
            float4 tangentOS : TANGENT;
            float4 normalOS :NORMAL;
            float2 uv : TEXCOORD;
            float4 vertexcolor :COLOR;
        };
        struct v2f
        {
            float4 positionCS : SV_POSITION;
            float2 uv : TEXCOORD0;
            float4 TtoW0 :TEXCOORD1;
            float4 TtoW1 :TEXCOORD2;
            float4 TtoW2 :TEXCOORD3;
            float3 positionVS :TEXCOORD4;
            float4 positionNDC : TEXCOORD5;
            float4 vertexcolor : TEXCOORD6;///r对应阴影遮罩？,g 控制了对阴影阈值的偏移，a对应描边粗细
           
            //float3 positionWS : TEXCOORD1;
            //float3 normalWS : TEXCOORD3;
        };        
        ENDHLSL
        Pass //DepthOnly
        {
            Name "DepthNormals"
            Tags{"LightMode" = "DepthNormals"}
            ZWrite On
            Cull[_Cull]
            HLSLPROGRAM
            #include "share/DepthNormalOnly.hlsl"
            ENDHLSL
        }
        Pass //背面
        {
            Tags{"LightMode"="backward" }
            Cull Front
            ZWrite Off
            Blend [_SrcBlendMode] [_DstBlendMode]
            BlendOp [_Blendop]
            Stencil
            {
                Ref [_StencilRef]
                Comp [_StencilComp]
                Pass [_StencilPassOp]
                Fail [_StencilFailOp]
                ZFail [_StencilZFailOp]
            }
            HLSLPROGRAM
            #pragma vertex vert
            #include "Core.hlsl"
            v2f vert(a2v input)
            {
                v2f output;
                VertexPositionInputs vertex_position_inputs = GetVertexPositionInputs(input.positionOS);
                output.positionCS = vertex_position_inputs.positionCS;
                output.vertexcolor = input.vertexcolor;
                float3 NormalDirWS = -TransformObjectToWorldNormal(input.normalOS,true);//When rendering back fragmant,the normal should be reversed.
                float3 TangentDirWS = TransformObjectToWorldDir(input.tangentOS,true);
                float3 BinormalDirWS = cross(NormalDirWS,TangentDirWS)*input.tangentOS.w;
                float3 positiongWS = vertex_position_inputs.positionWS;
                output.TtoW0 = float4(TangentDirWS.x,BinormalDirWS.x,NormalDirWS.x,positiongWS.x);
                output.TtoW1 = float4(TangentDirWS.y,BinormalDirWS.y,NormalDirWS.y,positiongWS.z);
                output.TtoW2 = float4(TangentDirWS.z,BinormalDirWS.z,NormalDirWS.z,positiongWS.y);
                output.positionVS = vertex_position_inputs.positionVS;
                output.uv=TRANSFORM_TEX(input.uv,_BaseMap);
                output.positionNDC = vertex_position_inputs.positionNDC;
                return output;
            }
            ENDHLSL
        }
        Pass //正面
        {
            Tags{"LightMode"="forward" }
            Cull Back
            ZWrite Off
            Blend [_SrcBlendMode] [_DstBlendMode]
            BlendOp [_Blendop]
            Stencil
            {
                Ref [_StencilRef]
                Comp [_StencilComp]
                Pass [_StencilPassOp]
                Fail [_StencilFailOp]
                ZFail [_StencilZFailOp]
            }
            HLSLPROGRAM
            #pragma vertex vert
            v2f vert(a2v input)
            {
                v2f output;
                VertexPositionInputs vertex_position_inputs = GetVertexPositionInputs(input.positionOS);
                output.positionCS = vertex_position_inputs.positionCS;
                output.vertexcolor = input.vertexcolor;
                float3 NormalDirWS = TransformObjectToWorldNormal(input.normalOS,true);
                float3 TangentDirWS = TransformObjectToWorldDir(input.tangentOS,true);
                float3 BinormalDirWS = cross(NormalDirWS,TangentDirWS)*input.tangentOS.w;
                float3 positiongWS = vertex_position_inputs.positionWS;
                output.TtoW0 = float4(TangentDirWS.x,BinormalDirWS.x,NormalDirWS.x,positiongWS.x);
                output.TtoW1 = float4(TangentDirWS.y,BinormalDirWS.y,NormalDirWS.y,positiongWS.z);
                output.TtoW2 = float4(TangentDirWS.z,BinormalDirWS.z,NormalDirWS.z,positiongWS.y);
                output.positionVS = vertex_position_inputs.positionVS;
                output.uv=TRANSFORM_TEX(input.uv,_BaseMap);
                output.positionNDC = vertex_position_inputs.positionNDC;
                return output;
            }
            #include "Core.hlsl"
            ENDHLSL
        }
        Pass //Outline
        {
            Name "OutLine"
            Tags{ "LightMode" = "outline" }
	        Cull front 
	        HLSLPROGRAM
	        #include "OutLine.hlsl"
	        ENDHLSL
        }
    }
}
