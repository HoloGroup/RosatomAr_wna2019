// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_NoiseTexture("NoiseTexture", 2D) = "white" {}
		_CloudCutoff("CloudCutoff", Float) = 0.16
		_MainTile("MainTile", Float) = 0.1
		_CloudSoftness("CloudSoftness", Float) = 0.1
		_midYValue("midYValue", Float) = 0
		_cloudHeight("cloudHeight", Float) = 0.38
		_TaperPower("TaperPower", Float) = 0
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
		_Speed("Speed", Float) = 0.5
		_L_Bottom_Min("L_Bottom_Min", Float) = 0
		_L_Top_Min("L_Top_Min", Float) = 0
		_L_Bottom_Max("L_Bottom_Max", Float) = 1
		_L_Top_Max("L_Top_Max", Float) = 1
		_Top_power("Top_power", Float) = 1
		_MainWindSpeed("MainWindSpeed", Vector) = (0,0,0,0)
		_MainOpacity("MainOpacity", Float) = 1
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
		struct Input
		{
			float3 worldPos;
			float3 viewDir;
			float2 uv_texcoord;
		};

		uniform float _L_Top_Min;
		uniform float _L_Top_Max;
		uniform float _midYValue;
		uniform float _cloudHeight;
		uniform float _TaperPower;
		uniform float _Top_power;
		uniform float _L_Bottom_Min;
		uniform float _L_Bottom_Max;
		uniform sampler2D _NoiseTexture;
		uniform float _Speed;
		uniform float _MainTile;
		uniform float2 _MainWindSpeed;
		uniform sampler2D _TextureSample2;
		uniform float4 _TextureSample2_ST;
		uniform float _CloudCutoff;
		uniform float _CloudSoftness;
		uniform float _MainOpacity;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float temp_output_32_0 = ( _midYValue - ase_worldPos.y );
			float temp_output_70_0 = ( 1.0 - pow( saturate( ( temp_output_32_0 / ( _cloudHeight * 2.0 ) ) ) , _TaperPower ) );
			float lerpResult126 = lerp( _L_Top_Min , _L_Top_Max , temp_output_70_0);
			float clampResult117 = clamp( ( i.viewDir.y * 10000.0 ) , 0.0 , 1.0 );
			float lerpResult83 = lerp( _L_Bottom_Min , _L_Bottom_Max , temp_output_70_0);
			float3 temp_cast_0 = (( ( pow( lerpResult126 , _Top_power ) * clampResult117 ) + ( lerpResult83 * ( 1.0 - clampResult117 ) ) )).xxx;
			o.Emission = temp_cast_0;
			float2 appendResult5 = (float2(ase_worldPos.x , ase_worldPos.z));
			float mulTime6 = _Time.y * _Speed;
			float2 appendResult7 = (float2(mulTime6 , mulTime6));
			float2 temp_output_133_0 = ( _MainWindSpeed * _Time.y );
			float2 uv_TextureSample2 = i.uv_texcoord * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
			o.Alpha = ( pow( saturate( (0.0 + (( ( tex2D( _NoiseTexture, ( ( ( ( appendResult5 - appendResult7 ) * _MainTile ) * 0.5 ) + temp_output_133_0 ) ).r * tex2D( _NoiseTexture, ( ( _MainTile * ( appendResult5 + appendResult7 ) ) + temp_output_133_0 ) ).r ) * ( 1.0 - pow( saturate( ( abs( temp_output_32_0 ) / ( _cloudHeight * 2.0 ) ) ) , _TaperPower ) ) * tex2D( _TextureSample2, uv_TextureSample2 ).r ) - _CloudCutoff) * (1.0 - 0.0) / (1.0 - _CloudCutoff)) ) , _CloudSoftness ) * _MainOpacity );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows 

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
				surfIN.viewDir = worldViewDir;
				surfIN.worldPos = worldPos;
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
211;25;2222;1293;401.5355;699.7761;1.357164;True;True
Node;AmplifyShaderEditor.RangedFloatNode;46;-2142.18,254.3737;Float;False;Property;_Speed;Speed;8;0;Create;True;0;0;False;0;0.5;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;6;-1920.777,255.1266;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;4;-1902.644,-11.28039;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;7;-1678.082,245.363;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;5;-1658.555,79.38165;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-1481.251,429.6315;Float;False;Property;_midYValue;midYValue;4;0;Create;True;0;0;False;0;0;110.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;31;-1416.251,522.6315;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;16;-1459.233,31.33408;Float;False;Property;_MainTile;MainTile;2;0;Create;True;0;0;False;0;0.1;0.005;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;17;-1462.997,-81.40306;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-1400.235,987.1971;Float;False;Property;_cloudHeight;cloudHeight;5;0;Create;True;0;0;False;0;0.38;8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;32;-1172.651,459.2315;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;132;-968.8304,172.2015;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;131;-974.9991,-44.33656;Float;False;Property;_MainWindSpeed;MainWindSpeed;16;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;13;-1326.914,-187.2829;Float;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;33;-925.3944,467.1756;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-1010.539,983.4951;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-1275.996,-56.60966;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-1456.028,145.1735;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;34;-704,496;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-964.978,-213.3414;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;-770.6845,-38.15887;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;-1155.41,1193.086;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-1254.74,84.76665;Float;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;39;-1348.935,841.0452;Float;False;Property;_TaperPower;TaperPower;6;0;Create;True;0;0;False;0;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;130;-634.1752,80.13858;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;9;-1007.208,-448.3235;Float;True;Property;_NoiseTexture;NoiseTexture;0;0;Create;True;0;0;False;0;16d574e53541bba44a84052fa38778df;8687e96f5e73df142a9181e7c69823a1;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SaturateNode;37;-480,496;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;66;-944.8695,1118.807;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;129;-681.141,-214.678;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-402.2159,-7.448883;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;af52e8219b1161c40877dcd26b2d9a0a;16d574e53541bba44a84052fa38778df;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;68;-542.1929,1094.499;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;38;-267.067,454.5322;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;10;-413.4065,-447.0995;Float;True;Property;_TextureSample1;Texture Sample 1;0;0;Create;True;0;0;False;0;af52e8219b1161c40877dcd26b2d9a0a;16d574e53541bba44a84052fa38778df;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;69;-336.0059,937.1459;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;115;18.66122,1104.227;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-41.85362,-180.442;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;40;-68.20081,452.0658;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;44;-384.5672,214.8589;Float;True;Property;_TextureSample2;Texture Sample 2;7;0;Create;True;0;0;False;0;5228a04ef529d2641937cab585cc1a02;5228a04ef529d2641937cab585cc1a02;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;21;319.6768,-50.93233;Float;False;Property;_CloudCutoff;CloudCutoff;1;0;Create;True;0;0;False;0;0.16;0.06;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;157.4121,-170.1575;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;70;342.0758,1009.787;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;116;298.5408,1135.037;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;10000;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;124;311.6007,532.4611;Float;False;Property;_L_Top_Min;L_Top_Min;12;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;125;312.6006,605.4619;Float;False;Property;_L_Top_Max;L_Top_Max;14;0;Create;True;0;0;False;0;1;0.97;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;20;568.2775,-152.9047;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;126;576.2796,592.047;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;84;306.649,828.4792;Float;False;Property;_L_Bottom_Min;L_Bottom_Min;11;0;Create;True;0;0;False;0;0;-0.91;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;85;307.6489,901.4801;Float;False;Property;_L_Bottom_Max;L_Bottom_Max;13;0;Create;True;0;0;False;0;1;1.18;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;117;514.4849,1133.433;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;128;619.808,743.4412;Float;False;Property;_Top_power;Top_power;15;0;Create;True;0;0;False;0;1;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;83;571.3279,888.0651;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;127;821.6081,665.7722;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;118;717.6198,1125.985;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;22;815.1885,-126.709;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;592.4596,-315.8152;Float;False;Property;_CloudSoftness;CloudSoftness;3;0;Create;True;0;0;False;0;0.1;1.04;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;120;1058.341,678.0812;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;119;1168.546,870.524;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;23;1015.008,-108.359;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;135;1020.772,115.8794;Float;False;Property;_MainOpacity;MainOpacity;17;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-535.0248,2566.047;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3x3;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;55;-32.39365,2543.281;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;29;1057.449,-492.6497;Float;False;Constant;_Color0;Color 0;1;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;134;1239.276,57.52142;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;53;-490.0248,2727.047;Float;False;Property;_OffsetDistance;OffsetDistance;9;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;60;785.0212,2564.184;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;54;-357.0249,2427.046;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;-258.0248,2564.047;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;58;251.5656,2466.124;Float;True;Property;_TextureSample4;Texture Sample 4;11;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;57;235.005,2228.529;Float;True;Property;_TextureSample3;Texture Sample 3;11;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;121;1343.006,642.8862;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;59;640.7213,2467.984;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;56;-219.8387,2180.715;Float;True;Property;_Texture0;Texture 0;10;0;Create;True;0;0;False;0;None;None;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SaturateNode;61;929.3212,2474.484;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;49;-819.6525,2567.142;Float;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldToTangentMatrix;50;-796.0248,2729.047;Float;False;0;1;FLOAT3x3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1562.525,80.38522;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;New Amplify Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;5;True;True;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;0;46;0
WireConnection;7;0;6;0
WireConnection;7;1;6;0
WireConnection;5;0;4;1
WireConnection;5;1;4;3
WireConnection;17;0;5;0
WireConnection;17;1;7;0
WireConnection;32;0;30;0
WireConnection;32;1;31;2
WireConnection;33;0;32;0
WireConnection;36;0;35;0
WireConnection;18;0;17;0
WireConnection;18;1;16;0
WireConnection;8;0;5;0
WireConnection;8;1;7;0
WireConnection;34;0;33;0
WireConnection;34;1;36;0
WireConnection;12;0;18;0
WireConnection;12;1;13;0
WireConnection;133;0;131;0
WireConnection;133;1;132;0
WireConnection;71;0;35;0
WireConnection;15;0;16;0
WireConnection;15;1;8;0
WireConnection;130;0;15;0
WireConnection;130;1;133;0
WireConnection;37;0;34;0
WireConnection;66;0;32;0
WireConnection;66;1;71;0
WireConnection;129;0;12;0
WireConnection;129;1;133;0
WireConnection;1;0;9;0
WireConnection;1;1;130;0
WireConnection;68;0;66;0
WireConnection;38;0;37;0
WireConnection;38;1;39;0
WireConnection;10;0;9;0
WireConnection;10;1;129;0
WireConnection;69;0;68;0
WireConnection;69;1;39;0
WireConnection;19;0;10;1
WireConnection;19;1;1;1
WireConnection;40;0;38;0
WireConnection;43;0;19;0
WireConnection;43;1;40;0
WireConnection;43;2;44;1
WireConnection;70;0;69;0
WireConnection;116;0;115;2
WireConnection;20;0;43;0
WireConnection;20;1;21;0
WireConnection;126;0;124;0
WireConnection;126;1;125;0
WireConnection;126;2;70;0
WireConnection;117;0;116;0
WireConnection;83;0;84;0
WireConnection;83;1;85;0
WireConnection;83;2;70;0
WireConnection;127;0;126;0
WireConnection;127;1;128;0
WireConnection;118;0;117;0
WireConnection;22;0;20;0
WireConnection;120;0;127;0
WireConnection;120;1;117;0
WireConnection;119;0;83;0
WireConnection;119;1;118;0
WireConnection;23;0;22;0
WireConnection;23;1;24;0
WireConnection;51;0;49;0
WireConnection;51;1;50;0
WireConnection;55;0;54;0
WireConnection;55;1;52;0
WireConnection;134;0;23;0
WireConnection;134;1;135;0
WireConnection;60;0;59;0
WireConnection;52;0;51;0
WireConnection;52;1;53;0
WireConnection;58;0;56;0
WireConnection;58;1;55;0
WireConnection;57;0;56;0
WireConnection;121;0;120;0
WireConnection;121;1;119;0
WireConnection;59;0;57;4
WireConnection;59;1;58;4
WireConnection;61;0;60;0
WireConnection;0;2;121;0
WireConnection;0;9;134;0
ASEEND*/
//CHKSM=D322291BCBE184787A22323454D1584D1AA930FD