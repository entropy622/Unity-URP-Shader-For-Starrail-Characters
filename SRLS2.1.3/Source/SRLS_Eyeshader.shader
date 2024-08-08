Shader "Unlit/Eyeshader"
{
    Properties
    {
        _BaseColor("BaseColor",Color)=(0,0,0,1)
        //_Alpha("Alpha",Range(0.0,1.0))=0.2
    }
    SubShader
    {
        Tags
        {
            
            "RenderPipeline" = "UniversalPipeline"
            //"LightMode"="UniversalForward"

        }
        HLSLINCLUDE
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareDepthTexture.hlsl"
        CBUFFER_START(UnityPerMaterial)
            float4 _BaseColor;
            float _Alpha;
        CBUFFER_END
            struct a2v
            {
                float4 positionOS :POSITION;
            };
            struct v2f
            {
                float4 positionCS : SV_POSITION;
            };        
        ENDHLSL
        Pass //Main
        {
            Tags{"LightMode"="UniversalForward" "Queue"="Transparent""RenderType"="Transparent"}
            Cull Off
            ZWrite Off
            Blend DstColor Zero
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            v2f vert(a2v input)
            {
                v2f output;
                output.positionCS = TransformObjectToHClip(input.positionOS);
                return output;
            }
            float4 frag(v2f input):SV_Target
            {
                return float4(_BaseColor.rgb,_Alpha);
            }
            
            ENDHLSL
        }
    }
}

