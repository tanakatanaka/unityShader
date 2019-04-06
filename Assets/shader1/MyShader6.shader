Shader "Custom/MyShader6"
{
	Properties
	{
		_Bump("Bump", 2D) = "white"{}
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
			float2 uv_Bump;
		};

		sampler2D _Bump;

        void surf (Input IN, inout SurfaceOutput o)
        {
            //o.Albedo = tex2D(_Texture,IN.uv_Texture).rgb * o.Alpha;
			o.Albedo = half3(1.0, 0.6, 0.4);
			o.Normal = UnpackNormal(tex2D(_Bump, IN.uv_Bump));
			//o.Alpha = _Alpha;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
