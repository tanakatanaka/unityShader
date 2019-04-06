// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/MyShader7_1"
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
				float3 lightDir:TEXCOORD1;
				float3 viewDir:TEXCOORD2;
				LIGHTING_COORDS(3, 4)
			};

			vertout vert(appdata_full v)
			{
				vertout OUT;
				OUT.pos = v.vertex;
				OUT.Normal = v.normal;

				return OUT;
			}

			float4 setPos(float s, float t, float4 pos1, float4 pos2, float4 pos3)
			{
				float4 pos = pos1 + (pos2 - pos1) * s + (pos3 - pos1) * t;

				return pos;
			}

			geoout geoouts(float4 pos, float3 nor)
			{
				geoout OUT;
				pos.x += 0.05 * nor.x *sin((pos.y + _Time.x * 3)*3.14159 * 8);
				pos.z += 0.05 * nor.z *sin((pos.y + _Time.x * 3)*3.14159 * 8);
			
				OUT.pos = UnityObjectToClipPos(pos);
				OUT.Normal = nor;
				OUT.lightDir = normalize(ObjSpaceLightDir(pos));
				OUT.viewDir = normalize(ObjSpaceViewDir(pos));

				TRANSFER_VERTEX_TO_FRAGMENT(OUT);
				return OUT;
			}
			
			[maxvertexcount(12)]
			
			void geo(triangle vertout In[3], inout TriangleStream<geoout>TriStream)
			{
				geoout OUT;
				int i;
				float4 pos[6];
				float3 nor[6];

				pos[0] = setPos(0, 0, In[0].pos, In[1].pos, In[2].pos);
				pos[1] = setPos(0.5, 0, In[0].pos, In[1].pos, In[2].pos);
				pos[2] = setPos(1, 0, In[0].pos, In[1].pos, In[2].pos);
				pos[3] = setPos(0, 0.5, In[0].pos, In[1].pos, In[2].pos);
				pos[4] = setPos(0.5, 0.5, In[0].pos, In[1].pos, In[2].pos);
				pos[5] = setPos(0, 1, In[0].pos, In[1].pos, In[2].pos);

				nor[0] = In[0].Normal;
				nor[1] = lerp(In[0].Normal, In[1].Normal, 0.5);
				nor[2] = In[1].Normal;
				nor[3] = lerp(In[0].Normal, In[2].Normal, 0.5);
				nor[4] = lerp(In[1].Normal, In[2].Normal, 0.5);
				nor[5] = In[2].Normal;

				TriStream.Append(geoouts(pos[0], nor[0]));
				TriStream.Append(geoouts(pos[1], nor[1]));
				TriStream.Append(geoouts(pos[3], nor[3]));
				TriStream.Append(geoouts(pos[4], nor[4]));

				TriStream.Append(geoouts(pos[1], nor[1]));
				TriStream.Append(geoouts(pos[3], nor[3]));
				TriStream.Append(geoouts(pos[4], nor[4]));
				TriStream.Append(geoouts(pos[5], nor[5]));

				TriStream.Append(geoouts(pos[4], nor[4]));
				TriStream.Append(geoouts(pos[2], nor[2]));
				TriStream.Append(geoouts(pos[1], nor[1]));

				TriStream.RestartStrip();
			}

			fixed4 frag(geoout In):COLOR
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
