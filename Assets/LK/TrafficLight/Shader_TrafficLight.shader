// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_T_RGB_01("T_RGB_01", 2D) = "white" {}
		_Red("Red", Float) = 0
		_Green("Green", Float) = 0
		_Blue("Blue", Float) = 0
		_T_TrafficLight_01_AlbedoTransparency("T_TrafficLight_01_AlbedoTransparency", 2D) = "white" {}
		_T_TrafficLight_01_MetallicSmoothness("T_TrafficLight_01_MetallicSmoothness", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _T_TrafficLight_01_AlbedoTransparency;
		uniform float4 _T_TrafficLight_01_AlbedoTransparency_ST;
		uniform sampler2D _T_RGB_01;
		uniform float4 _T_RGB_01_ST;
		uniform float _Red;
		uniform float _Green;
		uniform float _Blue;
		uniform sampler2D _T_TrafficLight_01_MetallicSmoothness;
		uniform float4 _T_TrafficLight_01_MetallicSmoothness_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_T_TrafficLight_01_AlbedoTransparency = i.uv_texcoord * _T_TrafficLight_01_AlbedoTransparency_ST.xy + _T_TrafficLight_01_AlbedoTransparency_ST.zw;
			o.Albedo = tex2D( _T_TrafficLight_01_AlbedoTransparency, uv_T_TrafficLight_01_AlbedoTransparency ).rgb;
			float2 uv_T_RGB_01 = i.uv_texcoord * _T_RGB_01_ST.xy + _T_RGB_01_ST.zw;
			float4 tex2DNode1 = tex2D( _T_RGB_01, uv_T_RGB_01 );
			float4 color12 = IsGammaSpace() ? float4(1,0,0,0) : float4(1,0,0,0);
			float4 color13 = IsGammaSpace() ? float4(1,1,0,0) : float4(1,1,0,0);
			float4 color14 = IsGammaSpace() ? float4(0,1,0,0) : float4(0,1,0,0);
			o.Emission = ( ( tex2DNode1.r * _Red * color12 ) + ( tex2DNode1.g * _Green * color13 ) + ( tex2DNode1.b * _Blue * color14 ) ).rgb;
			float2 uv_T_TrafficLight_01_MetallicSmoothness = i.uv_texcoord * _T_TrafficLight_01_MetallicSmoothness_ST.xy + _T_TrafficLight_01_MetallicSmoothness_ST.zw;
			float4 tex2DNode16 = tex2D( _T_TrafficLight_01_MetallicSmoothness, uv_T_TrafficLight_01_MetallicSmoothness );
			o.Metallic = tex2DNode16.r;
			o.Smoothness = tex2DNode16.a;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16900
581;324;1178;722;999.5986;272.9794;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;2;-1268.507,-5.756688;Float;False;Property;_Red;Red;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1379.506,-197.7567;Float;True;Property;_T_RGB_01;T_RGB_01;0;0;Create;True;0;0;False;0;1e195dff8ccfc914594a76ff3e4e29c7;1e195dff8ccfc914594a76ff3e4e29c7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;3;-1278.46,279.1487;Float;False;Property;_Green;Green;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;12;-1345.859,72.53854;Float;False;Constant;_Color1;Color 1;4;0;Create;True;0;0;False;0;1,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;13;-1349.828,352.7394;Float;False;Constant;_Color2;Color 2;4;0;Create;True;0;0;False;0;1,1,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;-1292.486,536.5412;Float;False;Property;_Blue;Blue;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;14;-1367.828,637.7394;Float;False;Constant;_Color3;Color 3;4;0;Create;True;0;0;False;0;0,1,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-918.6146,-140.7567;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-924.2808,90.55611;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-910.9185,407.5306;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;15;-553.9564,-307.0948;Float;True;Property;_T_TrafficLight_01_AlbedoTransparency;T_TrafficLight_01_AlbedoTransparency;4;0;Create;True;0;0;False;0;16f5f5c6dba8dad4ba54a7aea955eeb8;16f5f5c6dba8dad4ba54a7aea955eeb8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-566.9992,-28.34378;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;16;-505.6093,138.1356;Float;True;Property;_T_TrafficLight_01_MetallicSmoothness;T_TrafficLight_01_MetallicSmoothness;5;0;Create;True;0;0;False;0;20fb775438c148c459bb0020a0d9b61b;20fb775438c148c459bb0020a0d9b61b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;102,-3;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;New Amplify Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;5;0;1;1
WireConnection;5;1;2;0
WireConnection;5;2;12;0
WireConnection;6;0;1;2
WireConnection;6;1;3;0
WireConnection;6;2;13;0
WireConnection;7;0;1;3
WireConnection;7;1;4;0
WireConnection;7;2;14;0
WireConnection;8;0;5;0
WireConnection;8;1;6;0
WireConnection;8;2;7;0
WireConnection;0;0;15;0
WireConnection;0;2;8;0
WireConnection;0;3;16;1
WireConnection;0;4;16;4
ASEEND*/
//CHKSM=4079457E224A914486AE13B20EBC29500BB600E2