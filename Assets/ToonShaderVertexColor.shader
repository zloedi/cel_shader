Shader "Toon Shader Vertex Color"
{
    Properties
    {
        [NoScaleOffset] _MainTex ("Texture", 2D) = "white" {}
        [NoScaleOffset] _Gradient ("Gradient", 2D) = "white" {}
    }
    SubShader
    {
        Lighting Off Fog { Mode Off }
        Pass
        {
            Tags { "LightMode" = "ForwardBase" } 

            CGPROGRAM
            // use "vert" function as the vertex shader
            #pragma vertex vert
            // use "frag" function as the pixel (fragment) shader
            #pragma fragment frag

            #include "UnityCG.cginc"

            // vertex shader inputs
            struct appdata
            {
                float4 vertex : POSITION;
                float4 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            // vertex shader outputs ("vertex to fragment")
            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                fixed4 color : COLOR;
            };

            sampler2D _MainTex;
            sampler2D _Gradient;

            float4 _MainTex_ST;

            // vertex shader
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                o.uv = TRANSFORM_TEX(v.uv,_MainTex);
                o.color = dot( v.normal, _WorldSpaceLightPos0.xyz );
                return o;
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                return tex2D(_Gradient, i.color.rg) * tex2D(_MainTex, i.uv);
            }
            ENDCG
        }
    }
}
