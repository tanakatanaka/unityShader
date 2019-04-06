// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/MyShader6_1"
{
	SubShader
    {
		Pass
		{
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			float4 vert(float4 v:POSITION) : SV_POSITION
			{
				return UnityObjectToClipPos(v);
			}

			fixed frag() : COLOR
			{
				return fixed4(1.0, 0.0, 0.0, 1.0);
			}
			ENDCG
		}
    }
    FallBack "Diffuse"
}
