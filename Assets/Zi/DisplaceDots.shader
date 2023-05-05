// Upgrade NOTE: upgraded instancing buffer 'DisplaceDots' to new syntax.

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "DisplaceDots"
{
	Properties
	{
		_Float0("Float 0", Float) = 0
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_image_20190829_191041("image_2019-08-29_19-10-41", 2D) = "white" {}
		_EmStr("EmStr", Float) = 0
		_DotsColor("DotsColor", Color) = (0.004449993,0.611092,0.9433962,1)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 4.6
		#pragma multi_compile_instancing
		#pragma surface surf Unlit alpha:fade keepalpha exclude_path:deferred vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _TextureSample0;
		uniform float _Float0;
		uniform sampler2D _image_20190829_191041;

		UNITY_INSTANCING_BUFFER_START(DisplaceDots)
			UNITY_DEFINE_INSTANCED_PROP(float4, _TextureSample0_ST)
#define _TextureSample0_ST_arr DisplaceDots
			UNITY_DEFINE_INSTANCED_PROP(float4, _image_20190829_191041_ST)
#define _image_20190829_191041_ST_arr DisplaceDots
			UNITY_DEFINE_INSTANCED_PROP(float4, _DotsColor)
#define _DotsColor_arr DisplaceDots
			UNITY_DEFINE_INSTANCED_PROP(float, _EmStr)
#define _EmStr_arr DisplaceDots
		UNITY_INSTANCING_BUFFER_END(DisplaceDots)

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float4 _TextureSample0_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_TextureSample0_ST_arr, _TextureSample0_ST);
			float2 uv_TextureSample0 = v.texcoord * _TextureSample0_ST_Instance.xy + _TextureSample0_ST_Instance.zw;
			float4 tex2DNode8 = tex2Dlod( _TextureSample0, float4( uv_TextureSample0, 0, 0.0) );
			float3 ase_vertexNormal = v.normal.xyz;
			v.vertex.xyz += ( tex2DNode8.r * ( ase_vertexNormal * _Float0 ) );
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 _image_20190829_191041_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_image_20190829_191041_ST_arr, _image_20190829_191041_ST);
			float2 uv_image_20190829_191041 = i.uv_texcoord * _image_20190829_191041_ST_Instance.xy + _image_20190829_191041_ST_Instance.zw;
			float4 tex2DNode13 = tex2D( _image_20190829_191041, uv_image_20190829_191041 );
			float4 _DotsColor_Instance = UNITY_ACCESS_INSTANCED_PROP(_DotsColor_arr, _DotsColor);
			float _EmStr_Instance = UNITY_ACCESS_INSTANCED_PROP(_EmStr_arr, _EmStr);
			o.Emission = ( ( tex2DNode13 * _DotsColor_Instance ) * _EmStr_Instance ).rgb;
			float4 _TextureSample0_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_TextureSample0_ST_arr, _TextureSample0_ST);
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST_Instance.xy + _TextureSample0_ST_Instance.zw;
			float4 tex2DNode8 = tex2D( _TextureSample0, uv_TextureSample0 );
			float lerpResult15 = lerp( 0.0 , tex2DNode13.r , tex2DNode8.r);
			o.Alpha = lerpResult15;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16900
110;123;1291;549;904.437;-105.2453;1;True;True
Node;AmplifyShaderEditor.NormalVertexDataNode;17;-681.0851,544.5161;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;19;-696.6848,701.816;Float;False;Property;_Float0;Float 0;0;0;Create;True;0;0;False;0;0;0.015;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;24;-554.4923,-253.1937;Float;False;InstancedProperty;_DotsColor;DotsColor;4;0;Create;True;0;0;False;0;0.004449993,0.611092,0.9433962,1;0.004449993,0.611092,0.9433962,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;13;-830.7954,-29.91232;Float;True;Property;_image_20190829_191041;image_2019-08-29_19-10-41;2;0;Create;True;0;0;False;0;85cc02d619290cd44a8f9d671b7f52d9;85cc02d619290cd44a8f9d671b7f52d9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-449.6846,708.316;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-284.552,-261.4871;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-328.552,97.51288;Float;False;InstancedProperty;_EmStr;EmStr;3;0;Create;True;0;0;False;0;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;8;-797.5753,358.0409;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;f26804096a4b0f64d82a4267fe637056;f9852cf15baa7f145878a587a01d7e8a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-219.3285,459.9358;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;15;-235.4832,197.8263;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-140.6049,5.996765;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;10;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-632.0285,274.9356;Float;False;InstancedProperty;_Float1;Float 1;5;0;Create;True;0;0;False;0;8;8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;12;34,-40;Float;False;True;6;Float;ASEMaterialInspector;0;0;Unlit;DisplaceDots;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;1;1;8;0;False;1;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;18;0;17;0
WireConnection;18;1;19;0
WireConnection;27;0;13;0
WireConnection;27;1;24;0
WireConnection;21;0;8;1
WireConnection;21;1;18;0
WireConnection;15;1;13;1
WireConnection;15;2;8;1
WireConnection;25;0;27;0
WireConnection;25;1;26;0
WireConnection;12;2;25;0
WireConnection;12;9;15;0
WireConnection;12;11;21;0
ASEEND*/
//CHKSM=53F6D94D86C43E212FFEA1D15BE2B937B2292E91