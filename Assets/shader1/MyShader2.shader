Shader "Custom/MyShader2"
{
	Properties
	{
		_Color("Diffuse Color", Color) = (1.0, 1.0, 1.0)
	}


    SubShader
    {
        Tags { "RenderType"="Opaque" }

		CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        struct Input
        {
            float4 color : COLOR;
        };

		float4 _Color;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = _Color.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
