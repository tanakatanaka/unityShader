Shader "Custom/MyShader18"
{
	Properties
	{
		_Diffuse("Diffuse Color", Color) = (1.0, 1.0, 1.0, 1.0)
		_DispTex("Disp Texture", 2D) = "gray"{}
		_Displacement("Displacement", Range(0, 0.2)) = 0.1	
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
		#pragma surface surf Lambert addshadow fullforwardshadows vertex:vert tessellate:tess

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

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

		float4 tess()
		{
			return 10;
		}

		void vert(inout appdata v)
		{
			float2 uv = TRANSFORM_TEX(v.texcoord, _DispTex);
			float tex = tex2Dlod(_DispTex, float4(uv, 0, 0)).r;
			v.vertex.xyz += v.normal * tex * _Displacement;
		}

        struct Input
        {
			float color : COLOR;
		};

		//sampler2D _Texture;
		float4 _Diffuse;

        void surf (Input IN, inout SurfaceOutput o)
        {
			o.Albedo = _Diffuse;
		}
        ENDCG
    }
    FallBack "Diffuse"
}
