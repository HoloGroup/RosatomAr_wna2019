// Upgrade NOTE: upgraded instancing buffer 'NewAmplifyShader1' to new syntax.

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader 1"
{
	Properties
	{
		_Grid_01_5760x3240("Grid_01_5760x3240", 2D) = "white" {}
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_changeState("changeState", Float) = 0
		_EmStr("EmStr", Float) = 0
		_gridColor("gridColor", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		AlphaToMask On
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma multi_compile_instancing
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Grid_01_5760x3240;
		uniform sampler2D _TextureSample0;

		UNITY_INSTANCING_BUFFER_START(NewAmplifyShader1)
			UNITY_DEFINE_INSTANCED_PROP(float4, _gridColor)
#define _gridColor_arr NewAmplifyShader1
			UNITY_DEFINE_INSTANCED_PROP(float4, _Grid_01_5760x3240_ST)
#define _Grid_01_5760x3240_ST_arr NewAmplifyShader1
			UNITY_DEFINE_INSTANCED_PROP(float4, _TextureSample0_ST)
#define _TextureSample0_ST_arr NewAmplifyShader1
			UNITY_DEFINE_INSTANCED_PROP(float, _EmStr)
#define _EmStr_arr NewAmplifyShader1
			UNITY_DEFINE_INSTANCED_PROP(float, _changeState)
#define _changeState_arr NewAmplifyShader1
		UNITY_INSTANCING_BUFFER_END(NewAmplifyShader1)

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 _gridColor_Instance = UNITY_ACCESS_INSTANCED_PROP(_gridColor_arr, _gridColor);
			float4 _Grid_01_5760x3240_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_Grid_01_5760x3240_ST_arr, _Grid_01_5760x3240_ST);
			float2 uv_Grid_01_5760x3240 = i.uv_texcoord * _Grid_01_5760x3240_ST_Instance.xy + _Grid_01_5760x3240_ST_Instance.zw;
			float4 tex2DNode1 = tex2D( _Grid_01_5760x3240, uv_Grid_01_5760x3240 );
			float _EmStr_Instance = UNITY_ACCESS_INSTANCED_PROP(_EmStr_arr, _EmStr);
			o.Emission = ( ( _gridColor_Instance * tex2DNode1 ) * _EmStr_Instance ).rgb;
			float4 color7 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
			float4 _TextureSample0_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_TextureSample0_ST_arr, _TextureSample0_ST);
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST_Instance.xy + _TextureSample0_ST_Instance.zw;
			float _changeState_Instance = UNITY_ACCESS_INSTANCED_PROP(_changeState_arr, _changeState);
			float lerpResult26 = lerp( tex2D( _TextureSample0, uv_TextureSample0 ).r , 0.0 , _changeState_Instance);
			float4 lerpResult2 = lerp( color7 , tex2DNode1 , lerpResult26);
			o.Alpha = lerpResult2.r;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows exclude_path:deferred 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			AlphaToMask Off
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
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
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
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
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
211;25;2222;1293;1370.715;269.3618;1;True;True
Node;AmplifyShaderEditor.SamplerNode;1;-684.8461,57.87445;Float;True;Property;_Grid_01_5760x3240;Grid_01_5760x3240;0;0;Create;True;0;0;False;0;196e2d8e594bb5140810b762b0970c33;196e2d8e594bb5140810b762b0970c33;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;29;-512.244,-222.3388;Float;False;InstancedProperty;_gridColor;gridColor;4;0;Create;True;0;0;False;0;0,0,0,0;0,0.4811321,0.3296292,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;14;-911.576,432.8762;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;None;f26804096a4b0f64d82a4267fe637056;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;17;-923.2983,641.0882;Float;False;InstancedProperty;_changeState;changeState;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;7;-597.0244,243.1065;Float;False;Constant;_Color0;Color 0;1;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;27;-216.244,151.6612;Float;False;InstancedProperty;_EmStr;EmStr;3;0;Create;True;0;0;False;0;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-271.244,-103.3388;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;26;-541.5993,595.9574;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;12;-1362.215,798.1357;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.1,0.2;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-1161.815,753.0356;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NoiseGeneratorNode;3;-928.2155,748.2356;Float;True;Simplex2D;1;0;FLOAT2;1,1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2;-188.1021,243.9584;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-70.8278,88.6594;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;10;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;89.16519,42.8764;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;New Amplify Shader 1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;True;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;30;0;29;0
WireConnection;30;1;1;0
WireConnection;26;0;14;1
WireConnection;26;2;17;0
WireConnection;11;1;12;0
WireConnection;3;0;11;0
WireConnection;2;0;7;0
WireConnection;2;1;1;0
WireConnection;2;2;26;0
WireConnection;10;0;30;0
WireConnection;10;1;27;0
WireConnection;0;2;10;0
WireConnection;0;9;2;0
ASEEND*/
//CHKSM=001994B228FA57F2B3E6A167B68E97FE724E9F78