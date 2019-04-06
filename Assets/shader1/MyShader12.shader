Shader "Custom/MyShader12"
{
	Properties
	{
		_DiffuseColor("Diffuse Color", Color) = (1.0, 1.0, 1.0) 
		//_Cube("Cubemap", CUBE) = ""{}
		//_Bump("Bump", 2D) = "white"{}
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
		#pragma surface surf Original

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

		half4 LightingOriginal(SurfaceOutput s, half3 lightDir, half attern)
		{
			half diff = dot(s.Normal, lightDir);
			diff = frac(diff * 10);

			half4 c;

			c.rgb = s.Albedo * _LightColor0.rgb * (diff * attern * 2);
			c.a = s.Alpha;
			return c;
		}

        struct Input
        {
			float4 color: COLOR;
		};

		//sampler2D _Bump;
		float3 _DiffuseColor;
		
        void surf (Input IN, inout SurfaceOutput o)
        {
			o.Albedo = _DiffuseColor;
		}
        ENDCG
    }
    FallBack "Diffuse"
}
