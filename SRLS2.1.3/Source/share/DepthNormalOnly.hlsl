

#pragma target 2.0

// -------------------------------------
// Shader Stages
#pragma vertex DepthNormalsVertex
#pragma fragment DepthNormalsFragment

// -------------------------------------
// Material Keywords
#pragma shader_feature_local _NORMALMAP
#pragma shader_feature_local _PARALLAXMAP
#pragma shader_feature_local _ _DETAIL_MULX2 _DETAIL_SCALED
#pragma shader_feature_local _ALPHATEST_ON
#pragma shader_feature_local_fragment _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A

// -------------------------------------
// Unity defined keywords
#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE

// -------------------------------------
// Universal Pipeline keywords
#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"

//--------------------------------------
// GPU Instancing
#pragma multi_compile_instancing
#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"

// -------------------------------------
// Includes
#include "Packages/com.unity.render-pipelines.universal/Shaders/LitInput.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Shaders/LitDepthNormalsPass.hlsl"
