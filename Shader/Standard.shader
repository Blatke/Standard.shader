// Originally created by Bl@ke on Jan.2, 2025.
// Version 3.2.7 on Nov.29, 2025.
/*
1. Blend_RNM.cginc
2. TessDistance.cginc
3. RecalculateNormals.cginc
4. VertClamp.cginc
5. IsThisMask.cginc
6. UV_Transform.cginc
*/

Shader "Blake/Standard"
{
    Properties
    {
        [Header(Main)]
        [Enum(UnityEngine.Rendering.CullMode)] _A0_CullMode ("Cull Mode", Int) = 2
        _Color ("Base Color", Color) = (1,1,1,0)
        _MainTex ("Albedo (RGBA)", 2D) = "white" {}
        _A2_Cutout ("Albedo Cutout", Range(0,1)) = 0.5
        [Toggle] _A2_CutoutAlphaInvert ("Cutout Alpha Invert", Int) = 0
        [Enum(None,0, Red,1, Green,2, Blue,3, Black,4, White,5)] _A2_CutoutByRGB ("Cutout by RGB Channel", Int) = 0
        _A2_AlphaColor ("Alpha Color Replace (use Alpha value)", Color) = (0,0,0,0.98)
        [PowerSlider(2)] _A2_AlphaColorMultiplier ("Alpha Color Multiplier", Range(0.01,100)) = 1
        [Space]
        _A5_Occlusion ("Occlusion", Range(0,1)) = 1
        _A7_Metallic ("Metallic", Range(0,1)) = 0.5
        _A6_Smoothness ("Smoothness", Range(0,1)) = 0.5

        [Header(Displacement)]
        _F_DisplacementMap ("Displacement Map", 2D) = "black" {}
        [PowerSlider(2)] _F100_DisplacementStrength ("Displacement Strength", Range(0,1)) = 0
        _F110_Tessellation ("Tessellation", Range(1,100)) = 1
        [PowerSlider(2)] _F115_DisplacementOcclusionBump ("Bump Occlusion", Range(-100,100)) = 0
        [PowerSlider(2)] _F116_DisplacementOcclusionDent ("Dent Occlusion", Range(-100,100)) = 0
        [Space]
        [PowerSlider(2)] _F201_Displacement_R ("Channel R", Range(-2,2)) = 1
            [PowerSlider(2)] _F2010_Displacement_R_d ("Denominator", Range(0.1,10)) = 1
            _F2011_Displacement_R_ValMapping ("Value Mapping", Range(0,1)) = 0
            _F202_Displacement_R_X ("R CoordinateX", Range(-1,1)) = 0
            _F203_Displacement_R_Y ("R CoordinateY", Range(-1,1)) = 0
            _F204_Displacement_R_Z ("R CoordinateZ", Range(-1,1)) = 0
        [PowerSlider(2)] _F211_Displacement_G ("Channel G", Range(-2,2)) = 1
            [PowerSlider(2)] _F2110_Displacement_G_d ("Denominator", Range(0.1,10)) = 1
            _F2111_Displacement_G_ValMapping ("Value Mapping", Range(0,1)) = 0
            _F212_Displacement_G_X ("G CoordinateX", Range(-1,1)) = 0
            _F213_Displacement_G_Y ("G CoordinateY", Range(-1,1)) = 0
            _F214_Displacement_G_Z ("G CoordinateZ", Range(-1,1)) = 0
        [PowerSlider(2)] _F221_Displacement_B ("Channel B", Range(-2,2)) = 1
            [PowerSlider(2)] _F2210_Displacement_B_d ("Denominator", Range(0.1,10)) = 1
            _F2211_Displacement_B_ValMapping ("Value Mapping", Range(0,1)) = 0
            _F222_Displacement_B_X ("B CoordinateX", Range(-1,1)) = 0
            _F223_Displacement_B_Y ("B CoordinateY", Range(-1,1)) = 0
            _F224_Displacement_B_Z ("B CoordinateZ", Range(-1,1)) = 0

        [Header(Vertex Clamp)]
        [Toggle] _F501_VertClamp ("Vert Clamp", Range(0,1)) = 0
        [Toggle] _F502_VertClampDisplacementOnly ("Only for Displacement", Range(0,1)) = 0
        _F_VertClampMap ("Vert Clamp Map", 2D) = "black" {}
        [Enum(None,0, Upper Only,1, Lower Only,2, Both,3)]
        _F503_VertClampMapMode ("Map Mode", Range(0,3)) = 0
        _F503_VertClampMapInvert ("Map RGB Invert", Range(0,6)) = 0 //None,0, -R,1, -G,2, -B,3, -RG,4, -RB,5, -GB,6, -RGB,7
        [PowerSlider(2)] _F504_VertClampMapMultiplier ("Map Multiplier", Range(0.01,100)) = 1
        [PowerSlider(2)] _F504_VertClampMap_d ("Map Denominator", Range(0.1,10)) = 1
        _F505_VertClampMapRotate ("Map Rotation", Range(-180,180)) = 0
        _F509_VertClampDumping ("Dumping", Range(0,1)) = 0
        _F515_VertClampOcclusion ("Clamped Occlusion", Range(-1,1)) = 0
        [PowerSlider(2)] _F508_VertClampMorphDistance ("Morph Distance", Range(0,10)) = 0
        [PowerSlider(2)] _F508_VertClampMorphStr ("Morph Strength", Range(-3,3)) = 0.1
        [PowerSlider(3)] _F511_VertClampMultiplier ("Multiplier", Range(0.01,100)) = 1
            [PowerSlider(2)] _F521_VertClampUpper_X ("Upper X", Range(-100,100)) = 20
            [PowerSlider(2)] _F531_VertClampUpper_Y ("Upper Y", Range(-100,100)) = 20
            [PowerSlider(2)] _F541_VertClampUpper_Z ("Upper Z", Range(-100,100)) = 20
            [PowerSlider(2)] _F551_VertClampLower_XYZ ("Lower XYZ", Range(-100,100)) = -20
            [Enum(Cardinal,0, Multiplier,1)] _F552_VertClampLower_XYZ_Mode ("Lower XYZ Mode", Range(0,1)) = 0
        [Toggle] _F561_VertClampBoundInvert ("Upper-Lower Invert", Range(0,1)) = 0
        [PowerSlider(2)] _F562_VertClampBoundRotateAxis_X ("Bound X Axis Rotate", Range(-180,180)) = 0
        _F563_VertClampBoundRotateAxis_Y ("Bound Y Axis Rotate", Range(-180,180)) = 0
        _F564_VertClampBoundRotateAxis_Z ("Bound Z Axis Rotate", Range(-180,180)) = 0
        // _F565_VertClampBoundRotatePivot ("Bound Rotate Pivot", Vector) = (0,0,0,0)

        [Header(Emission)]
        [PowerSlider(2)] _A8_EmissionStrength ("Emission Strength", Range(0,5)) = 0
        [Enum(Color,0, Map,1, Both,2, Both Map Max,3)]
        _A8_EmissionMode ("Emission by", Int) = 2
        [Enum(EmissionMap,0, Albedo,1, Detail,2)]
        _A8_EmissionMapSource ("Emission Map Source", Int) = 0
        _EmissionMap ("Emission Map (RGBA)", 2D) = "black" {}
        [IntRange] _A8_EmissionMapAddendMode ("Emission Map Addend to", Range(0,8)) = 0 // 0: Aphla; 1: Channel Red; 2: Channel Green; 3: Channel Blue; 4: Channels R&G; 5: Channels R&B; 6: Channels G&B; 7: Channels RGB; 8: RGB & Alpha.
        [PowerSlider(2)] _A8_EmissionMapAddend ("Emission Map Addend", Range(-1,1)) = 0
        _A8_EmissionColor ("Emission Color", Color) = (1,1,1,1)
        [Toggle] _A8_EmissionMapColorInvert ("Invert Map Color", Int) = 0
        [Toggle] _A8_EmissionMapAlphaInvert ("Invert Map Alpha", Int) = 0

        [Header(Dissolution Edge)]
        _E1_DissolutionColor ("Dissolution Color", Color) = (1,1,1,1)
        [PowerSlider(2)] _E2_DissolutionWidth ("Dissolution Width", Range(0,1)) = 0
        [PowerSlider(2)] _E3_DissolutionEmission ("Dissolution Emission", Range(0,5)) = 1
        [Enum(No,0, Also,1, Only,2)] _E8_DissoByDetailTex ("By Detail Albedo", Int) = 1

        [Header(Detail Albedo)]
        _DetailAlbedoMap ("Detail Albedo (RGBA)", 2D) = "black" {}
        _A3_DetailTexCutout ("Detail Albedo Cutout", Range(0,1)) = 1
        [Toggle] _A3_DetailTexCutoutAlphaInvert ("Detail Cutout Alpha Invert", Int) = 0
        [Enum(None,0, Red,1, Green,2, Blue,3, Black,4, White,5)] _A3_DetailTexCutoutByRGB ("Cutout by RGB Channel", Int) = 0
        _A3_DetailTexTint ("Detail Albedo Tint", Color) = (1,1,1,1)
        _A3_DetailTexWeight ("Detail Albedo Weight", Range(0,1)) = 0
        [Toggle] _A3_DetailTexBlend ("Detail Albedo Blend", Range(0,1)) = 0
        [Toggle] _A3_DetailTexAffectAlphaColor ("Affect Alpha Color", Range(0,1)) = 1

        [Header(OMS (by Texture))]
        [Enum(None,0, Detail,1, ColorMaskRGB,2, Detail by ColorMaskRGB,3, Albedo,4, EmissionMap,5)]
        _A501_OcclusionByTexMode ("Occlusion by", Int) = 0
        [Enum(Red,0, Green,1, Blue,2, Max,3, Min,4, Avg,5)]
        _A502_OcclusionByTexChannel ("Occlusion Channel", Int) = 0
        [PowerSlider(2)] _A503_OcclusionTexAddend ("Occlusion Tex Addend", Range(-1,1)) = 0
        [Toggle] _A510_OcclusionTex_Invert ("Occlusion Tex Invert", Int) = 0
        [Toggle] _A511_OcclusionMask_Invert ("Occlusion Mask Invert", Int) = 0
        [Space]
        [Enum(None,0, Detail,1, ColorMaskRGB,2, Detail by ColorMaskRGB,3, Albedo,4, EmissionMap,5)]
        _A701_MetallicByTexMode ("Metallic by", Int) = 0
        [Enum(Red,0, Green,1, Blue,2, Max,3, Min,4, Avg,5)]
        _A702_MetallicByTexChannel ("Metallic Channel", Int) = 0
        [PowerSlider(2)] _A703_MetallicTexAddend ("Metallic Tex Addend", Range(-1,1)) = 0
        [Toggle] _A710_MetallicTex_Invert ("Metallic Tex Invert", Int) = 0
        [Toggle] _A711_MetallicMask_Invert ("Metallic Mask Invert", Int) = 0
        [Space]
        [Enum(None,0, Detail,1, ColorMaskRGB,2, Detail by ColorMaskRGB,3, Albedo,4, EmissionMap,5)]
        _A601_SmoothByTexMode ("Smooth by", Int) = 0
        [Enum(Red,0, Green,1, Blue,2, Max,3, Min,4, Avg,5)]
        _A602_SmoothByTexChannel ("Smooth Channel", Int) = 0
        [PowerSlider(2)] _A603_SmoothTexAddend ("Smooth Tex Addend", Range(-1,1)) = 0
        [Toggle] _A610_SmoothTex_Invert ("Smooth Tex Invert", Int) = 0
        [Toggle] _A611_SmoothMask_Invert ("Smooth Mask Invert", Int) = 0
        [Space]
        [Enum(None,0, Detail,1, ColorMaskRGB,2, Detail by ColorMaskRGB,3, Albedo,4, EmissionMap,5)]
        _A790_ExtraOMSTexSource ("Extra OMS Tex by", Int) = 0
        _A791_ExtraOcclusionStrength ("Extra Occlusion Strength", Range(0,1)) = 1
        _A792_ExtraSmoothStrength ("Extra Smooth Strength", Range(0,1)) = 1
        _A793_ExtraMetallicStrength ("Extra Metallic Strength", Range(0,1)) = 1

        [Header(Color Mask for Detail Albedo)]
        _D_ColorMask ("Mask (RGBA)", 2D) = "black" {}
        [Enum(Default,0, Greater than 0,1, Highest Value,2, Higher Values,3, Lowest Value,4, Lower Values,5)]
        _D100_ColorMaskRgbMode ("RGB Mode", Int) = 0
        _D101_ColorMaskStrength ("Color Mask Strength", Range(0,1)) = 1
        [PowerSlider(2)] _D101_ColorMaskMultiplier ("Color Mask Multiplier", Range(0.01,100)) = 1
        [PowerSlider(2)] _D101_ColorMaskAddend ("Color Mask Addend", Range(0,1)) = 0
        [Enum(Color,0, Detail,1, Color and Detail,2)]
        _D102_ColorMaskMapTo ("Color Mask map to", Int) = 0
        [Enum(Albedo Only,0, Alpha Only,1, Albedo and Alpha,2)]
        _D103_ColorMaskAffectMode ("Affect Mode", Int) = 2
        [Space]
            _D911_ColorMaskToColor_Red ("Red to Color", Color) = (1,0,0,1)
            _D912_ColorMaskStr_Red ("Red Strength", Range(0,10)) = 1
            _D913_ColorMaskEmit_Red ("Red Emission", Range(0,10)) = 0
            [Space]
            _D921_ColorMaskToColor_Green ("Green to Color", Color) = (0,1,0,1)
            _D922_ColorMaskStr_Green ("Green Strength", Range(0,10)) = 1
            _D923_ColorMaskEmit_Green ("Green Emission", Range(0,10)) = 0
            [Space]
            _D931_ColorMaskToColor_Blue ("Blue to Color", Color) = (0,0,1,1)
            _D932_ColorMaskStr_Blue ("Blue Strength", Range(0,10)) = 1
            _D933_ColorMaskEmit_Blue ("Blue Emission", Range(0,10)) = 0
            [Space]
            _D941_ColorMaskToColor_Cyan ("Cyan to Color", Color) = (0,1,1,1)
            _D942_ColorMaskStr_Cyan ("Cyan Strength", Range(0,10)) = 1
            _D943_ColorMaskEmit_Cyan ("Cyan Emission", Range(0,10)) = 0
            [Space]
            _D951_ColorMaskToColor_Fuchsia ("Fuchsia to Color", Color) = (1,0,1,1)
            _D952_ColorMaskStr_Fuchsia ("Fuchsia Strength", Range(0,10)) = 1
            _D953_ColorMaskEmit_Fuchsia ("Fuchsia Emission", Range(0,10)) = 0
            [Space]
            _D961_ColorMaskToColor_Yellow ("Yellow to Color", Color) = (1,1,0,1)
            _D962_ColorMaskStr_Yellow ("Yellow Strength", Range(0,10)) = 1
            _D963_ColorMaskEmit_Yellow ("Yellow Emission", Range(0,10)) = 0
            [Space]
            _D971_ColorMaskToColor_White ("White to Color", Color) = (1,1,1,1)
            _D972_ColorMaskStr_White ("White Strength", Range(0,10)) = 1
            _D973_ColorMaskEmit_White ("White Emission", Range(0,10)) = 0

        [Header(Bump and Eraser)]
        _BumpMap ("Normal Map", 2D) = "bump" {}
        _A901_NormalStrength ("Normal Strength", Range(0,10)) = 1.0
        [PowerSlider(2)] _A9011_NormalBlur ("Normal Blur", Range(0,2)) = 0
        [Space]
        _DetailNormalMap ("Detail Normal Map 1", 2D) = "bump" {}
        _A902_DetailNormal1Strength ("Detail Normal 1 Strength", Range(0,10)) = 1.0
        [PowerSlider(2)] _A9021_DetailNormal1Blur ("Detail 1 Blur", Range(0,2)) = 0
        [Space]
        _DetailNormalMap2("Detail Normal Map 2", 2D) = "bump" {}
        _A903_DetailNormal2Strength ("Detail Normal 2 Strength", Range(0,10)) = 1.0
        [PowerSlider(2)] _A9031_DetailNormal2Blur ("Detail 2 Blur", Range(0,2)) = 0
        [Space]
        [Enum(EraserMask,0, ColorMask,1)]
        _A920_BumpEraserMaskSource ("Bump Eraser by", Int) = 0
        _A_BumpEraserMask ("Bump Easer Mask (RGBA)", 2D) = "black" {}
        _A920_BumpEraserThreshold ("Bump Eraser Threshold", Range(0,1)) = 0
        [PowerSlider(2)] _A920_BumpEraserMultiplier ("Bump Eraser Multiplier", Range(0.01,100)) = 1
        [PowerSlider(2)] _A920_BumpEraserAddend ("Bump Eraser Addend", Range(-1,1)) = 0
        [Toggle] _A920_BumpEraserInvert ("Bump Eraser Invert", Int) = 0
        [Space]
            _A921_BumpEraser_Red ("Bump Eraser Red", Range(0,1)) = 1
            _A922_BumpEraser_Green ("Bump Eraser Green", Range(0,1)) = 1
            _A923_BumpEraser_Blue ("Bump Eraser Blue", Range(0,1)) = 1
            _A924_BumpEraser_Cyan ("Bump Eraser Cyan", Range(0,1)) = 1
            _A925_BumpEraser_Fuchsia ("Bump Eraser Fuchsia", Range(0,1)) = 1
            _A926_BumpEraser_Yellow ("Bump Eraser Yellow", Range(0,1)) = 1
            _A927_BumpEraser_White ("Bump Eraser White", Range(0,1)) = 1
        [Space]
        [Toggle] _A931_BumpEraserNormal ("Affect Normal Map", Range(0,1)) = 1
        [Toggle] _A941_BumpEraserDetailNormal1 ("Affect Detail Normal Map 1", Range(0,1)) = 1
        [Toggle] _A951_BumpEraserDetailNormal2 ("Affect Detail Normal Map 2", Range(0,1)) = 1

        [Header(Wetness)]
        [PowerSlider(3)] _B1_WetnessDensity ("Wetness Density", Range(0,100)) = 10
        _B2_WetnessStrength ("Wetness Strength", Range(0,1)) = 0
        _B3_WetnessBump ("Wetness Bump", Range(0,5)) = 0.2
        [Toggle] _B8_WetnessByFluidMask ("Mapped by Fluid Mask", Int) = 0
        [Toggle] _B9_WetnessWithFluid ("with Fluid", Range(0,1)) = 1

        [Header(Fluid)]
        _C1_FluidColor ("Fluid Color", Color) = (1,1,1,1)
        [PowerSlider(3)] _C2_FluidDensity ("Fluid Density", Range(0,100)) = 5
        [PowerSlider(2)] _C3_FluidStrength ("Fluid Strength", Range(0,10)) = 0
        _C4_FluidEmission ("Fluid Emission", Range(0,5)) = 0
        _C5_FluidBump ("Fluid Bump",Range(0,10)) = 1.0
        _C6_FluidRotation ("Fluid Rotation", Range(-180, 180)) = 0
        [Enum(None,0, Lv.1,1, Lv.2,2)] _C7_FluidEnhanceLv ("Fluid Enhance Level", Range(0,2)) = 0
        [Space]
        _C_FluidMask ("Fluid Mask (RGBA)", 2D) = "white" {}
        _C900_FluidMaskStrength ("Mask Strength", Range(0,1)) = 1
        _C900_FluidMaskMultiplier ("Mask Multiplier", Range(0,10)) = 1
        [Space]
            _C901_FluidMaskStrength_Red ("Red Strength", Range(0,1)) = 1
            _C905_FluidRotation_Red ("Red Rotate",Range(-180,180)) = 0
            _C906_FluidPositionX_Red ("Red Position X", Range(-1,1)) = 0
            _C907_FluidPositionY_Red ("Red Position Y", Range(-1,1)) = 0
            _C908_FluidScaleX_Red ("Red Scale X", Range(-10,10)) = 1
            _C909_FluidScaleY_Red ("Red Scale Y", Range(-10,10)) = 1
            [Space]
            _C911_FluidMaskStrength_Green ("Green Strength", Range(0,1)) = 1
            _C915_FluidRotation_Green ("Green Rotate",Range(-180,180)) = 0
            _C916_FluidPositionX_Green ("Green Position X", Range(-1,1)) = 0
            _C917_FluidPositionY_Green ("Green Position Y", Range(-1,1)) = 0
            _C918_FluidScaleX_Green ("Green Scale X", Range(-10,10)) = 1
            _C919_FluidScaleY_Green ("Green Scale Y", Range(-10,10)) = 1
            [Space]
            _C921_FluidMaskStrength_Blue ("Blue Strength", Range(0,1)) = 1
            _C925_FluidRotation_Blue ("Blue Rotate",Range(-180,180)) = 0
            _C926_FluidPositionX_Blue ("Blue Position X", Range(-1,1)) = 0
            _C927_FluidPositionY_Blue ("Blue Position Y", Range(-1,1)) = 0
            _C928_FluidScaleX_Blue ("Blue Scale X", Range(-10,10)) = 1
            _C929_FluidScaleY_Blue ("Blue Scale Y", Range(-10,10)) = 1
            [Space]
            _C931_FluidMaskStrength_Cyan ("Cyan Strength", Range(0,1)) = 1
            _C935_FluidRotation_Cyan ("Cyan Rotate",Range(-180,180)) = 0
            _C936_FluidPositionX_Cyan ("Cyan Position X", Range(-1,1)) = 0
            _C937_FluidPositionY_Cyan ("Cyan Position Y", Range(-1,1)) = 0
            _C938_FluidScaleX_Cyan ("Cyan Scale X", Range(-10,10)) = 1
            _C939_FluidScaleY_Cyan ("Cyan Scale Y", Range(-10,10)) = 1
            [Space]
            _C941_FluidMaskStrength_Fuchsia ("Fuchsia Strength", Range(0,1)) = 1
            _C945_FluidRotation_Fuchsia ("Fuchsia Rotate",Range(-180,180)) = 0
            _C946_FluidPositionX_Fuchsia ("Fuchsia Position X", Range(-1,1)) = 0
            _C947_FluidPositionY_Fuchsia ("Fuchsia Position Y", Range(-1,1)) = 0
            _C948_FluidScaleX_Fuchsia ("Fuchsia Scale X", Range(-10,10)) = 1
            _C949_FluidScaleY_Fuchsia ("Fuchsia Scale Y", Range(-10,10)) = 1
            [Space]
            _C951_FluidMaskStrength_Yellow ("Yellow Strength", Range(0,1)) = 1
            _C955_FluidRotation_Yellow ("Yellow Rotate",Range(-180,180)) = 0
            _C956_FluidPositionX_Yellow ("Yellow Position X", Range(-1,1)) = 0
            _C957_FluidPositionY_Yellow ("Yellow Position Y", Range(-1,1)) = 0
            _C958_FluidScaleX_Yellow ("Yellow Scale X", Range(-10,10)) = 1
            _C959_FluidScaleY_Yellow ("Yellow Scale Y", Range(-10,10)) = 1
            [Space]
            _C961_FluidMaskStrength_White ("White Strength", Range(0,1)) = 1
            _C965_FluidRotation_White ("White Rotate",Range(-180,180)) = 0
            _C966_FluidPositionX_White ("White Position X", Range(-1,1)) = 0
            _C967_FluidPositionY_White ("White Position Y", Range(-1,1)) = 0
            _C968_FluidScaleX_White ("White Scale X", Range(-10,10)) = 1
            _C969_FluidScaleY_White ("White Scale Y", Range(-10,10)) = 1
            [Space]
            [Header(Default Maps)]
            _Z_CombinedMap ("Combined Map", 2D) = "black" {}
            _B_WetnessBumpMap("Wetness Bump Map", 2D) = "bump" {}
            _C_FluidNormal ("Fluid Normal", 2D) = "bump" {}

    }

    SubShader
    {
        Tags { "RenderType"="OpaqueCutout" "Queue"="AlphaTest+1" }
        Cull [_A0_CullMode]
        ZWrite On
        LOD 200
        CGPROGRAM

        #pragma surface surf Standard fullforwardshadows vertex:vert tessellate:tessDistance addshadow
        #pragma target 4.6

        #include "Tessellation.cginc"
        // #include "UnityStandardUtils.cginc"

        sampler2D _MainTex;
        sampler2D _DetailAlbedoMap;
        sampler2D _BumpMap;
        sampler2D _DetailNormalMap;
        sampler2D _DetailNormalMap2;
        sampler2D _A_BumpEraserMask;
        sampler2D _EmissionMap;
        sampler2D _B_WetnessBumpMap;
        sampler2D _C_FluidNormal;
        sampler2D _C_FluidMask;
        sampler2D _D_ColorMask;
        sampler2D _F_DisplacementMap;
        // sampler2D _F_VertClampMap;   // Using Macro instead.
        sampler2D _Z_CombinedMap;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_DetailAlbedoMap;
            float2 uv_BumpMap;
            float2 uv_DetailNormalMap;
            float2 uv_DetailNormalMap2;
            float2 uv_A_BumpEraserMask;
            float2 uv_EmissionMap;
            float2 uv_C_FluidMask;
            float2 uv_D_ColorMask;
            float2 uv_Z_CombinedMap;
            float2 _isVertClamped: COLOR0;
        };

        float4 _F_DisplacementMap_ST;
        // float4 _F_VertClampMap_ST;   // Using Macro instead.

        float4 _Color;
        float _A2_Cutout;
        int _A2_CutoutAlphaInvert;
        float _A2_CutoutByRGB;
        float4 _A2_AlphaColor;
        float _A2_AlphaColorMultiplier;
        float _A3_DetailTexWeight;
        float _A3_DetailTexAffectAlphaColor;
        float3 _A3_DetailTexTint;
        float _A3_DetailTexCutout;
        int _A3_DetailTexCutoutAlphaInvert;
        float _A3_DetailTexCutoutByRGB;
        float _A3_DetailTexBlend;
        float _A5_Occlusion;
        float _A6_Smoothness;
        float _A7_Metallic;
        int _A501_OcclusionByTexMode;
            int _A502_OcclusionByTexChannel;
            float _A503_OcclusionTexAddend;
        int _A601_SmoothByTexMode;
            int _A602_SmoothByTexChannel;
            float _A603_SmoothTexAddend;
        int _A701_MetallicByTexMode;
            int _A702_MetallicByTexChannel;
            float _A703_MetallicTexAddend;
            int _A510_OcclusionTex_Invert;
            int _A511_OcclusionMask_Invert;
            int _A610_SmoothTex_Invert;
            int _A611_SmoothMask_Invert;
            int _A710_MetallicTex_Invert;
            int _A711_MetallicMask_Invert;
        int _A790_ExtraOMSTexSource;
            float _A791_ExtraOcclusionStrength;
            float _A792_ExtraSmoothStrength;
            float _A793_ExtraMetallicStrength;
        int _A8_EmissionMapSource;
        int _A8_EmissionMode;
        int _A8_EmissionMapAddendMode;
        float _A8_EmissionMapAddend;
        float4 _A8_EmissionColor;
        float _A8_EmissionStrength;
        int _A8_EmissionMapColorInvert;
        int _A8_EmissionMapAlphaInvert;
        float _A901_NormalStrength;
        float _A9011_NormalBlur;
        float _A902_DetailNormal1Strength;
        float _A9021_DetailNormal1Blur;
        float _A903_DetailNormal2Strength;
        float _A9031_DetailNormal2Blur;
        int _A920_BumpEraserMaskSource;
        float _A920_BumpEraserThreshold;
        float _A920_BumpEraserMultiplier;
        float _A920_BumpEraserAddend;
        int _A920_BumpEraserInvert;
            float _A921_BumpEraser_Red;
            float _A922_BumpEraser_Green;
            float _A923_BumpEraser_Blue;
            float _A924_BumpEraser_Cyan;
            float _A925_BumpEraser_Fuchsia;
            float _A926_BumpEraser_Yellow;
            float _A927_BumpEraser_White;
        float _A931_BumpEraserNormal;
        float _A941_BumpEraserDetailNormal1;
        float _A951_BumpEraserDetailNormal2;
        float _B1_WetnessDensity;
        float _B2_WetnessStrength;
        float _B3_WetnessBump;
        float _B9_WetnessWithFluid;
        int _B8_WetnessByFluidMask;
        float4 _C1_FluidColor;
        float _C2_FluidDensity;
        float _C3_FluidStrength;
        float _C4_FluidEmission;
        float _C5_FluidBump;
        float _C6_FluidRotation;
        int _C7_FluidEnhanceLv;
        float _C900_FluidMaskStrength;
        float _C900_FluidMaskMultiplier;
            float _C901_FluidMaskStrength_Red;
            float _C905_FluidRotation_Red;
            float _C906_FluidPositionX_Red;
            float _C907_FluidPositionY_Red;
            float _C908_FluidScaleX_Red;
            float _C909_FluidScaleY_Red;
            float _C911_FluidMaskStrength_Green;
            float _C915_FluidRotation_Green;
            float _C916_FluidPositionX_Green;
            float _C917_FluidPositionY_Green;
            float _C918_FluidScaleX_Green;
            float _C919_FluidScaleY_Green;
            float _C921_FluidMaskStrength_Blue;
            float _C925_FluidRotation_Blue;
            float _C926_FluidPositionX_Blue;
            float _C927_FluidPositionY_Blue;
            float _C928_FluidScaleX_Blue;
            float _C929_FluidScaleY_Blue;
            float _C931_FluidMaskStrength_Cyan;
            float _C935_FluidRotation_Cyan;
            float _C936_FluidPositionX_Cyan;
            float _C937_FluidPositionY_Cyan;
            float _C938_FluidScaleX_Cyan;
            float _C939_FluidScaleY_Cyan;
            float _C941_FluidMaskStrength_Fuchsia;
            float _C945_FluidRotation_Fuchsia;
            float _C946_FluidPositionX_Fuchsia;
            float _C947_FluidPositionY_Fuchsia;
            float _C948_FluidScaleX_Fuchsia;
            float _C949_FluidScaleY_Fuchsia;
            float _C951_FluidMaskStrength_Yellow;
            float _C955_FluidRotation_Yellow;
            float _C956_FluidPositionX_Yellow;
            float _C957_FluidPositionY_Yellow;
            float _C958_FluidScaleX_Yellow;
            float _C959_FluidScaleY_Yellow;
            float _C961_FluidMaskStrength_White;
            float _C965_FluidRotation_White;
            float _C966_FluidPositionX_White;
            float _C967_FluidPositionY_White;
            float _C968_FluidScaleX_White;
            float _C969_FluidScaleY_White;
        int _D100_ColorMaskRgbMode;
        float _D101_ColorMaskStrength;
        float _D101_ColorMaskMultiplier;
        float _D101_ColorMaskAddend;
        int _D102_ColorMaskMapTo;
        int _D103_ColorMaskAffectMode;
            float4 _D911_ColorMaskToColor_Red;
            float _D912_ColorMaskStr_Red;
            float _D913_ColorMaskEmit_Red;
            float4 _D921_ColorMaskToColor_Green;
            float _D922_ColorMaskStr_Green;
            float _D923_ColorMaskEmit_Green;
            float4 _D931_ColorMaskToColor_Blue;
            float _D932_ColorMaskStr_Blue;
            float _D933_ColorMaskEmit_Blue;
            float4 _D941_ColorMaskToColor_Cyan;
            float _D942_ColorMaskStr_Cyan;
            float _D943_ColorMaskEmit_Cyan;
            float4 _D951_ColorMaskToColor_Fuchsia;
            float _D952_ColorMaskStr_Fuchsia;
            float _D953_ColorMaskEmit_Fuchsia;
            float4 _D961_ColorMaskToColor_Yellow;
            float _D962_ColorMaskStr_Yellow;
            float _D963_ColorMaskEmit_Yellow;
            float4 _D971_ColorMaskToColor_White;
            float _D972_ColorMaskStr_White;
            float _D973_ColorMaskEmit_White;
        float4 _E1_DissolutionColor;
        float _E2_DissolutionWidth;
        float _E3_DissolutionEmission;
        float _E8_DissoByDetailTex;

        float _F100_DisplacementStrength;
        // int _F110_Tessellation;  // Using Macro instead.
        float _F115_DisplacementOcclusionBump;
        float _F116_DisplacementOcclusionDent;
            float _F201_Displacement_R;
            float _F2010_Displacement_R_d;
            float _F202_Displacement_R_X;
            float _F203_Displacement_R_Y;
            float _F204_Displacement_R_Z;
            float _F211_Displacement_G;
            float _F2110_Displacement_G_d;
            float _F212_Displacement_G_X;
            float _F213_Displacement_G_Y;
            float _F214_Displacement_G_Z;
            float _F221_Displacement_B;
            float _F2210_Displacement_B_d;
            float _F222_Displacement_B_X;
            float _F223_Displacement_B_Y;
            float _F224_Displacement_B_Z;
            float _F2011_Displacement_R_ValMapping;
            float _F2111_Displacement_G_ValMapping;
            float _F2211_Displacement_B_ValMapping;
        int _F501_VertClamp;
        int _F502_VertClampDisplacementOnly;
        int _F503_VertClampMapMode;
        int _F503_VertClampMapInvert;
        float _F504_VertClampMapMultiplier;
        float _F504_VertClampMap_d;
        float _F505_VertClampMapRotate;
        float _F509_VertClampDumping;
        float _F511_VertClampMultiplier;
            float _F521_VertClampUpper_X;
            float _F531_VertClampUpper_Y;
            float _F541_VertClampUpper_Z;
            float _F551_VertClampLower_XYZ;
                int _F552_VertClampLower_XYZ_Mode;
            int _F561_VertClampBoundInvert;
            float _F562_VertClampBoundRotateAxis_X;
            float _F563_VertClampBoundRotateAxis_Y;
            float _F564_VertClampBoundRotateAxis_Z;
        float _F515_VertClampOcclusion;
        float _F508_VertClampMorphDistance;
        float _F508_VertClampMorphStr;
        // float3 _F565_VertClampBoundRotatePivot;

        #include "Includes/Blend_RNM.cginc"
        #define TESSELLATION_FACTOR _F110_Tessellation
        #include "Includes/TessDistance.cginc"
        #include "Includes/IsThisMask.cginc"
        #include "Includes/UV_Transform.cginc"
        #define VERT_CLAMP_MAP _F_VertClampMap
        #define VERT_CLAMP_MAP_ST _F_VertClampMap_ST
        #include "Includes/VertClamp.cginc"
        #include "Includes/RecalculateNormals.cginc"

        float invertClamp(float v, bool isInverted){
            return ((isInverted)?(1-v):v);
        }

        float4 intGet(float4 v, int index, inout float vRGB){
            float4 i = v;
            if (index == 1){
                i.r = round(v.r);
                i.g = round(v.g);
                i.b = round(v.b);
            }else if (index == 0){
                i.r = floor(v.r);
                i.g = floor(v.g);
                i.b = floor(v.b);
            }else if (index == 2){
                i.r = ceil(v.r);
                i.g = ceil(v.g);
                i.b = ceil(v.b);
            }else{
                i.r = trunc(v.r);
                i.g = trunc(v.g);
                i.b = trunc(v.b);
            }
            vRGB = i.r+i.g+i.b;
            return i;
        }

        float3 rgbMode(float3 a, int index){
            float t;
            float3 r;
            if (index==1){  // take any value higher than 0 as 1.
                r = (a > 0);
            }else if (index==2){  // take the highest channel.
                t = max(a.r, max(a.g,a.b));
                r = (a == t);
            }else if (index==3){    // take two higher channels.
                if (a.r==a.g && a.g==a.b && a.r>0){
                    r = float3(1,1,1);
                }else{
                    t = min(a.r, min(a.g,a.b));
                    r = (a > t);
                }
            }else if (index==4){    // take the lowest channel.
                t = min(a.r, min(a.g,a.b));
                r = (a == t);
            }else if (index==5){    // take two lower channels.
                if (a.r==a.g && a.g==a.b && a.r>0){
                    r = float3(1,1,1);
                }else{
                    t = max(a.r, max(a.g,a.b));
                    r = (a < t);
                }
            }else{
                r = a;
            }
            return r;
        }

        float3 bumpEraser(float3 normal, float4 be, float BumpEraserThreshold, float toggle, float thisThreshold, float3 thisRGB, inout bool alreadyComparedResult){
            if (thisThreshold>0 && toggle==1 && be.a>0){
                if (IsThisMask(be.rgb, thisRGB, alreadyComparedResult)){
                    BumpEraserThreshold *= thisThreshold;
                    normal.xy = lerp(normal.xy,float2(0,0), saturate(be.a*BumpEraserThreshold));
                }
            }
            return normal;
        }

        float maskMultiplier(float r1, float r2, float4 maskRGB, float3 thisRGB, float multiplier, inout bool alreadyComparedResult){
            if (IsThisMask(maskRGB, thisRGB, alreadyComparedResult)){
                float t = r1*maskRGB.a;
                return lerp(r2,r1,saturate(multiplier*t));
            }else{
                return r2;
            }
        }

        float3 colorMask(float3 c1, float4 c2, float str, float4 maskRGB, float3 thisRGB, int index, inout bool alreadyComparedResult){
            if (IsThisMask(maskRGB, thisRGB, alreadyComparedResult) && str>0){
                if (index==1){
                    return lerp(c2.rgb, c1, saturate(1-maskRGB.a*str * c2.a));
                }else if (index==2){    // for emission.
                    return saturate(maskRGB.a * c2.rgb * c2.a * str);
                }else{
                    return c1;
                }
            }else{
                return c1;
            }
        }

        float omsChannel(float3 c, int index){
            float o;
            if (index<1){
                o = c.r;
            }else if (index<2){
                o = c.g;
            }else if (index<3){
                o = c.b;
            }else if (index<4){
                o = max(c.r,max(c.g,c.b));
            }else if (index<5){
                o = min(c.r,min(c.g,c.b));
            }else{
                o = (c.r+c.g+c.b)/3;
            }
            return o;
        }

        #define SAMPLE_EmissionMap(uv) tex2D(_EmissionMap, uv)
        float4 omsTexMode(int mode, float addend, float4 c, float4 dt, inout float4 ems, inout bool emsIsSet, float2 emsUV, float emsMultiplier){
            float4 r = float4(0,0,0,0);
            if (mode==1||mode==3){
                r = dt.rgba;
            }else if (mode==4){
                r = c.rgba;
            }else if (mode==5){
                if (!emsIsSet){
                    ems = SAMPLE_EmissionMap(emsUV);
                    emsIsSet = true;
                }
                r = float4(ems.rgb * emsMultiplier, ems.a);
            }
            return r + addend;
        }

        float omsSet(float str, float omsInput, float omsInput2, float4 omsTex, float4 cmTex, float ColorMaskStrength, float ColorMaskAddend, float cMStr[7],int mode, int channel, int texInvert, int maskInvert, float3 rgbVal[7], inout bool alreadyComparedResult){
            float omsReturn = omsInput2;
            float ocmRGB = 0;
            if (texInvert>0){
                omsTex = 1-omsTex;
                cmTex = 1-cmTex;
            }
            if ((mode==1||mode==3||mode==4||mode==5)){
                omsReturn = saturate(invertClamp(lerp(omsInput2, omsChannel(omsTex,channel)*str, omsTex.a),texInvert));
            }else if (mode==2){
                omsReturn = saturate(invertClamp(lerp(omsInput2, omsChannel(cmTex,channel)*str, cmTex.a),texInvert));
            }else if (mode==3){
                cmTex.a = saturate(cmTex.a+ColorMaskAddend);
                float4 cm = intGet(cmTex,1,ocmRGB);
                if (cm.a>0 && (ocmRGB==1||ocmRGB==2||ocmRGB==3)){
                    float omsLerp1 = saturate(omsInput+invertClamp(omsChannel(omsTex,channel)*omsTex.a, texInvert));
                    float omsLerpIndex = ColorMaskStrength * cm.a;
                    UNITY_UNROLL
                    for (int i=0;i<7;i++){
                        if (IsThisMask(cm.rgb,rgbVal[i], alreadyComparedResult)){
                            if (maskInvert==1){
                                omsReturn = lerp(omsInput2, omsLerp1, saturate(omsLerpIndex * cMStr[i]));
                            }else{
                                omsReturn = lerp(omsLerp1, omsInput2, saturate(omsLerpIndex * cMStr[i]));
                            }
                            alreadyComparedResult = false;
                        }
                    }
                }
            }
            return omsReturn;
        }

        float3 detailAlbedo(float3 albedo, float4 dt, float weight, float tint, float alphaColorToggle, float thisAlphaColorToggle, float blendToggle){
            if (weight > 0 && alphaColorToggle == thisAlphaColorToggle){
                if (blendToggle == 1){
                    albedo *= dt.rgb * tint;
                }else{
                    albedo = lerp(albedo, dt.rgb * tint, weight * dt.a);
                }
            }
            return albedo;
        }

        bool isCutoutByRGB(bool r, float3 c, float choice, float cutoutMinus){
            if (r){
                return r;
            }else{
                float3 cMin = 1-c.rgb;
                if (choice>4 && (c.r<cutoutMinus || c.g<cutoutMinus || c.b<cutoutMinus)){
                    r = true;
                }
                if (choice>3 && choice<=4 && (c.r<cutoutMinus && c.g<cutoutMinus && c.b<cutoutMinus)){
                    r = true;
                }
                if (choice>2 && choice<=3 && (cMin.r<cutoutMinus || cMin.g<cutoutMinus)){
                    r = true;
                }
                if (choice>1 && choice<=2 && (cMin.r<cutoutMinus || cMin.b<cutoutMinus)){
                    r = true;
                }
                if (choice>0 && choice<=1 && (cMin.g<cutoutMinus || cMin.b<cutoutMinus)){
                    r = true;
                }
                return r;
            }
        }

        #define SAMPLE_NORMAL(uv) UnpackNormal(tex2D(_BumpMap, uv))
        #define SAMPLE_DetailNORMAL1(uv) UnpackNormal(tex2D(_DetailNormalMap, uv))
        #define SAMPLE_DetailNORMAL2(uv) UnpackNormal(tex2D(_DetailNormalMap2, uv))

        float3 bumpSample(float2 uv, float2 offset, int index){
            float3 bump = float3(0,0,1);
            if (index==1){
                bump = SAMPLE_NORMAL(uv + offset).rgb;
            }else if (index==2){
                bump = SAMPLE_DetailNORMAL1(uv + offset).rgb;
            }else if (index==3){
                bump = SAMPLE_DetailNORMAL2(uv + offset).rgb;
            }
            return bump;
        }

        float3 bumpBlur(float2 uv, float3 normalTS, float blurRadius, int index){
            if (blurRadius>0){
                float2 texelSize = blurRadius * 0.01;
                float2 offset = 0;
                UNITY_UNROLL
                for (int x = -1; x <= 1; x++) {
                    UNITY_UNROLL
                    for (int y = -1; y <= 1; y++) {
                        offset = float2(x, y) * texelSize;
                        normalTS += bumpSample(uv,offset,index);
                    }
                }
                normalTS = normalize(normalTS / 9.0);
            }
            else{
                normalTS = bumpSample(uv,0,index);
            }
            return normalTS;
        }

        #define SAMPLE_ColorMask(uv) tex2D(_D_ColorMask, uv)
        #define SAMPLE_FluidMap(uv) tex2D(_Z_CombinedMap, uv)
        #define SAMPLE_FluidNormal(uv) UnpackNormal(tex2D(_C_FluidNormal, uv))
        #define SAMPLE_WetnessMap(uv) tex2D (_Z_CombinedMap, uv)
        #define SAMPLE_WetnessBumpMap(uv) UnpackNormal(tex2D(_B_WetnessBumpMap, uv))

        void wetSet(float glossiness, float metallic, float3 normal, inout float wet, bool isWet, float2 WetnessMapUV, float WetnessDensity, float WetnessStrength, float WetnessBump, inout float glossiness_wet, inout float metallic_wet, inout float3 normal_wet){
            float2 uv_wet = WetnessMapUV.xy*float2(WetnessDensity*1.5, WetnessDensity);
            wet = SAMPLE_WetnessMap(uv_wet).r;
            if (wet>0){
                float wetMaxMultiplier = wet * WetnessStrength;

                glossiness_wet = saturate(glossiness + lerp(wetMaxMultiplier, glossiness, saturate(glossiness * WetnessStrength)));

                metallic_wet = saturate(metallic + lerp(wetMaxMultiplier, metallic, saturate(metallic * WetnessStrength)));

                if (WetnessBump > 0){
                    float3 wn = SAMPLE_WetnessBumpMap(uv_wet);
                    normal_wet = wn;
                    normal_wet.xy *= WetnessBump * WetnessStrength;
                }
            }
        }

        float valueMapping(float v, float threshold){
            if (threshold>0 && threshold<1){
                if (v<threshold){
                    return v/threshold-1;
                }else if (v>threshold){
                    return (v-threshold)/(1-threshold);
                }else{
                    return 0;
                }
            }else{
                return v;
            }
        }

        float denominator(float2 c){
            float absCX = abs(c.x);
            float _dividen = (c.y-1)*absCX+1;    //c.y-absCX;
            float lerpABS = (_dividen==0)?(absCX*c.y):(absCX*c.y)/_dividen;    //saturate(absCX/_dividen);
            return lerpABS;
        }

        float4 vertDisplacement(float4 vertex, float3 vertModified, float2 c, float4 cs, float3 normal){
            float lerpABS = denominator(c);
            // float absCX = abs(c.x);
            // float _dividen = (c.y-1)*absCX+1;    //c.y-absCX;
            // float lerpABS = (_dividen==0)?(absCX*c.y):(absCX*c.y)/_dividen;    //saturate(absCX/_dividen);

            if (cs.x==0 && cs.y==0 && cs.z==0){    // Normal Space.
                vertModified = lerp(vertModified, vertModified + normal * _F100_DisplacementStrength * cs.w * sign(c.x), lerpABS);
            }else{  // World Space.
                float3 localDir = cs.xyz;
                float3 worldDir = UnityObjectToWorldNormal(localDir);
                worldDir = normalize(worldDir);
                float3 worldPos = mul(unity_ObjectToWorld, vertex).xyz;
                worldPos = lerp(worldPos, worldPos + worldDir * _F100_DisplacementStrength * cs.w, lerpABS);
                vertModified = mul(unity_WorldToObject, float4(worldPos,1)).xyz;
            }
            return float4(vertModified, lerpABS);
        }

        #define SAMPLE_Displacement(uv) tex2Dlod(_F_DisplacementMap, float4(uv, 0, 0))

        void mapDisplacement(out bool rgb, float2 uv, out float2 c[3], out float3 t){
            uv = TRANSFORM_TEX(uv, _F_DisplacementMap);
            t = SAMPLE_Displacement(uv).rgb;
            rgb = (t.r+t.g+t.b>0);
            c[0] = float2(valueMapping(t.r, _F2011_Displacement_R_ValMapping), _F2010_Displacement_R_d);
            c[1] = float2(valueMapping(t.g, _F2111_Displacement_G_ValMapping), _F2110_Displacement_G_d);
            c[2] = float2(valueMapping(t.b, _F2211_Displacement_B_ValMapping), _F2210_Displacement_B_d);
        }        

        void vert(inout appdata_full v){
            float isVertClamped = 0;
            float isVertModified = 0;
            float3 vertModified = v.vertex.xyz;
            float3 vcUpper = float3(0,0,0);
            float3 vcLower = float3(0,0,0);
            if (_F501_VertClamp>0){
                vcUpper = float3(_F521_VertClampUpper_X, _F531_VertClampUpper_Y, _F541_VertClampUpper_Z);
                vcLower = float3(_F551_VertClampLower_XYZ,_F551_VertClampLower_XYZ,_F551_VertClampLower_XYZ);
                if (_F552_VertClampLower_XYZ_Mode>0){
                    vcLower *= vcUpper;
                }
                vcUpper *= _F511_VertClampMultiplier;
                vcLower *= _F511_VertClampMultiplier;
            }
            float3 _vertModifiedDistance = float3(0,0,0);

            bool rgb = false;
            float2 c[3];
            float3 displacementMap;
            mapDisplacement(rgb, v.texcoord.xy, c, displacementMap);
            float4 cs[3] = {
                float4(_F202_Displacement_R_X, _F203_Displacement_R_Y, _F204_Displacement_R_Z, _F201_Displacement_R),
                float4(_F212_Displacement_G_X, _F213_Displacement_G_Y, _F214_Displacement_G_Z, _F211_Displacement_G),
                float4(_F222_Displacement_B_X, _F223_Displacement_B_Y, _F224_Displacement_B_Z, _F221_Displacement_B)
            };
            bool isDisplacementSet = (rgb || _F2011_Displacement_R_ValMapping+_F2111_Displacement_G_ValMapping+_F2211_Displacement_B_ValMapping>0);
            
            if (_F100_DisplacementStrength>0){                
                if (isDisplacementSet){
                    float l[3];
                    UNITY_UNROLL
                    for (int i=0; i<3; i++){
                        float4 _vertDisplacement = vertDisplacement(v.vertex, vertModified, c[i], cs[i], v.normal);
                        vertModified = _vertDisplacement.xyz;
                        l[i] = _vertDisplacement.w;
                    }
                    if (vertModified.x!=v.vertex.x || vertModified.y!=v.vertex.y || vertModified.z!=v.vertex.z){
                        float _occLerp = max(l[0],max(l[1],l[2]));
                        float _occStr = c[0].x * cs[0].w + c[1].x * cs[1].w + c[2].x * cs[2].w;
                        isVertModified = (_occStr > 0)?
                            lerp(0, sign(_F115_DisplacementOcclusionBump) * abs(_F115_DisplacementOcclusionBump * _occStr * _F100_DisplacementStrength), _occLerp):
                            lerp(0, sign(_F116_DisplacementOcclusionDent) * abs(_F116_DisplacementOcclusionDent * _occStr * _F100_DisplacementStrength), _occLerp);
                    }
                }
            }

            bool _useDisplacementMap = (_F502_VertClampDisplacementOnly>0 && isDisplacementSet);
            bool _vertClamped = (_F501_VertClamp>0 && _F502_VertClampDisplacementOnly==0) || (_F501_VertClamp>0 && _useDisplacementMap);
            if (_vertClamped){
                float3 vertModified_beforeClamp = vertModified;
                vertModified = vertClamp(
                    v.texcoord.xy,
                    _F503_VertClampMapMode,
                    _F503_VertClampMapInvert,
                    _F504_VertClampMap_d,
                    _F504_VertClampMapMultiplier,
                    float3(_F562_VertClampBoundRotateAxis_X, _F563_VertClampBoundRotateAxis_Y, _F564_VertClampBoundRotateAxis_Z),
                    _F505_VertClampMapRotate,
                    _F508_VertClampMorphDistance,
                    _F508_VertClampMorphStr,
                    _F511_VertClampMultiplier,
                    _F515_VertClampOcclusion,
                    vertModified,
                    vcLower,
                    vcUpper,
                    _F509_VertClampDumping,
                    isVertClamped,
                    _F561_VertClampBoundInvert,
                    v.normal
                );
                if (_useDisplacementMap){
                    float _denominator[3] = {1,1,1};
                    for (int j=0; j<3; j++){
                        _denominator[j] = denominator(c[j]);
                    }
                    float _displacementMapRGB_MAX = saturate(
                        max(
                            lerp(0, displacementMap.r * _F201_Displacement_R, _denominator[0]), 
                            max(
                                lerp(0, displacementMap.g * _F211_Displacement_G, _denominator[1]), lerp(0, displacementMap.b * _F221_Displacement_B, _denominator[2])
                                )
                            )
                        );
                    vertModified = lerp(vertModified_beforeClamp, vertModified, _displacementMapRGB_MAX);
                }
            }
            if (_F100_DisplacementStrength>0 || _vertClamped){
                // Recalculate normals.
                RecalculateNormals(v.vertex.xyz, v.tangent.xyz, v.normal, vertModified, _vertModifiedDistance);
            }
            v.color.x = isVertClamped;
            v.color.y = isVertModified;
        }









        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float4 c = tex2D(_MainTex, IN.uv_MainTex);
            float4 dt = tex2D(_DetailAlbedoMap, IN.uv_DetailAlbedoMap);
            float cutoutAlpha;
            float cutout;
            float dtCutoutAlpha;
            float dtCutout;
            if (_A2_CutoutAlphaInvert>0){
                cutoutAlpha = 1-c.a;
                cutout = 1-_A2_Cutout;
            }else{
                cutoutAlpha = c.a;
                cutout = _A2_Cutout;
            }
            if (_A3_DetailTexCutoutAlphaInvert>0){
                dtCutoutAlpha = 1-dt.a;
                dtCutout = 1-_A3_DetailTexCutout;
            }else{
                dtCutoutAlpha = dt.a;
                dtCutout = _A3_DetailTexCutout;
            }
            float cutoutMinus = 1-cutout;
            float dtCutoutMinus = 1-dtCutout;

            // Cutout by RGB.
            bool cutoutByRGB = false;
            cutoutByRGB = isCutoutByRGB(cutoutByRGB, c.rgb, _A2_CutoutByRGB, cutoutMinus);
            cutoutByRGB = isCutoutByRGB(cutoutByRGB, dt.rgb, _A3_DetailTexCutoutByRGB, dtCutoutMinus);

            // Discard by Cutout.
            if (cutout <= 0 || cutoutAlpha < cutoutMinus || dtCutout <=0 || dtCutoutAlpha < 1-dtCutout || cutoutByRGB){
                discard;
            }

            float3 albedo = c.rgb*c.a*_Color.rgb;
            float3 normal = float3(0,0,1);
            float occlusion = _A5_Occlusion;
            float metallic = _A7_Metallic;
            float glossiness = _A6_Smoothness;
            float3 emission = float3(0,0,0);
            bool hasNormal = false;

            float3 rgbVal[7] = {
                float3(1,0,0),   //Red.
                float3(0,1,0),   //Green.
                float3(0,0,1),   //Blue.
                float3(0,1,1),   //Cyan.
                float3(1,0,1),   //Fuchsia.
                float3(1,1,0),   //Yellow.
                float3(1,1,1)    //White.
            };

            // Detail Albedo before alpha color replace.
            albedo = detailAlbedo(albedo, dt, _A3_DetailTexWeight, _A3_DetailTexTint, _A3_DetailTexAffectAlphaColor, 0, _A3_DetailTexBlend);

            // Alpha Color Replace.
            if (_A2_AlphaColor.a<1){
                albedo = lerp(albedo,_A2_AlphaColor.rgb,saturate((1-c.a) * (_A2_AlphaColor.a * _A2_AlphaColorMultiplier)));
            }

            // Detail Albedo after alpha color replace.
            albedo = detailAlbedo(albedo, dt, _A3_DetailTexWeight, _A3_DetailTexTint, _A3_DetailTexAffectAlphaColor, 1, _A3_DetailTexBlend);

            // Color Mask.
            bool cmCondition1 = false;
            bool cmCondition2 = false;
            if (_D101_ColorMaskStrength>0 && _D101_ColorMaskMultiplier>0){
                cmCondition1 = true;
            }
            if (_A501_OcclusionByTexMode==2 || _A501_OcclusionByTexMode==3){
                cmCondition2 = true;
            }
            float2 cmUV = IN.uv_D_ColorMask;
            float4 cmTex = (cmCondition1||cmCondition2)?(SAMPLE_ColorMask(cmUV)):float4(0,0,0,0);
            cmTex.rgb = rgbMode(cmTex.rgb, _D100_ColorMaskRgbMode);

            float4 cm = cmTex;
            float cmRGB = 0;
            float4 cM2C[7] = {
                _D911_ColorMaskToColor_Red,
                _D921_ColorMaskToColor_Green,
                _D931_ColorMaskToColor_Blue,
                _D941_ColorMaskToColor_Cyan,
                _D951_ColorMaskToColor_Fuchsia,
                _D961_ColorMaskToColor_Yellow,
                _D971_ColorMaskToColor_White
            };
            float cMStr[7] = {
                _D912_ColorMaskStr_Red,
                _D922_ColorMaskStr_Green,
                _D932_ColorMaskStr_Blue,
                _D942_ColorMaskStr_Cyan,
                _D952_ColorMaskStr_Fuchsia,
                _D962_ColorMaskStr_Yellow,
                _D972_ColorMaskStr_White
            };
            float cMEm[7] = {
                _D913_ColorMaskEmit_Red,
                _D923_ColorMaskEmit_Green,
                _D933_ColorMaskEmit_Blue,
                _D943_ColorMaskEmit_Cyan,
                _D953_ColorMaskEmit_Fuchsia,
                _D963_ColorMaskEmit_Yellow,
                _D973_ColorMaskEmit_White
            };
            float ColorMaskStrength = _D101_ColorMaskStrength * _D101_ColorMaskMultiplier;

            if (cmCondition1){
                cm = intGet(cmTex,1,cmRGB);
                cm.a = saturate(cm.a+_D101_ColorMaskAddend);
                if (cm.a>0 && (cmRGB==1 || cmRGB==2 || cmRGB==3)){

                    float4 c2 = float4(1,1,1,1);
                    float cmAffectMode = 1;
                    bool alreadyComparedResult_cm = false;
                    UNITY_UNROLL
                    for (int i=0; i<7; i++){
                        if (_D102_ColorMaskMapTo<1){
                            c2 = cM2C[i].rgba;
                        }else if (_D102_ColorMaskMapTo<2){
                            c2 = dt.rgba;
                        }else{
                            c2 = cM2C[i].rgba * dt.rgba;
                        }
                        if (_D103_ColorMaskAffectMode<1){
                            cmAffectMode = c.a;
                        }else if (_D103_ColorMaskAffectMode<2){
                            cmAffectMode = 1-c.a;
                        }else{
                            cmAffectMode = 1;
                        }
                        albedo = colorMask(albedo, c2, cMStr[i] * ColorMaskStrength * cmAffectMode, cm, rgbVal[i], 1, alreadyComparedResult_cm);
                        emission = colorMask(emission, c2, cMEm[i] * ColorMaskStrength * cmAffectMode, cm, rgbVal[i], 2, alreadyComparedResult_cm);
                        alreadyComparedResult_cm = false;
                    }
                }
            }

            // Bump Eraser Pre-treatment.
            float4 be = float4(0,0,0,0);
            bool IsEraser = (_A920_BumpEraserThreshold>0)? true: false;
            float beMask[7] = {
                _A921_BumpEraser_Red,
                _A922_BumpEraser_Green,
                _A923_BumpEraser_Blue,
                _A924_BumpEraser_Cyan,
                _A925_BumpEraser_Fuchsia,
                _A926_BumpEraser_Yellow,
                _A927_BumpEraser_White
            };
            float beRGB = 0;
            if (IsEraser){
                if (_A920_BumpEraserMaskSource<1){
                    be = tex2D(_A_BumpEraserMask,IN.uv_A_BumpEraserMask);
                    be = intGet(be,1,beRGB);
                }else{
                    be = (cmCondition1||cmCondition2)?cm.rgba:SAMPLE_ColorMask(cmUV);
                    beRGB = cmRGB;
                }
                be.a += _A920_BumpEraserAddend;
                be.a = (_A920_BumpEraserInvert>0)?(1-be.a):be.a;
            }

            // Normal Map.
            float BumpEraserThreshold = _A920_BumpEraserThreshold * _A920_BumpEraserMultiplier;
            if (_A901_NormalStrength>0){
                float3 normalTex = bumpBlur(IN.uv_BumpMap, float3(0,0,0), _A9011_NormalBlur,1);
                if (IsEraser && (beRGB==1||beRGB==2||beRGB==3)){
                    bool alreadyComparedResult_be1 = false;
                    UNITY_UNROLL
                    for (int i=0; i<7; i++){
                        normalTex = bumpEraser(normalTex, be, BumpEraserThreshold, _A931_BumpEraserNormal, beMask[i], rgbVal[i],alreadyComparedResult_be1);
                        alreadyComparedResult_be1 = false;
                    }
                }
                normalTex.xy *= _A901_NormalStrength;
                normal = normalTex;
                hasNormal = true;
            }

            // Detail Normal Map 1.
            if (_A902_DetailNormal1Strength>0){
                float3 normalTexDetail1 = bumpBlur(IN.uv_DetailNormalMap, float3(0,0,0), _A9021_DetailNormal1Blur,2);
                if (IsEraser && (beRGB==1||beRGB==2||beRGB==3)){
                    bool alreadyComparedResult_be2 = false;
                    UNITY_UNROLL
                    for (int i=0; i<7; i++){
                        normalTexDetail1 = bumpEraser(normalTexDetail1, be, BumpEraserThreshold, _A941_BumpEraserDetailNormal1, beMask[i], rgbVal[i],alreadyComparedResult_be2);
                        alreadyComparedResult_be2 = false;
                    }
                }
                normalTexDetail1.xy *= _A902_DetailNormal1Strength;
                if (hasNormal == true){
                    normal = blend_rnm(normal,normalTexDetail1,1,1);
                }else{
                    normal = normalTexDetail1;
                    hasNormal = true;
                }
            }

            // Detail Normal Map 2.
            if (_A903_DetailNormal2Strength>0){
                float3 normalTexDetail2 = bumpBlur(IN.uv_DetailNormalMap2, float3(0,0,0), _A9031_DetailNormal2Blur,3);
                if (IsEraser && (beRGB==1||beRGB==2||beRGB==3)){
                    bool alreadyComparedResult_be3 = false;
                    UNITY_UNROLL
                    for (int i=0; i<7; i++){
                        normalTexDetail2 = bumpEraser(normalTexDetail2, be, BumpEraserThreshold, _A951_BumpEraserDetailNormal2, beMask[i], rgbVal[i],alreadyComparedResult_be3);
                        alreadyComparedResult_be3 = false;
                    }
                }
                normalTexDetail2.xy *= _A903_DetailNormal2Strength;
                if (hasNormal == true){
                    normal = blend_rnm(normal,normalTexDetail2,1,1);
                }else{
                    normal = normalTexDetail2;
                    hasNormal = true;
                }
            }

            // Emission.
            float2 emsUV = IN.uv_EmissionMap;
            float4 ems = float4(0,0,0,0);
            bool emsIsSet = false;
            if (_A8_EmissionStrength>0){
                if (_A8_EmissionMode>=1){
                    if (_A8_EmissionMapSource<1){
                        ems = SAMPLE_EmissionMap(emsUV);
                        emsIsSet = true;
                    }else if (_A8_EmissionMapSource<2){
                        ems = c.rgba;
                    }else if (_A8_EmissionMapSource<3){
                        ems = dt.rgba;
                    }
                }

                int addendMode = round(_A8_EmissionMapAddendMode);
                ems.a = (addendMode==0||addendMode==8)?saturate(ems.a+_A8_EmissionMapAddend):ems.a;
                ems.r = (addendMode==1||addendMode==4||addendMode==5||addendMode==7||addendMode==8)?saturate(ems.r+_A8_EmissionMapAddend):ems.r;
                ems.g = (addendMode==2||addendMode==4||addendMode==6||addendMode==7||addendMode==8)?saturate(ems.g+_A8_EmissionMapAddend):ems.g;
                ems.b = (addendMode==3||addendMode==5||addendMode==6||addendMode==7||addendMode==8)?saturate(ems.b+_A8_EmissionMapAddend):ems.b;

                ems.a = invertClamp(ems.a,_A8_EmissionMapAlphaInvert);
                if (_A8_EmissionMapColorInvert>0){
                    ems.r = 1-ems.r;
                    ems.g = 1-ems.g;
                    ems.b = 1-ems.b;
                }
                float emitLerp = _A8_EmissionStrength * ems.a;
                if (_A8_EmissionMode<1){ //EmissionColor only.
                    emission += _A8_EmissionColor * _A8_EmissionStrength;
                }else if (_A8_EmissionMode<2){   //EmissionMap only.
                    emission += lerp(emission, ems.rgb * emitLerp, saturate(emitLerp));
                }else if (_A8_EmissionMode<3){   //EmissionColor * EmissionMap.
                    emission += lerp(emission, _A8_EmissionColor.rgb * ems.rgb * emitLerp, saturate(emitLerp));
                }else if (_A8_EmissionMode<4){
                    float emsMaxOrMin = (_A8_EmissionMapColorInvert>0)?(min(ems.r,min(ems.g,ems.b))):(max(ems.r,max(ems.g,ems.b)));
                    emission += lerp(emission, _A8_EmissionColor.rgb * emsMaxOrMin * emitLerp, saturate(emitLerp));
                }
            }

            //OMS.
            bool alreadyComparedResult_oms = false;
            float omsAddend[3] = {
                _A503_OcclusionTexAddend,
                _A703_MetallicTexAddend,
                _A603_SmoothTexAddend
            };
            int4 omsToggle[3] = {
                int4(_A501_OcclusionByTexMode,_A502_OcclusionByTexChannel,_A510_OcclusionTex_Invert,_A511_OcclusionMask_Invert),
                int4(_A701_MetallicByTexMode,_A702_MetallicByTexChannel,_A710_MetallicTex_Invert,_A711_MetallicMask_Invert),
                int4(_A601_SmoothByTexMode,_A602_SmoothByTexChannel,_A610_SmoothTex_Invert,_A611_SmoothMask_Invert)
            };
            float2 curOMS[3] = {
                float2(1-occlusion,occlusion),
                float2(metallic,metallic),
                float2(glossiness,glossiness)
            };
            float omsByTexResults[3];
            UNITY_UNROLL
            for (int i=0; i<3; i++){
                omsByTexResults[i] = omsSet(1,curOMS[i].x,curOMS[i].y,
                    omsTexMode(omsToggle[i].x,omsAddend[i],c,dt,ems,emsIsSet,emsUV,1),
                    cmTex,ColorMaskStrength,_D101_ColorMaskAddend,cMStr,omsToggle[i].x,omsToggle[i].y,omsToggle[i].z,omsToggle[i].w,rgbVal, alreadyComparedResult_oms);
            }
            occlusion = omsToggle[0].x>0?omsByTexResults[0]:occlusion;
            metallic = omsToggle[1].x>0?omsByTexResults[1]:metallic;
            glossiness = omsToggle[2].x>0?omsByTexResults[2]:glossiness;

            if (_A790_ExtraOMSTexSource>0){ // Extra OMS.
                float4 extraOMS[3] = {
                    float4(1-occlusion,occlusion,_A791_ExtraOcclusionStrength,0),
                    float4(metallic,metallic,_A793_ExtraMetallicStrength,0),
                    float4(glossiness,glossiness,_A792_ExtraSmoothStrength,0)
                };
                UNITY_UNROLL
                for (int i=0; i<3; i++){
                    extraOMS[i].w = omsSet(extraOMS[i].z,extraOMS[i].x,extraOMS[i].y,
                        omsTexMode(_A790_ExtraOMSTexSource,0,c,dt,ems,emsIsSet,emsUV,extraOMS[i].z),
                        cmTex,ColorMaskStrength,0,cMStr,_A790_ExtraOMSTexSource,3,0,0,rgbVal, alreadyComparedResult_oms);
                }
                occlusion = extraOMS[0].w;
                metallic = extraOMS[1].w;
                glossiness = extraOMS[2].w;
            }

            // Wetness.
            bool wetDobyFluidMask = _B8_WetnessByFluidMask;
            float wet = 0;
            bool isWet = (_B1_WetnessDensity>0 && _B2_WetnessStrength>0)? true: false;
            float glossiness_wet = 0;
            float metallic_wet = 0;
            float3 normal_wet = float3(0,0,1);

            if (isWet){
                wetSet(glossiness, metallic, normal, wet, isWet, IN.uv_Z_CombinedMap.xy, _B1_WetnessDensity, _B2_WetnessStrength, _B3_WetnessBump, glossiness_wet, metallic_wet, normal_wet);
            }
            bool isWetAndWithFluid = (isWet && _B9_WetnessWithFluid > 0)? true: false;

            bool alreadyComparedResult_wet = false;
            if (isWet && !wetDobyFluidMask){
                glossiness = glossiness_wet;
                metallic = metallic_wet;
                normal = blend_rnm(normal,normal_wet,1,1);
            }

            // Fluid.
            float fluid = 0;
            bool isFluid = (_C2_FluidDensity>0 && _C3_FluidStrength>0)? true: false;
            float2 uv_rotated = uvRotation(IN.uv_Z_CombinedMap, _C6_FluidRotation, float2(0,0), 1, 0);
            float2 fluidUV[3];

            if (isFluid ||(wet>0 && (isWetAndWithFluid || wetDobyFluidMask))){
                float mMultiplier = 0;

                //Fluid Mask
                float4 fm = tex2D(_C_FluidMask,IN.uv_C_FluidMask);
                float fmRGB;
                fm = intGet(fm,1,fmRGB);
                float fStr[7] = {
                        _C901_FluidMaskStrength_Red,
                        _C911_FluidMaskStrength_Green,
                        _C921_FluidMaskStrength_Blue,
                        _C931_FluidMaskStrength_Cyan,
                        _C941_FluidMaskStrength_Fuchsia,
                        _C951_FluidMaskStrength_Yellow,
                        _C961_FluidMaskStrength_White
                };

                if (fm.a>0 && (fmRGB==1 || fmRGB==2 || fmRGB==3)){

                    float fR[7] = {
                        _C905_FluidRotation_Red,
                        _C915_FluidRotation_Green,
                        _C925_FluidRotation_Blue,
                        _C935_FluidRotation_Cyan,
                        _C945_FluidRotation_Fuchsia,
                        _C955_FluidRotation_Yellow,
                        _C965_FluidRotation_White
                    };
                    float fP_X[7] = {
                        _C906_FluidPositionX_Red,
                        _C916_FluidPositionX_Green,
                        _C926_FluidPositionX_Blue,
                        _C936_FluidPositionX_Cyan,
                        _C946_FluidPositionX_Fuchsia,
                        _C956_FluidPositionX_Yellow,
                        _C966_FluidPositionX_White
                    };
                    float fP_Y[7] = {
                        _C907_FluidPositionY_Red,
                        _C917_FluidPositionY_Green,
                        _C927_FluidPositionY_Blue,
                        _C937_FluidPositionY_Cyan,
                        _C947_FluidPositionY_Fuchsia,
                        _C957_FluidPositionY_Yellow,
                        _C967_FluidPositionY_White
                    };
                    float fS_X[7] = {
                        _C908_FluidScaleX_Red,
                        _C918_FluidScaleX_Green,
                        _C928_FluidScaleX_Blue,
                        _C938_FluidScaleX_Cyan,
                        _C948_FluidScaleX_Fuchsia,
                        _C958_FluidScaleX_Yellow,
                        _C968_FluidScaleX_White
                    };
                    float fS_Y[7] = {
                        _C909_FluidScaleY_Red,
                        _C919_FluidScaleY_Green,
                        _C929_FluidScaleY_Blue,
                        _C939_FluidScaleY_Cyan,
                        _C949_FluidScaleY_Fuchsia,
                        _C959_FluidScaleY_Yellow,
                        _C969_FluidScaleY_White
                    };
                    bool alreadyComparedResult_fl = false;
                    UNITY_UNROLL
                    for (int i=0; i<7; i++){
                        uv_rotated = uvTransform(uv_rotated, fm.a, 0, 0.5, fR[i], fP_X[i], fP_Y[i], fS_X[i], fS_Y[i], 0, fm, rgbVal[i], alreadyComparedResult_fl);
                        mMultiplier = maskMultiplier(fStr[i], mMultiplier, fm, rgbVal[i], 2, alreadyComparedResult_fl);

                        alreadyComparedResult_fl = false;
                    }
                }
                uv_rotated *= _C2_FluidDensity;
                fluidUV[0]=float2(uv_rotated.xy);
                fluidUV[1]=float2(1 - (uv_rotated.x + 0.5), uv_rotated.y + 0.4);
                fluidUV[2]=float2(1 - (uv_rotated.x - 0.7), uv_rotated.y + 0.55);
                _C3_FluidStrength *= mMultiplier * _C900_FluidMaskStrength * _C900_FluidMaskMultiplier;

                // Fluid gets its texture data.
                fluid = SAMPLE_FluidMap(fluidUV[0]).g;
                if (_C7_FluidEnhanceLv>0){
                    if (_C7_FluidEnhanceLv>1){
                        float fluidDetail2 = SAMPLE_FluidMap(fluidUV[2]).g;
                        fluid = max(fluid,fluidDetail2);
                    }
                    float fluidDetail1 = SAMPLE_FluidMap(fluidUV[1]).g;
                    fluid = max(fluid,fluidDetail1);
                }

                // Wetness with Fluid - using Fluid section.
                if (isWet && (isWetAndWithFluid || wetDobyFluidMask)){
                    float wetLerpStr = 1;
                    bool isWetAndWithFluid_alreadySet = false;
                    alreadyComparedResult_wet = false;
                    float fMax = fluid*_B2_WetnessStrength;
                    if (wetDobyFluidMask){
                        UNITY_UNROLL
                        for (int i=0; i<7; i++){
                            if (IsThisMask(fm.rgb, rgbVal[i],alreadyComparedResult_wet)){
                                wetLerpStr = fm.a * fStr[i] * _C900_FluidMaskStrength * _C900_FluidMaskMultiplier;
                                glossiness = lerp(glossiness,glossiness_wet,wetLerpStr);
                                metallic = lerp(metallic,metallic_wet,wetLerpStr);
                                normal = blend_rnm(normal,normal_wet,1,wetLerpStr);

                                if (isWetAndWithFluid){
                                    wetLerpStr *= fMax;
                                    glossiness = saturate(glossiness + wetLerpStr);
                                    metallic = saturate(metallic + wetLerpStr);
                                    isWetAndWithFluid_alreadySet = true;
                                    normal.xy *= saturate(1-fluid);
                                }
                            }
                            alreadyComparedResult_wet = false;
                        }
                    }
                    if (isWetAndWithFluid && !isWetAndWithFluid_alreadySet && !wetDobyFluidMask){
                        glossiness = saturate(glossiness+fMax);
                        metallic = saturate(metallic+fMax);
                        normal.xy *= saturate(1-fluid);
                    }
                }
            }

            if (isFluid){
                float fluidGlossiness = saturate(fluid * _C3_FluidStrength);    // Fluid Glossiness.

                if (fluidGlossiness>0){
                    glossiness = lerp(glossiness, 1, fluidGlossiness);
                    if (_C4_FluidEmission > 0){
                        emission += lerp(0,_C1_FluidColor.rgb * _C4_FluidEmission*_C3_FluidStrength, fluidGlossiness);  // Fluid Emission.
                    }
                }

                if (fluidGlossiness>0 && _C5_FluidBump>0){
                    float3 fl = SAMPLE_FluidNormal(fluidUV[0]);
                    if (_C7_FluidEnhanceLv>0){
                        if (_C7_FluidEnhanceLv>1){
                            float3 fluidNDetail2 = SAMPLE_FluidNormal(fluidUV[2]);
                            fl = max(fl,fluidNDetail2);
                        }
                        float3 fluidNDetail1 = SAMPLE_FluidNormal(fluidUV[1]);
                        fl = max(fl,fluidNDetail1);
                    }
                    normal = blend_rnm(normal,fl,1,_C5_FluidBump*fluidGlossiness);  // Fluid Bump.
                }

                if (fluidGlossiness>0){
                    albedo = saturate(lerp(albedo, _C1_FluidColor.rgb,fluidGlossiness*_C1_FluidColor.a)); // Fluid color blending.
                }
            }

            // Dissolution Edge - only with cutout effect.
            if (_E2_DissolutionWidth>0){
                float3 dsvColor = _E1_DissolutionColor.rgb * _E1_DissolutionColor.a;
                float3 dsvEmit = dsvColor * _E3_DissolutionEmission;
                float dsv1 = cutoutMinus+_E2_DissolutionWidth;
                float dsv2 = dtCutoutMinus+_E2_DissolutionWidth;

                if (_E8_DissoByDetailTex>1){
                // By Detail Albedo - Only.
                    if ((dt.a<=dsv2 || isCutoutByRGB(false,dt,_A3_DetailTexCutoutByRGB,dsv2)) && dtCutout<1){
                        albedo = dsvColor;
                        emission = dsvEmit;
                    }
                }else if (_E8_DissoByDetailTex>0){
                // By Detail Albedo - Also.
                    if ((dt.a<=dsv2 && dtCutout<1) || (c.a<=dsv1 && cutout<1) || (isCutoutByRGB(false,c,_A2_CutoutByRGB,dsv1) && cutout<1) || (isCutoutByRGB(false,dt,_A3_DetailTexCutoutByRGB,dsv2) && dtCutout<1)){
                        albedo = dsvColor;
                        emission = dsvEmit;
                    }
                }else{
                // By Detail Albedo - No.
                    if (cutout<1 && (c.a<=dsv1 || isCutoutByRGB(false,c,_A2_CutoutByRGB,dsv1))){
                        albedo = dsvColor;
                        emission = dsvEmit;
                    }
                }
            }

            occlusion = saturate(occlusion + IN._isVertClamped.x + IN._isVertClamped.y);

            o.Albedo = albedo;
            o.Normal = normal;
            o.Occlusion = occlusion;
            o.Metallic = metallic;
            o.Smoothness = glossiness;
            o.Emission = emission;
        }
        ENDCG
    }
    FallBack "Standard"
    CustomEditor "ME_Tag_Generator.CustomShaderInspector"
}