Shader "Custom/MyShader15"
{
	Properties
	{
		_DiffuseColor("Diffuse Color", Color) = (1.0, 1.0, 1.0)
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
		#pragma surface surf Lambert vertex:vert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        struct Input
        {
			float4 color: COLOR;
		};

		float3 _DiffuseColor;
		
		void vert(inout appdata_full v)
		{
			v.vertex.x = v.vertex.x + (0.05 * v.normal.x * sin((v.vertex.y + _Time.x * 3) * 3.14159 * 8));
			v.vertex.z = v.vertex.z + (0.05 * v.normal.z * sin((v.vertex.y + _Time.x * 3) * 3.14159 * 8));
		}

        void surf (Input IN, inout SurfaceOutput o)
        {
			o.Albedo = _DiffuseColor;
		}
        ENDCG
    }
    FallBack "Diffuse"
}
