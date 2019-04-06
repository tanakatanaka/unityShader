Shader "Custom/MyShader5"
{
	Properties
	{
		//_Color("Diffuse Color", Color) = (1.0, 1.0, 1.0)
		_Texture("Texture", 2D) = "white"{}
		//_Alpha("Alpha", Range(0,1)) = 1
		_AlphaMap("AlphaMap", 2D) = "white"{}
	}


    SubShader
    {
        Tags 
		{
			"Queue" = "TransParent"
			"RenderType"="Opaque" 
		}
		Cull off
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
			float2 uv_AlphaMap;
		};

		//float4 _Color;
		sampler2D _Texture;
		//float _Alpha;
		sampler2D _AlphaMap;

        void surf (Input IN, inout SurfaceOutput o)
        {
			o.Alpha = tex2D(_AlphaMap, IN.uv_AlphaMap);
            o.Albedo = tex2D(_Texture,IN.uv_Texture).rgb * o.Alpha;
			//o.Alpha = _Alpha;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
