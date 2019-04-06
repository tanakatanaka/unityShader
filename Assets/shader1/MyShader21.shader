Shader "Custom/MyShader21"
{
	Properties
	{
		_Diffuse("Diffuse Color", Color) = (1.0, 1.0, 1.0, 1.0)
		_Phong("Phong", Range(0, 0.5)) = 0
		//_DispTex("Disp Texture", 2D) = "gray"{}
		//_Displacement("Displacement", Range(0, 0.2)) = 0.1
		//_Texture("Texture", 2D) = "white"{}
	}

	SubShader
	{
		Tags
		{
			"RenderType" = "Opaque"
			//"Queue" = "TransParent"
		}

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		//#pragma surface surf Standard fullforwardshadows
		#pragma surface surf Lambert addshadow fullforwardshadows vertex:vert tessellate:tess tessphong:_Phong

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0
		#include "Tessellation.cginc"

		struct appdata
		{
			float4 vertex:POSITION;
			float4 tangent:TANGENT;
			float3 normal:NORMAL;
			float2 texcoord:TEXCOORD0;
		};

		float _Displacement;
		sampler2D _DispTex;
		float4 _DispTex_ST;

		void vert(inout appdata v)
		{
			//処理なし
		}

		float _Phong;

		float4 tess(appdata v0, appdata v1, appdata v2)
		{
			//return UnityDistanceBasedTess(v0.vertex, v1.vertex, v2.vertex, minDist, maxDist, 10);
			return UnityEdgeLengthBasedTess(v0.vertex, v1.vertex, v2.vertex, 5);
		}


		struct Input
		{
			float color : COLOR;
		};

		//sampler2D _Texture;
		float4 _Diffuse;

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = _Diffuse;
		}
		ENDCG
	}
		FallBack "Diffuse"
}
