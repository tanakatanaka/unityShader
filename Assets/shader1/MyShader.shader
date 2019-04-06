Shader "Custom/MyShader"
{
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

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = half3(1.0, 0.5, 0.4);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
