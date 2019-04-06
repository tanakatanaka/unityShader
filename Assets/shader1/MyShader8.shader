Shader "Custom/MyShader8"
{
	Properties
	{
		//_Bump("Bump", 2D) = "white"{}
		_DiffuseColor("Diffuse Color", Color) = (1.0, 1.0, 1.0)
		_RimColor("Rim Color", Color) = (0.0, 0.0, 0.0)
		_RimWidth("Rim Width",Range(0.5, 8.0)) = 3.0 
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
			//float2 uv_Texture;
			//float2 uv_AlphaMap;
			//float2 uv_Bump;
			float3 viewDir;
		};

		//sampler2D _Bump;
		float4 _DiffuseColor;
		float4 _RimColor;
		float  _RimWidth;

        void surf (Input IN, inout SurfaceOutput o)
        {
			o.Albedo = _DiffuseColor;
			half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
			o.Emission = _RimColor.rgb * pow(rim, _RimWidth);
		}
        ENDCG
    }
    FallBack "Diffuse"
}
