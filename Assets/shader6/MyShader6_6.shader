// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/MyShader6_6"
{
	Properties
	{
		_Diffuse("Diffuse Color", color) = (0.5, 0.5, 0.5, 1.0)
		_Bump("Bump", 2D) = "white"{}
		_Cubemap("Cubemap", CUBE) = ""{}
		//_Texture("Texture", 2D) = "white"{}
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
			//sampler2D _Texture;
			//float4 _Texture_ST;
			sampler2D _Bump;
			float4 _Bump_ST;
			samplerCUBE _Cubemap;

			struct vertout
			{
				float4 pos : SV_POSITION;
				float2 TexCoord:TEXCOORD0;
				//float3 Normal:TEXCOORD2;
				float3 lightDir : TEXCOORD1;
				float3 viewDir : TEXCOORD2;
				float3 TangentRX : TEXCOORD3;
				float3 TangentRY : TEXCOORD4;
				float3 TangentRZ : TEXCOORD5;

				LIGHTING_COORDS(6, 7)
			};

			vertout vert(appdata_full v)
			{
				vertout OUT;
				OUT.pos = UnityObjectToClipPos(v.vertex);
				OUT.TexCoord = TRANSFORM_TEX(v.texcoord, _Bump);
				TANGENT_SPACE_ROTATION;
				OUT.TangentRX = mul( rotation, unity_ObjectToWorld[0].xyz);
				OUT.TangentRY = mul( rotation, unity_ObjectToWorld[1].xyz);
				OUT.TangentRZ = mul(rotation, unity_ObjectToWorld[2].xyz);
				//OUT.Normal = normalize(v.normal).xyz;
				OUT.lightDir = normalize(ObjSpaceViewDir(v.vertex));
				OUT.viewDir = normalize(ObjSpaceViewDir(v.vertex));
				TRANSFER_VERTEX_TO_FRAGMENT(OUT);

				return OUT;
			}

			fixed4 frag(vertout In) : COLOR
			{
				fixed attern = LIGHT_ATTENUATION(In);
				float3 bumpNormal = UnpackNormal(tex2D(_Bump, In.TexCoord));
				float3 normal;
				normal.x = dot(In.TangentRX, bumpNormal);
				normal.y = dot(In.TangentRY, bumpNormal);
				normal.z = dot(In.TangentRZ, bumpNormal);
				float diffuse = max(0, mul(In.lightDir, normal));

				float specular = max(0, mul(normalize(In.viewDir + In.lightDir), normal));
				specular = pow(specular, 30);
				//float4 tex = tex2D(_Texture, In.TexCoord);
				float4 reflectVec;
				reflectVec.xyz = reflect(-In.viewDir, normal);
				reflectVec.w = 1;
				float4 Emission = texCUBE( _Cubemap, reflectVec );

				float4 color = (UNITY_LIGHTMODEL_AMBIENT + ( _Diffuse * _LightColor0 * diffuse + _LightColor0
					* half4(1.0, 1.0, 1.0, 1.0) * specular ) * attern) + Emission;

				return color;
			}
			ENDCG
		}

		Pass
		{
			Tags
			{
				"LightMode" = "ForwardAdd"
			}
			Blend One One
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
					* half4(1.0, 1.0, 1.0, 1.0) * specular) * attern;

				return color;
			}
			ENDCG
		}

    }
    FallBack "Diffuse"
}
