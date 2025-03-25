# Standard.shader
使用于Unity Editor中的着色器，主要应用于非透明的衣服和物品等。

## 下载中心
请前往[Release](https://github.com/Blatke/Standard.shader/releases)页面，并从最新版本中下载.shader文件。

将其拖放到Unity编辑器中的Project文件夹中，然后在项目窗口中创建新材质。选择此新材质，并在材质的检查器选项卡上，将其着色器指定给**Blake/Standard**。

## 属性说明

> [!NOTE]
> 本说明由[DeepSeek](https://www.deepseek.com/)基于本着色器文件生成。
> 
> 本说明适用于Blake/Standard **v2.3.8**。

### Main 主设置
- **Cull Mode** (_A0_CullMode)

  - 控制渲染剔除模式（Back/Front/Off），决定哪些面不渲染。

- **Base Color** (_A1_Color)

  - 材质的基础颜色，与主纹理颜色叠加。

- **Albedo (RGBA)** (_MainTex)
  - 主颜色纹理贴图（RGBA通道），定义材质的基础颜色和透明度。

- **Albedo Cutout** (_A2_Cutout)

  - 透明度测试阈值（0-1），低于此值的像素会被完全剔除。

- **Cutout by RGB Channel** (_A2_CutoutByRGB)

  - 根据RGB通道（红/绿/蓝/黑/白）的亮度值触发透明度剔除。

- **Alpha Color Replace** (_A2_AlphaColor)

  - 用指定颜色替换透明区域，Alpha值控制替换强度。

- **Alpha Color Multiplier** (_A2_AlphaColorMultiplier)

  - 增强“Alpha Color Replace”效果的强度（0.01-100倍）。

- **Occlusion** (_A5_Occlusion)

  - 环境光遮蔽强度（0-1），值越小暗部越明显。

- **Metallic** (_A7_Metallic)

  - 金属度（0-1），值越高材质反射光越强。

- **Smoothness** (_A6_Smoothness)

  - 光滑度（0-1），值越高镜面反射越清晰。

- **Emission (RGBA)** (_EmissionMap)
  - 自发光纹理贴图（RGBA通道），定义发光区域和颜色。

- **Emission Color** (_A8_EmissionColor)

  - 自发光颜色，与贴图颜色叠加。

- **Emission Strength** (_A8_EmissionStrength)

  - 自发光整体强度（0-5），控制发光亮度。

### Dissolution Edge 溶解边缘
- **Dissolution Color** (_E1_DissolutionColor)

  - 溶解边缘颜色（RGBA），用于透明区域边缘的着色。

- **Dissolution Width** (_E2_DissolutionWidth)

  - 溶解边缘的宽度（0-1），值越大边缘范围越广。

- **Dissolution Emission** (_E3_DissolutionEmission)

  - 溶解边缘的自发光强度（0-5）。

- **By Detail Albedo** (_E8_DissoByDetailTex)

  - 溶解触发方式：0=不依赖细节纹理，1=同时依赖主纹理和细节纹理，2=仅依赖细节纹理。

### Detail Albedo 细节颜色
- **Detail Albedo (RGBA)** (_DetailAlbedoMap)
  - 细节颜色纹理贴图，用于叠加在主纹理上增加细节。

- **Detail Albedo Cutout** (_A3_DetailTexCutout)

  - 细节纹理的透明度测试阈值（0-1）。

- **Cutout by RGB Channel** (_A3_DetailTexCutoutByRGB)

  - 根据细节纹理的RGB通道（红/绿/蓝/黑/白）亮度触发剔除。

- **Detail Albedo Tint** (_A3_DetailTexTint)

  - 细节纹理的染色颜色（RGB），调整细节色调。

- **Detail Albedo Weight** (_A3_DetailTexWeight)

  - 细节纹理的混合权重（0-1），控制细节可见度。

- **Detail Albedo Blend** (_A3_DetailTexBlend)

  - 混合模式切换：0=插值混合，1=乘法叠加。

- **Affect Alpha Color** (_A3_DetailTexAffectAlphaColor)

  - 是否让细节纹理影响“Alpha Color Replace”效果（0=否，1=是）。

### OMS from Detail Albedo
  - 基于细节纹理的OMS调整
- **Occlusion Plus (R)** (_A501_OcclusionMinusDetailTex_Red)
  - 通过细节纹理的红色通道增强环境光遮蔽（0-1）。

- **Occlusion Plus (G)** (_A502_OcclusionMinusDetailTex_Green)
  - 通过细节纹理的绿色通道增强环境光遮蔽（0-1）。

- **Occlusion Plus (B)** (_A503_OcclusionMinusDetailTex_Blue)
  - 通过细节纹理的蓝色通道增强环境光遮蔽（0-1）。

- **Occlusion Tex Invert** (_A510_OcclusionDetailTex_Invert)

  - 反转细节纹理对遮蔽的影响方向（0=正常，1=反转）。

- **Metallic Plus (R)** (_A701_MetallicPlusDetailTex_Red)
  - 通过细节纹理的红色通道增强金属感（0-1）。

- **Metallic Plus (G)** (_A702_MetallicPlusDetailTex_Green)
  - 通过细节纹理的绿色通道增强金属感（0-1）。

- **Metallic Plus (B)** (_A703_MetallicPlusDetailTex_Blue)
  - 通过细节纹理的蓝色通道增强金属感（0-1）。

- **Metallic Tex Invert** (_A710_MetallicDetailTex_Invert)

  - 反转细节纹理对金属感的影响方向（0=正常，1=反转）。

- **Smoothness Plus (R)** (_A601_SmoothPlusDetailTex_Red)
  - 通过细节纹理的红色通道增强光滑度（0-1）。

- **Smoothness Plus (G)** (_A602_SmoothPlusDetailTex_Green)
  - 通过细节纹理的绿色通道增强光滑度（0-1）。

- **Smoothness Plus (B)** (_A603_SmoothPlusDetailTex_Blue)
  - 通过细节纹理的蓝色通道增强光滑度（0-1）。

- **Smooth Tex Invert** (_A610_SmoothDetailTex_Invert)

  - 反转细节纹理对光滑度的影响方向（0=正常，1=反转）。

### Color Mask 颜色遮罩
- **Mask (RGBA)** (_D_ColorMask)
  - 颜色遮罩贴图，通过RGB通道区分不同区域的应用效果。

- **Color Mask Strength** (_D101_ColorMaskStrength)

  - 遮罩整体强度（0-1），值越大颜色替换越明显。

- **Color Mask Multiplier** (_D101_ColorMaskMultiplier)

  - 遮罩效果的增强倍数（0.01-100倍）。

- **Color Mask map to** (_D102_ColorMaskMapTo)

  - 遮罩映射目标：0=基础颜色，1=细节纹理，2=两者混合。

- **Red to Color** (_D911_ColorMaskToColor_Red)

  - 红色区域替换为目标颜色（RGBA）。

- **Red Strength** (_D912_ColorMaskStr_Red)

  - 红色区域颜色替换强度（0-10）。

- **Red Emission** (_D913_ColorMaskEmit_Red)

  - 红色区域自发光强度（0-10）。

- **Green to Color** (_D921_ColorMaskToColor_Green)

  - 绿色区域替换为目标颜色（RGBA）。

- **Green Strength** (_D922_ColorMaskStr_Green)

  - 绿色区域颜色替换强度（0-10）。

- **Green Emission** (_D923_ColorMaskEmit_Green)

  - 绿色区域自发光强度（0-10）。

- **Blue to Color** (_D931_ColorMaskToColor_Blue)

  - 蓝色区域替换为目标颜色（RGBA）。

- **Blue Strength** (_D932_ColorMaskStr_Blue)

  - 蓝色区域颜色替换强度（0-10）。

- **Blue Emission** (_D933_ColorMaskEmit_Blue)

  - 蓝色区域自发光强度（0-10）。

- **Cyan to Color** (_D941_ColorMaskToColor_Cyan)

  - 青色（蓝绿混合）区域替换为目标颜色（RGBA）。

- **Cyan Strength** (_D942_ColorMaskStr_Cyan)

  - 青色区域颜色替换强度（0-10）。

- **Cyan Emission** (_D943_ColorMaskEmit_Cyan)

  - 青色区域自发光强度（0-10）。

- **Fuchsia to Color** (_D951_ColorMaskToColor_Fuchsia)

  - 品红（红蓝混合）区域替换为目标颜色（RGBA）。

- **Fuchsia Strength** (_D952_ColorMaskStr_Fuchsia)

  - 品红区域颜色替换强度（0-10）。

- **Fuchsia Emission** (_D953_ColorMaskEmit_Fuchsia)

  - 品红区域自发光强度（0-10）。

- **Yellow to Color** (_D961_ColorMaskToColor_Yellow)

  - 黄色（红绿混合）区域替换为目标颜色（RGBA）。

- **Yellow Strength** (_D962_ColorMaskStr_Yellow)

  - 黄色区域颜色替换强度（0-10）。

- **Yellow Emission** (_D963_ColorMaskEmit_Yellow)

  - 黄色区域自发光强度（0-10）。

- **White to Color** (_D971_ColorMaskToColor_White)

  - 白色区域替换为目标颜色（RGBA）。

- **White Strength** (_D972_ColorMaskStr_White)

  - 白色区域颜色替换强度（0-10）。

- **White Emission** (_D973_ColorMaskEmit_White)

  - 白色区域自发光强度（0-10）。

### Bump and Eraser 法线与擦除
- **Normal Map** (_BumpMap)

  - 主法线贴图，控制表面凹凸细节。

- **Normal Strength** (_A901_NormalStrength)

  - 主法线贴图的强度（0-10）。

- **Normal Blur** (_A9011_NormalBlur)

  - 主法线贴图的模糊程度（0-2），值越大越模糊。

- **Detail Normal Map 1** (_DetailNormalMap)

  - 第一层细节法线贴图，叠加更多凹凸细节。

- **Detail Normal 1 Strength** (_A902_DetailNormal1Strength)

  - 第一层细节法线的强度（0-10）。

- **Detail 1 Blur** (_A9021_DetailNormal1Blur)

  - 第一层细节法线的模糊程度（0-2）。

- **Detail Normal Map 2** (_DetailNormalMap2)

  - 第二层细节法线贴图，进一步增加表面细节。

- **Detail Normal 2 Strength** (_A903_DetailNormal2Strength)

  - 第二层细节法线的强度（0-10）。

- **Detail 2 Blur** (_A9031_DetailNormal2Blur)

  - 第二层细节法线的模糊程度（0-2）。

- **Bump Easer Mask** (_A_BumpEraserMask)

  - 法线擦除遮罩贴图（RGBA），定义擦除区域。

- **Bump Eraser Threshold** (_A920_BumpEraserThreshold)

  - 擦除法线的阈值（0-1），值越大擦除范围越大。

- **Bump Eraser Multiplier** (_A920_BumpEraserMultiplier)

  - 擦除效果的增强倍数（0.01-100倍）。

- **Bump Eraser Red** (_A921_BumpEraser_Red)

  - 红色区域的擦除强度（0-1）。

- **Bump Eraser Green** (_A922_BumpEraser_Green)

  - 绿色区域的擦除强度（0-1）。

- **Bump Eraser Blue** (_A923_BumpEraser_Blue)

  - 蓝色区域的擦除强度（0-1）。

- **Bump Eraser Cyan** (_A924_BumpEraser_Cyan)

  - 青色区域的擦除强度（0-1）。

- **Bump Eraser Fuchsia** (_A925_BumpEraser_Fuchsia)

  - 品红区域的擦除强度（0-1）。

- **Bump Eraser Yellow** (_A926_BumpEraser_Yellow)

  - 黄色区域的擦除强度（0-1）。

- **Bump Eraser White** (_A927_BumpEraser_White)

  - 白色区域的擦除强度（0-1）。

- **Affect Normal Map** (_A931_BumpEraserNormal)

  - 擦除效果是否影响主法线（0=否，1=是）。

- **Affect Detail Normal Map 1** (_A941_BumpEraserDetailNormal1)

  - 擦除效果是否影响第一层细节法线（0=否，1=是）。

- **Affect Detail Normal Map 2** (_A951_BumpEraserDetailNormal2)

  - 擦除效果是否影响第二层细节法线（0=否，1=是）。

### Wetness 湿润效果
- **Wetness Map** (_B_WetnessMap)

  - 湿润区域分布贴图，定义湿润范围。

- **Wetness Density** (_B1_WetnessDensity)

  - 湿润贴图的密度（0-100），控制纹理重复次数。

- **Wetness Strength** (_B2_WetnessStrength)

  - 湿润效果的整体强度（0-1）。

- **Wetness Bump Map** (_B_WetnessBumpMap)

  - 湿润法线贴图，控制湿润表面的凹凸细节。

- **Wetness Bump** (_B3_WetnessBump)

  - 湿润法线的强度（0-5）。

- **with Fluid** (_B9_WetnessWithFluid)

  - 湿润效果是否与流体效果叠加（0=否，1=是）。

### Fluid 流体效果
- **Fluid Map** (_C_FluidMap)

  - 流体区域分布贴图，定义流体范围。

- **Fluid Normal** (_C_FluidNormal)

  - 流体法线贴图，控制流体表面的凹凸细节。

- **Fluid Color** (_C1_FluidColor)

  - 流体颜色（RGBA），影响流体区域的主色调。

- **Fluid Density** (_C2_FluidDensity)

  - 流体贴图的密度（0-100），控制纹理重复次数。

- **Fluid Strength** (_C3_FluidStrength)

  - 流体效果的整体强度（0-10）。

- **Fluid Emission** (_C4_FluidEmission)

  - 流体的自发光强度（0-5）。

- **Fluid Bump** (_C5_FluidBump)

  - 流体法线的强度（0-10）。

- **Fluid Rotation** (_C6_FluidRotation)

  - 流体贴图的旋转角度（-180°~180°）。

- **Fluid Enhance Level** (_C7_FluidEnhanceLv)

  - 流体细节增强等级：0=无，1=叠加一层细节，2=叠加两层细节。

- **Fluid Mask (RGBA)** (_C_FluidMask)
  - 流体遮罩贴图，区分不同颜色区域的流体参数。

- **Mask Strength** (_C900_FluidMaskStrength)

  - 流体遮罩整体强度（0-1）。

- **Red Strength** (_C901_FluidMaskStrength_Red)

  - 红色区域的流体强度（0-1）。

- **Red Rotate** (_C905_FluidRotation_Red)

  - 红色区域流体贴图的旋转角度（-180°~180°）。

- **Red Position X/Y** (_C906/7_FluidPositionX/Y_Red)
  - 红色区域流体贴图的X/Y轴位移（-1~1）。

- **Red Scale X/Y** (_C908/9_FluidScaleX/Y_Red)
  - 红色区域流体贴图的X/Y轴缩放（-10~10，负值反转）。

  - （Green/Blue/Cyan/Fuchsia/Yellow/White区域的参数与Red区域类似，依次对应不同颜色通道）
