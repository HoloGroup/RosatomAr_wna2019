// Upgrade NOTE: upgraded instancing buffer 'ASESampleShadersRimLight' to new syntax.

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/RimLight"
{
	Properties
	{
		_RimPower("RimPower", Range( 0 , 10)) = 0
		_Opacity("Opacity", Float) = 0
		_EmStr("EmStr", Float) = 0
		_time("time", Float) = 1
		_Speed("Speed", Vector) = (0.5,0.4,0,0)
		_Line("Line", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma multi_compile_instancing
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			half2 uv_texcoord;
		};

		uniform half _RimPower;
		uniform sampler2D _Line;

		UNITY_INSTANCING_BUFFER_START(ASESampleShadersRimLight)
			UNITY_DEFINE_INSTANCED_PROP(half2, _Speed)
#define _Speed_arr ASESampleShadersRimLight
			UNITY_DEFINE_INSTANCED_PROP(half, _EmStr)
#define _EmStr_arr ASESampleShadersRimLight
			UNITY_DEFINE_INSTANCED_PROP(half, _time)
#define _time_arr ASESampleShadersRimLight
			UNITY_DEFINE_INSTANCED_PROP(half, _Opacity)
#define _Opacity_arr ASESampleShadersRimLight
		UNITY_INSTANCING_BUFFER_END(ASESampleShadersRimLight)

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 color46 = IsGammaSpace() ? half4(0.1722588,0.650824,0.745283,0) : half4(0.02510984,0.3811233,0.5152035,0);
			float4 color47 = IsGammaSpace() ? half4(0.08397117,0.4058363,0.4811321,0) : half4(0.007712823,0.1369954,0.196991,0);
			float3 ase_worldPos = i.worldPos;
			half3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			half3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV45 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode45 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV45, _RimPower ) );
			float4 lerpResult44 = lerp( color46 , color47 , fresnelNode45);
			float _EmStr_Instance = UNITY_ACCESS_INSTANCED_PROP(_EmStr_arr, _EmStr);
			o.Emission = ( lerpResult44 * _EmStr_Instance ).rgb;
			float _time_Instance = UNITY_ACCESS_INSTANCED_PROP(_time_arr, _time);
			float mulTime42 = _Time.y * _time_Instance;
			float2 _Speed_Instance = UNITY_ACCESS_INSTANCED_PROP(_Speed_arr, _Speed);
			float2 panner34 = ( mulTime42 * _Speed_Instance + float2( 0,0 ));
			float2 uv_TexCoord36 = i.uv_texcoord + panner34;
			float _Opacity_Instance = UNITY_ACCESS_INSTANCED_PROP(_Opacity_arr, _Opacity);
			o.Alpha = ( tex2D( _Line, uv_TexCoord36 ).r * _Opacity_Instance );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Unlit alpha:fade keepalpha fullforwardshadows 

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
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float3 worldNormal : TEXCOORD3;
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
				o.worldNormal = worldNormal;
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
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = IN.worldNormal;
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
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
}
/*ASEBEGIN
Version=16900
211;25;2222;1293;799.5698;180.1723;1;True;True
Node;AmplifyShaderEditor.RangedFloatNode;39;-1362.997,1032.105;Float;False;InstancedProperty;_time;time;5;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;42;-1126.069,1092.36;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;40;-1135.997,923.105;Float;False;InstancedProperty;_Speed;Speed;6;0;Create;True;0;0;False;0;0.5,0.4;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;28;-894,532;Float;False;Property;_RimPower;RimPower;1;0;Create;True;0;0;False;0;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;34;-798.9968,887.105;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0.27,0;False;1;FLOAT;1.15;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;46;-450.093,-86.70251;Float;False;Constant;_Color0;Color 0;8;0;Create;True;0;0;False;0;0.1722588,0.650824,0.745283,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;45;-533.3596,502.3585;Float;False;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;47;-449.093,167.2975;Float;False;Constant;_Color1;Color 1;8;0;Create;True;0;0;False;0;0.08397117,0.4058363,0.4811321,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;36;-516.9968,804.1049;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;44;-146.9324,242.9819;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-249.9014,514.111;Float;False;InstancedProperty;_EmStr;EmStr;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;43;-226.4673,782.5354;Float;True;Property;_Line;Line;7;0;Create;True;0;0;False;0;4d0db22d3ec2ef2479468804d148ef94;4d0db22d3ec2ef2479468804d148ef94;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;29;28.09863,979.111;Float;False;InstancedProperty;_Opacity;Opacity;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;5;-908,-5;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;21;-1152,496;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;22;-1628,533;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;3;-1552,144;Float;True;Property;_Normals;Normals;2;0;Create;True;0;0;False;0;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalizeNode;23;-1344,576;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-43.90137,389.111;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;26;-717,43;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;25;-1096,-274;Float;False;Property;_RimColor;RimColor;0;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-643.2028,-80.1008;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;20;-1085,-21;Float;False;1;0;FLOAT;1.23;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;246.4302,774.8277;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;465.2,346.6;Half;False;True;2;Half;;0;0;Unlit;ASESampleShaders/RimLight;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;3;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;4;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;42;0;39;0
WireConnection;34;2;40;0
WireConnection;34;1;42;0
WireConnection;45;3;28;0
WireConnection;36;1;34;0
WireConnection;44;0;46;0
WireConnection;44;1;47;0
WireConnection;44;2;45;0
WireConnection;43;1;36;0
WireConnection;5;0;20;0
WireConnection;21;0;3;0
WireConnection;21;1;23;0
WireConnection;23;0;22;0
WireConnection;30;0;44;0
WireConnection;30;1;31;0
WireConnection;26;0;5;0
WireConnection;27;0;26;0
WireConnection;27;1;25;0
WireConnection;20;0;21;0
WireConnection;48;0;43;1
WireConnection;48;1;29;0
WireConnection;0;2;30;0
WireConnection;0;9;48;0
ASEEND*/
//CHKSM=1429E57B87E04E0F328FE1D677E3F8D96CC14CCB