// Upgrade NOTE: upgraded instancing buffer 'ShureshkiShader' to new syntax.

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ShureshkiShader"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Frequency("Frequency", Float) = 0
		_Amplitude("Amplitude", Float) = 0
		_Vector0("Vector 0", Vector) = (1,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma multi_compile_instancing
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _TextureSample0;
		uniform float _Cutoff = 0.5;

		UNITY_INSTANCING_BUFFER_START(ShureshkiShader)
			UNITY_DEFINE_INSTANCED_PROP(float4, _TextureSample0_ST)
#define _TextureSample0_ST_arr ShureshkiShader
			UNITY_DEFINE_INSTANCED_PROP(float3, _Vector0)
#define _Vector0_arr ShureshkiShader
			UNITY_DEFINE_INSTANCED_PROP(float, _Frequency)
#define _Frequency_arr ShureshkiShader
			UNITY_DEFINE_INSTANCED_PROP(float, _Amplitude)
#define _Amplitude_arr ShureshkiShader
		UNITY_INSTANCING_BUFFER_END(ShureshkiShader)

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 _Vector0_Instance = UNITY_ACCESS_INSTANCED_PROP(_Vector0_arr, _Vector0);
			float3 break3_g2 = _Vector0_Instance;
			float _Frequency_Instance = UNITY_ACCESS_INSTANCED_PROP(_Frequency_arr, _Frequency);
			float mulTime4_g2 = _Time.y * 2.0;
			float _Amplitude_Instance = UNITY_ACCESS_INSTANCED_PROP(_Amplitude_arr, _Amplitude);
			float3 appendResult11_g2 = (float3(break3_g2.x , ( break3_g2.y + ( sin( ( ( break3_g2.x * _Frequency_Instance ) + mulTime4_g2 ) ) * _Amplitude_Instance ) ) , break3_g2.z));
			v.vertex.xyz += appendResult11_g2;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 _TextureSample0_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_TextureSample0_ST_arr, _TextureSample0_ST);
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST_Instance.xy + _TextureSample0_ST_Instance.zw;
			float4 tex2DNode4 = tex2D( _TextureSample0, uv_TextureSample0 );
			float3 temp_cast_0 = (( tex2DNode4.r * 5.0 )).xxx;
			o.Emission = temp_cast_0;
			o.Alpha = 1;
			clip( tex2DNode4.a - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16900
-1734;258;1694;879;1224;160;1;True;True
Node;AmplifyShaderEditor.RangedFloatNode;7;-761,474;Float;False;InstancedProperty;_Frequency;Frequency;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-765,548;Float;False;InstancedProperty;_Amplitude;Amplitude;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;6;-859,291;Float;False;InstancedProperty;_Vector0;Vector 0;4;0;Create;True;0;0;False;0;1,0,0;1,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;4;-598,67;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;7449d83c88016b14f9aa2543a4dcd05a;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;2;-503,289;Float;False;Waving Vertex;-1;;2;872b3757863bb794c96291ceeebfb188;0;3;1;FLOAT3;0,0,0;False;12;FLOAT;0;False;13;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-156,59;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,-1;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;ShureshkiShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;False;Opaque;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;1;6;0
WireConnection;2;12;7;0
WireConnection;2;13;8;0
WireConnection;9;0;4;1
WireConnection;0;2;9;0
WireConnection;0;10;4;4
WireConnection;0;11;2;0
ASEEND*/
//CHKSM=5A8238D5C62C40A802B3EFE3F8AFB0ADA0F1117F