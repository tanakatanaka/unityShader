Shader "Custom/MyShader11"
{
	Properties
	{
		_DiffuseColor("Diffuse Color", Color) = (1.0, 1.0, 1.0) 
		_Cube("Cubemap", CUBE) = ""{}
		_Bump("Bump", 2D) = "white"{}
	}

    SubShader
    {
        Tags 
		{
			//"Queue" = "TransParent"
			"RenderType"="Opaque" 
		}
		CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        //#pragma surface surf Standard fullforwardshadows
		#pragma surface surf Lambert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        struct Input
        {
			float2 uv_Bump;
			float3 worldRefl;
			INTERNAL_DATA
		};

		//sampler2D _Bump;
		float3 _DiffuseColor;
		samplerCUBE _Cube;
		sampler2D _Bump;

        void surf (Input IN, inout SurfaceOutput o)
        {
			o.Albedo = _DiffuseColor * 0.5;
			o.Normal = UnpackNormal(tex2D(_Bump, IN.uv_Bump));
			o.Emission = texCUBE(_Cube, IN.worldRefl).rgb;
			
		}
        ENDCG
    }
    FallBack "Diffuse"
}
