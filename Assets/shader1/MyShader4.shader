Shader "Custom/MyShader4"
{
	Properties
	{
		//_Color("Diffuse Color", Color) = (1.0, 1.0, 1.0)
		_Texture("Texture", 2D) = "white"{}
		_Alpha("Alpha", Range(0,1)) = 1
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
		#pragma surface surf Lambert alpha

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        struct Input
        {
            //float4 color : COLOR;
			float2 uv_Texture;
		};

		//float4 _Color;
		sampler2D _Texture;
		float _Alpha;

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_Texture,IN.uv_Texture).rgb * _Alpha;
			o.Alpha = _Alpha;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
