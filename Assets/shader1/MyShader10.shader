Shader "Custom/MyShader10"
{
	Properties
	{
		//_Bump("Bump", 2D) = "white"{}
		_DiffuseColor("Diffuse Color", Color) = (1.0, 1.0, 1.0)
		//_RimWidth("Rim Width",Range(0.5, 8.0)) = 3.0 
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
			float4 screenPos;
		};

		//sampler2D _Bump;
		float4 _DiffuseColor;

        void surf (Input IN, inout SurfaceOutput o)
        {
			o.Albedo = _DiffuseColor;
			clip(frac((IN.screenPos.y / IN.screenPos.w) * 20) - 0.5);
		}
        ENDCG
    }
    FallBack "Diffuse"
}
