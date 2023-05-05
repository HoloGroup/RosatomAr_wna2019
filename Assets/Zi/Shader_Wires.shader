// Upgrade NOTE: upgraded instancing buffer 'NewAmplifyShader1' to new syntax.

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader 1"
{
	Properties
	{
		_Fresnel_Power("Fresnel_Power", Float) = 1
		_Fresnel_Scale("Fresnel_Scale", Float) = 1
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma multi_compile_instancing
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
		};

		UNITY_INSTANCING_BUFFER_START(NewAmplifyShader1)
			UNITY_DEFINE_INSTANCED_PROP(float, _Fresnel_Scale)
#define _Fresnel_Scale_arr NewAmplifyShader1
			UNITY_DEFINE_INSTANCED_PROP(float, _Fresnel_Power)
#define _Fresnel_Power_arr NewAmplifyShader1
		UNITY_INSTANCING_BUFFER_END(NewAmplifyShader1)

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color2 = IsGammaSpace() ? float4(0.1886792,0.1886792,0.1886792,0) : float4(0.02968646,0.02968646,0.02968646,0);
			o.Albedo = color2.rgb;
			float4 color6 = IsGammaSpace() ? float4(0.2075472,0.2075472,0.2075472,0) : float4(0.03550519,0.03550519,0.03550519,0);
			float4 color7 = IsGammaSpace() ? float4(0.3890174,0.6894906,0.8867924,0) : float4(0.1253009,0.4331679,0.7615293,0);
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float _Fresnel_Scale_Instance = UNITY_ACCESS_INSTANCED_PROP(_Fresnel_Scale_arr, _Fresnel_Scale);
			float _Fresnel_Power_Instance = UNITY_ACCESS_INSTANCED_PROP(_Fresnel_Power_arr, _Fresnel_Power);
			float fresnelNdotV1 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode1 = ( 0.0 + _Fresnel_Scale_Instance * pow( 1.0 - fresnelNdotV1, _Fresnel_Power_Instance ) );
			float4 lerpResult5 = lerp( color6 , color7 , fresnelNode1);
			o.Emission = lerpResult5.rgb;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float3 worldPos : TEXCOORD1;
				float3 worldNormal : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldNormal = worldNormal;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = IN.worldNormal;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16900
211;25;2222;1293;1092.484;566.2421;1;True;True
Node;AmplifyShaderEditor.RangedFloatNode;3;-793.4839,378.7579;Float;False;InstancedProperty;_Fresnel_Power;Fresnel_Power;0;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-787.4839,289.7579;Float;False;InstancedProperty;_Fresnel_Scale;Fresnel_Scale;1;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;1;-576,296;Float;False;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;6;-774.4839,-193.2421;Float;False;Constant;_Color1;Color 1;0;0;Create;True;0;0;False;0;0.2075472,0.2075472,0.2075472,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;7;-747.4839,40.75787;Float;False;Constant;_Color2;Color 2;0;0;Create;True;0;0;False;0;0.3890174,0.6894906,0.8867924,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;5;-266.4839,116.7579;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;2;-348.4839,-202.2421;Float;False;Constant;_Color0;Color 0;0;0;Create;True;0;0;False;0;0.1886792,0.1886792,0.1886792,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;New Amplify Shader 1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1;2;4;0
WireConnection;1;3;3;0
WireConnection;5;0;6;0
WireConnection;5;1;7;0
WireConnection;5;2;1;0
WireConnection;0;0;2;0
WireConnection;0;2;5;0
ASEEND*/
//CHKSM=3A0FF1B09D748F9D442199A297EC42C06A2AAC30