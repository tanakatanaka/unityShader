Shader "Custom/MyShader3"
{
	Properties
	{
		//_Color("Diffuse Color", Color) = (1.0, 1.0, 1.0)
		_Texture("Texture", 2D) = "white"{}
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
            //float4 color : COLOR;
			float2 uv_Texture;
		};

		//float4 _Color;
		sampler2D _Texture;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = tex2D(_Texture,IN.uv_Texture).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
