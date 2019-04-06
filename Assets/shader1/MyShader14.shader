Shader "Custom/MyShader14"
{
	Properties
	{
		_DiffuseColor("Diffuse Color", Color) = (1.0, 1.0, 1.0)
		_Specular("Specular", Range(1.0, 50.0)) = 15.0
	}

    SubShader
    {
        Tags 
		{
			"Queue" = "TransParent"
			"RenderType"="Opaque" 
		}
		CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        //#pragma surface surf Standard fullforwardshadows
		#pragma surface surf Original alpha

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        struct Input
        {
			float4 color: COLOR;
		};

		float3 _DiffuseColor;
		float  _Specular;
	
		half4 LightingOriginal(SurfaceOutput s, half3 lightDir, half3 viewDir, half attern)
		{
			half diff = max(0, dot(s.Normal, lightDir));
			half spec = max(0, dot(s.Normal, normalize(lightDir + viewDir)));
			spec = pow(spec, _Specular);
			half trans = 1.0 - max(0, dot(s.Normal, viewDir)) + spec;

			half4 c;

			c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec / 2) * (attern * 2);
			c.a = trans;
			return c;
		}
		
		
        void surf (Input IN, inout SurfaceOutput o)
        {
			o.Albedo = _DiffuseColor;
		}
        ENDCG
    }
    FallBack "Diffuse"
}
