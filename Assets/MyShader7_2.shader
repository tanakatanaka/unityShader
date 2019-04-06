// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/MyShader7_2"
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

			#pragma multi_compile_fwdbase
			#pragma vertex vert
			#pragma geometry geo
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest
			#include "UnityCG.cginc"
			#include "AutoLight.cginc"
			
			float4 _LightColor0;
			float4 _Diffuse;

			struct vertout
			{
				float4 pos:POSITION;
				float3 Normal:TEXCOORD0;
			};

			struct geoout
			{
				float4 pos:SV_POSITION;
				float3 Normal:TEXCOORD0;
			};

			vertout vert(appdata_full v)
			{
				vertout OUT;
				OUT.pos = v.vertex;
				OUT.Normal = v.normal;

				return OUT;
			}

			geoout geoouts(appdata_full v)
			{
				geoout OUT;
				//pos.x += 0.05 * nor.x *sin((pos.y + _Time.x * 3)*3.14159 * 8);
				//pos.z += 0.05 * nor.z *sin((pos.y + _Time.x * 3)*3.14159 * 8);
			
				OUT.pos = UnityObjectToClipPos(pos);
				OUT.Normal = nor;
				//OUT.lightDir = normalize(ObjSpaceLightDir(pos));
				//OUT.viewDir = normalize(ObjSpaceViewDir(pos));

				//TRANSFER_VERTEX_TO_FRAGMENT(OUT);
				return OUT;
			}
			
			[maxvertexcount(2)]
			
			void geo(point verout In[1], inout LineStream<geoout>LinStream)
			{
				LinStream.Append(geoouts(In[0].pos, In[0].Normal));
				LinStream.Append(geoouts(In[0].pos + float4(In[0].Normal, 1.0), In[0].Normal));
			
				LinStream.RestartStrip();
			
			}

			fixed4 frag(geoout In):COLOR
			{
				float4 color = UNITY_LIGHTMODEL_AMBIENT + _Diffuse * _LightColor0;
				return color;
			}
			ENDCG
		}

		Pass
		{
			Tags
			{
				"LightMode" = "ForwardBase"
			}
			CGPROGRAM
			#pragma multi_compile_fwdbase
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest
			
			#include "UnityCG.cginc"
			#include "AutoLight.cginc"

			float4 _LightColor0;
			float4 _Diffuse;

			struct vertout
			{
				float4 pos:POSITION;
				float3 Normal:TEXCOORD0;
				float3 lightDir:TEXCOORD1;
				float3 viewDir:TEXCOORD2;
				LIGHTING_COORDS(3,4)
			};

			vertout vert(appdata_full v)
			{
				vertout OUT;
				OUT.pos = UnityObjectToClipPos(v.vertex);
				OUT.Normal = v.normal;
				OUT.lightDir = normalize(ObjSpaceLightDir(v.vretex));
				OUT.viewDir = normalize(ObjSpaceViewDir(v.vretex));

				TRANSFER_VERTEX_TO_FRAGMENT(OUT);

				return OUT;
			}

			fixed4 frag(geoout In) :COLOR
			{
				fixed attern = LIGHT_ATTENUATION(In);
				float diffuse = max(0, mul(In.lightDir, In.Normal));
				
				float spevular = max
			}
			ENDCG
		}
    }
    FallBack "Diffuse"
}
