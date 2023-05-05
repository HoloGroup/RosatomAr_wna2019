Shader "ROSATOM Insides" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_ReflectColor ("Reflection Color", Color) = (1,1,1,0.5)
	_MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
	_Cube ("Reflection Cubemap", Cube) = "_Skybox" {}
}
SubShader {
	Tags {"Queue" = "Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
	Pass {
        ColorMask 0
    }
    	Blend SrcAlpha OneMinusSrcAlpha
    	ZWrite Off
        Cull Back
CGPROGRAM
#pragma surface surf NoLighting alpha:blend  noambient
#pragma fragmentoption ARB_precision_hint_fastest
#include "UnityCG.cginc"
sampler2D _MainTex;
samplerCUBE _Cube;
fixed4 _Color;
fixed4 _ReflectColor;
struct Input {
	float2 uv_MainTex;
	float3 worldRefl;
};
     fixed4 LightingNoLighting(SurfaceOutput s, fixed3 lightDir, fixed atten)
     {
         fixed4 c;
         c.rgb = s.Albedo;
         c.a = s.Alpha;
         return c;
     }
void surf (Input IN, inout SurfaceOutput o) {
	fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
	fixed4 reflcol = texCUBE (_Cube, IN.worldRefl);
	fixed4 c = tex * _Color;
	o.Albedo = c.rgb;
	o.Emission = reflcol.rgb * _ReflectColor.rgb;
	o.Alpha = _Color.a;
}
ENDCG
}
FallBack "Legacy Shaders/Reflective/VertexLit"
}
