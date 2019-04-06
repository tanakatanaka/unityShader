Shader "Custom/MyShader7"
{
	Properties
	{
		//_Bump("Bump", 2D) = "white"{}
		_DiffuseColor("Diffuse Color", Color) = (1.0, 1.0, 1.0)
		_EmissionColor("Emission Color", Color) = (0.0, 0.0, 0.0)
	}

    SubShader
    {
        Tags 
		{
			//"Queue" = "TransParent"
			"RenderType"="Opaque" 
		}
		Cull off
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
			float4 color:COLOR;
		};

		//sampler2D _Bump;
		float4 _DiffuseColor;
		float4 _EmissionColor;


        void surf (Input IN, inout SurfaceOutput o)
        {
            //o.Albedo = tex2D(_Texture,IN.uv_Texture).rgb * o.Alpha;
			o.Albedo = _DiffuseColor;
			o.Emission = _EmissionColor;
			//o.Alpha = _Alpha;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
