Shader "Custom/MyShader17"
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
			"RenderType" = "Opaque"
			//"Queue" = "TransParent"
		}
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		//#pragma surface surf Standard fullforwardshadows
		#pragma surface surf Lambert finalcolor:mycolor vertex:myvert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        struct Input
        {
			//float4 color: COLOR;
			float2 uv_Texture;
			float customData;
		};

		sampler2D _Texture;

		void myvert(inout appdata_full v, out Input data)
		{
			UNITY_INITIALIZE_OUTPUT(Input, data);
			data.customData = max(0, 0.5 * sin((v.vertex.y + _Time.x * 5) *
			3.14159 * 8));
		}


		void mycolor(Input IN, SurfaceOutput o, inout fixed4 color)
		{
			color = color + float4(1.0, 0.0, 0.0, 1.0) * IN.customData;
		}


        void surf (Input IN, inout SurfaceOutput o)
        {
			o.Albedo = tex2D(_Texture, IN.uv_Texture).rgb;
		}
        ENDCG
    }
    FallBack "Diffuse"
}
