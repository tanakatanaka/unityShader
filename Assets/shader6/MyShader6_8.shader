// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/MyShader6_8"
{
	Properties
	{
		_Diffuse("Diffuse Color", color) = (0.5, 0.5, 0.5, 1.0)
		//_Bump("Bump", 2D) = "white"{}
		//_Cubemap("Cubemap", CUBE) = ""{}
		//_Texture("Texture", 2D) = "white"{}
	}

	SubShader
	{
		Tags
		{
			"Queue" = "Transparent"
			"RenderType" = "Transparent"
		}

		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha
			CGPROGRAM
			#pragma multi_compile_fwbase
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "AutoLight.cginc"

			float4 _LightColor0;
			float4 _Color;

			struct vertout
			{
				float4 pos : SV_POSITION;
				float3 viewDir : TEXCOORD1;
				float3 normal : TEXCOORD2;
			};

			vertout vert(appdata_full v)
			{
				vertout OUT;
				OUT.pos = UnityObjectToClipPos(v.vertex);
				OUT.viewDir = normalize(ObjSpaceViewDir(v.vertex));
				OUT.normal = v.normal;

				return OUT;
			}

			fixed4 frag(vertout In) : COLOR
			{
				float alpha = pow(max(0, dot(In.viewDir, In.normal)), 3);
				float4 color = _Color;
				color.a = alpha;

				return color;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
