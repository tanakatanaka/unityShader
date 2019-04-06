Shader "Custom/MyShader16"
{
	Properties
	{
		//_DiffuseColor("Diffuse Color", Color) = (1.0, 1.0, 1.0)
		_Texture("Texture", 2D) = "white"{}
	}

		SubShader
	{
		Tags
		{
			"Queue" = "TransParent"
		}
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		//#pragma surface surf Standard fullforwardshadows
		#pragma surface surf Lambert finalcolor:mycolor

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        struct Input
        {
			//float4 color: COLOR;
			float2 uv_Texture;
		};

		sampler2D _Texture;

		void mycolor(Input IN, SurfaceOutput o, inout fixed4 color)
		{
			float r = max(0, dot(float3(0.0, 0.0, -1.0),o.Normal));
			float g = max(0, dot(float3(0.0, 1.0, 0.0), o.Normal));
			float b = max(0, dot(float3(0.0, -1.0, 1.0), o.Normal));
		
			color = color + float4(r, g, b, 1.0) * 0.5;
		}


        void surf (Input IN, inout SurfaceOutput o)
        {
			o.Albedo = tex2D(_Texture, IN.uv_Texture).rgb;
		}
        ENDCG
    }
    FallBack "Diffuse"
}
