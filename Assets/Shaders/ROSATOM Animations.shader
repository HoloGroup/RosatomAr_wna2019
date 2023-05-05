Shader "ROSATOM Animations" 
 {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
}
SubShader {
	Tags {"Queue" = "Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
	Fog { Mode Off }
//	Pass {
//        ColorMask 0
//    }
    	Blend SrcAlpha OneMinusSrcAlpha
    	ZWrite Off
        Cull Off
        ColorMask RGB
   //     Offset -1,-1
CGPROGRAM
#pragma surface surf NoLighting alpha:blend noambient
#pragma fragmentoption ARB_precision_hint_fastest
#include "UnityCG.cginc"
sampler2D _MainTex;
fixed4 _Color;

struct Input {
	float2 uv_MainTex;
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
	fixed4 c = tex * _Color;
	o.Albedo = c.rgb;
	o.Alpha = c.a * 1;
}
ENDCG
}
FallBack "Legacy Shaders/Reflective/VertexLit"
}
