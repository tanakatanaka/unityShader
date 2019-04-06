// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/MyShader6_3"
{
	Properties
	{
		_Diffuse("Diffuse Color", COLOR) = (0.5, 0.5, 0.5, 1.0)
	}

		SubShader
	{
		Pass
		{
			Tags
			{
				"LightMode" = "ForwardBase"
			}

			CGPROGRAM
			#pragma multi_compile_fwbase
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest

			#include "UnityCG.cginc"
			#include "AutoLight.cginc"

			float4 _LightColor0;
			float4 _Diffuse;

			struct vertout
			{
				float4 pos : SV_POSITION;
				float3 Normal : TEXCOORD0;
				float3 lightDir : TEXCOORD1;
				float3 viewDir : TEXCOORD2;
				LIGHTING_COORDS(3, 4)
			};

			vertout vert(appdata_full v)
			{
				vertout OUT;
				OUT.pos = UnityObjectToClipPos(v.vertex);
				OUT.Normal = normalize(v.normal).xyz;
				OUT.lightDir = normalize(ObjSpaceViewDir(v.vertex));
				OUT.viewDir = normalize(ObjSpaceViewDir(v.vertex));
				TRANSFER_VERTEX_TO_FRAGMENT(OUT);

				return OUT;
			}

			fixed4 frag(vertout In) : COLOR
			{
				fixed attern = LIGHT_ATTENUATION(In);
				float diffuse = max(0, mul(In.lightDir, In.Normal));
				float specular = max(0, mul(normalize(In.viewDir + In.lightDir), In.Normal));
				specular = pow(specular, 30);
				float4 color = UNITY_LIGHTMODEL_AMBIENT + (_Diffuse * _LightColor0 * diffuse + _LightColor0
					* half4(1.0, 1.0, 1.0, 1.0) * specular ) * attern;

				return color;
			}
			ENDCG
		}
    }
    FallBack "Diffuse"
}
