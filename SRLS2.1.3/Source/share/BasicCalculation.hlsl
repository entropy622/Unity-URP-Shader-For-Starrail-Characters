/////////////////preparatiom//////////////
half4 BaseMapColor = SAMPLE_TEXTURE2D(_BaseMap,sampler_BaseMap,input.uv);
half4 LightMapColor = SAMPLE_TEXTURE2D(_LightMap,sampler_LightMap,input.uv);
//half4 LightMapColorReverse = SAMPLE_TEXTURE2D(_LightMap,sampler_LightMap,float2(1-input.uv.x,input.uv.y));//在脸部的着色器中，LightMap代表FaceMap
//Basic Date//
float3 positionWS = float3(input.TtoW0.w,input.TtoW1.w,input.TtoW2.w);
float4 positionNDC = input.positionNDC ;
float3 positionVS = input.positionVS.rgb;
float3 normalTS = UnpackNormal(SAMPLE_TEXTURE2D(_BumpMap,sampler_BumpMap,input.uv)).xyz;
normalTS.xy *= _BnmpIntemsity;
normalTS.z = sqrt(1.0-saturate(dot(normalTS.xy,normalTS.xy)));
float3 normalWS = SafeNormalize(float3(dot(input.TtoW0.xyz,normalTS),dot(input.TtoW1.xyz,normalTS),dot(input.TtoW2.xyz,normalTS)));
float3 normalVS = normalize(TransformWorldToViewNormal(normalWS));
float2 matcapUV = normalVS.xy*0.5+0.5;
float2 ScreenUV = input.positionNDC.xy/input.positionNDC.w;
Light light = GetMainLight();
float3 lightdirWS = normalize(light.direction);
float3 viewdirWS = SafeNormalize(GetCameraPositionWS()-positionWS);
float3 hdirWS = normalize(lightdirWS+viewdirWS);
float NdotV = dot(normalWS,viewdirWS);
float NdotL = dot(normalWS,lightdirWS);
float Lambert = saturate(NdotL);
half BlingPhong = pow(saturate(dot(normalWS,hdirWS)),_Smoothness);
float HalfLambert = pow((NdotL*0.5+0.5),2);