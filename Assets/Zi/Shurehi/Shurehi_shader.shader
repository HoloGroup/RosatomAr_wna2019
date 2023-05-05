// Upgrade NOTE: upgraded instancing buffer 'Shurehi_shader' to new syntax.

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Shurehi_shader"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_EmStr("EmStr", Float) = 2
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma multi_compile_instancing
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _TextureSample0;
		uniform float _Cutoff = 0.5;

		UNITY_INSTANCING_BUFFER_START(Shurehi_shader)
			UNITY_DEFINE_INSTANCED_PROP(float4, _TextureSample0_ST)
#define _TextureSample0_ST_arr Shurehi_shader
			UNITY_DEFINE_INSTANCED_PROP(float, _EmStr)
#define _EmStr_arr Shurehi_shader
		UNITY_INSTANCING_BUFFER_END(Shurehi_shader)

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 _TextureSample0_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_TextureSample0_ST_arr, _TextureSample0_ST);
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST_Instance.xy + _TextureSample0_ST_Instance.zw;
			float4 tex2DNode2 = tex2D( _TextureSample0, uv_TextureSample0 );
			float _EmStr_Instance = UNITY_ACCESS_INSTANCED_PROP(_EmStr_arr, _EmStr);
			o.Emission = ( tex2DNode2 * _EmStr_Instance ).rgb;
			o.Alpha = 1;
			clip( tex2DNode2.a - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16900
-1734;258;1694;879;806.1044;382.9973;1;True;True
Node;AmplifyShaderEditor.SamplerNode;2;-579,73;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;058f0d4357b01324dbe15904b6bddee9;058f0d4357b01324dbe15904b6bddee9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-412,-70;Float;False;InstancedProperty;_EmStr;EmStr;3;0;Create;True;0;0;False;0;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-151,79;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-420,275;Float;False;InstancedProperty;_Opacity;Opacity;1;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;9;48,-13;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Shurehi_shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;2;0
WireConnection;3;1;5;0
WireConnection;9;2;3;0
WireConnection;9;10;2;4
ASEEND*/
//CHKSM=6BC8695886B02C7581D344BF2680EC12F1C479C5