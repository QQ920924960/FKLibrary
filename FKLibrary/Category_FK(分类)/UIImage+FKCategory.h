//
//  UIImage+FKCategory.h
//  FKLibraryExample
//
//  Created by frank on 15-11-1.
//  Copyright © 2015年 zmosa. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef enum
{
    FKCroppedModeTopLeft,
    FKCroppedModeTopCenter,
    FKCroppedModeTopRight,
    FKCroppedModeBottomLeft,
    FKCroppedModeBottomCenter,
    FKCroppedModeBottomRight,
    FKCroppedModeLeftCenter,
    FKCroppedModeRightCenter,
    FKCroppedModeCenter
} FKCroppedMode; // 裁剪模式

typedef enum
{
    FKResizeModeScaleToFill, // 拉伸填充
    FKResizeModeAspectFit,   // 保持宽高比适配
    FKResizeModeAspectFill   // 保持宽高比填充
} FKResizeMode;  // 调整模式


typedef enum
{
    FKImageTypePNG,
    FKImageTypeJPEG,
    FKImageTypeGIF,
    FKImageTypeBMP,
    FKImageTypeTIFF
} FKImageType;


@interface UIImage (FKCategory)


/**
 *  通过传入的尺寸创建纯色UIImage
 */
+ (instancetype)FKImageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  通过传入一个view和UIColor来创建纯色image【因为view是所有UI控件的父控件】
 *
 *  @param color 传入的颜色
 *  @param view  传入的view【为了获取view的尺寸】
 *
 *  @return image
 */
+ (instancetype)FKImageWithColor:(UIColor *)color view:(UIView *)view;

/**
 *  屏幕截图
 *
 *  @param view 需要截图的view
 *
 *  @return 返回的图片
 */
+ (instancetype)FKImageCaptureWithView:(UIView *)view;

/**
 *  打水印
 *
 *  @param bg   背景图片
 *  @param logo 右下角的水印图片
 *
 *  @return 打好水印后的图片
 */
+ (instancetype)FKImageWatermarkWithBg:(NSString *)bg watermark:(NSString *)watermark;

/**
 *  图片圆形裁剪
 *
 *  @param name        传入的图片名
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *
 *  @return 裁剪后的新图片
 */
+ (instancetype)FKImageClipToCircle:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  剪切为圆形图片
 *
 *  @param image 图片
 *  @param inset 缩进的距离
 *
 *  @return 返回圆形图片
 */
+ (instancetype)FKImageClipToCircle:(UIImage*)image inset:(CGFloat)inset;

/**
 *  根据图片名返回一张能够自由拉伸的图片
 *
 *  @param name     图片名
 *  @param horizontal 水平位置（取值范围0-1）
 *  @param vertical 垂直位置（取值范围0-1）
 *
 *  @return 返回的图片
 */
+ (UIImage *)FKImageResized:(NSString *)name horizontal:(CGFloat)horizontal vertical:(CGFloat)vertical;

/**
 *  图片矩形裁剪
 *
 *  @param rect 传入的矩形框
 *
 *  @return 裁剪后的图片
 */
- (UIImage *)FKImageInRect:(CGRect)rect;

/**
 *  返回一张按比例缩放的图片
 *
 *  @param size 传入的size
 *
 *  @return 缩放后的图片
 */
- (UIImage *)FKImageByScaleToSize:(CGSize)size;
- (UIImage *)FKImageByScaleProportionallyMinSize:(CGSize)minSize;
- (UIImage *)FKImageByScalingProportionallyToSize:(CGSize)targetSize;

/**
 *  返回一张通过弧度旋转后的图片
 *
 *  @param radians 传入的弧度
 *
 *  @return 旋转后的图片
 */
- (UIImage *)FKImageRotateByRadian:(CGFloat)radian;

/**
 *  返回一张通过角度旋转后的图片
 *
 *  @param angle 传入的角度
 *
 *  @return 旋转后的图片
 */
- (UIImage *)FKImageRotateByAngle:(CGFloat)angle;

/**
 *  生成二维码
 *
 *  @param code   传入的文字
 *  @param width  宽度
 *  @param height 高度
 *
 *  @return 生成的二维码
 */
+ (UIImage *)FKImageGenerateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height;






/****************** blur模糊效果【Begin】 ******************/

/**
 *  通过传入偏移量来设置高斯模糊
 *
 *  @param bias 偏移量
 *
 *  @return 设置后的图片
 */
-(UIImage*)FKImageGaussianBlurWithBias:(NSInteger)bias;

/****************** blur模糊效果【End】 ******************/



/****************** enhance增强效果【Begin】 ******************/

/**
 *  自动增强
 */
-(UIImage*)FKImageAutoEnhance;

/**
 *  红眼修正
 */
-(UIImage*)FKImageRedEyeCorrection;

/****************** enhance增强效果【End】 ******************/



/****************** filter滤镜效果【Begin】 ******************/

/**
 *  亮度
 */
-(UIImage*)FKImageBrightenWithValue:(float)factor;

/**
 *  对比度
 */
-(UIImage*)FKImageContrastAdjustmentWithValue:(float)value;

/**
 *  边缘检测
 *
 *  @param bias 偏移量
 */
-(UIImage*)FKImageEdgeDetectionWithBias:(NSInteger)bias;

/**
 *  浮雕效果
 *
 *  @param bias 偏移量
 */
-(UIImage*)FKImageEmbossWithBias:(NSInteger)bias;

/**
 *  伽马校正
 */
-(UIImage*)FKImageGammaCorrectionWithValue:(float)value;

/**
 *  灰度
 */
-(UIImage*)FKImageGrayscale;

/**
 *  反转
 */
-(UIImage*)FKImageInvert;

/**
 *  不透明度
 */
-(UIImage*)FKImageOpacity:(float)value;

/**
 *  色片
 */
-(UIImage*)FKImageSepia;

/**
 *  锐化
 */
-(UIImage*)FKImagesSarpenWithBias:(NSInteger)bias;

/**
 *  模糊【锐化的反义词】
 */
-(UIImage*)FKImageUnsharpenWithBias:(NSInteger)bias;

/****************** filter滤镜效果【End】 ******************/



/****************** mask遮罩效果【Begin】 ******************/

/**
 *  添加遮罩
 *
 *  @param mask 遮罩图片
 */
-(UIImage*)FKImageMaskWithImage:(UIImage*)mask;

/****************** mask遮罩效果【End】 ******************/



/****************** Reflection光照效果【Begin】 ******************/

/**
 *  光照效果【反射】
 *
 *  @param height    高度
 *  @param fromAlpha 起始alpha
 *  @param toAlpha   结束alpha
 *
 *  @return 最终图片
 */
-(UIImage*)reflectedImageWithHeight:(NSUInteger)height fromAlpha:(float)fromAlpha toAlpha:(float)toAlpha;

/****************** Reflection光照效果【End】 ******************/




/****************** Resizing图片调整:裁剪、缩放【Begin】 ******************/

/**
 *  裁剪图片
 *
 *  @param newSize  新的尺寸
 *  @param cropMode 裁剪模式
 *
 *  @return 裁剪后的图片
 */
-(UIImage*)FKImageCroppedToSize:(CGSize)newSize usingMode:(FKCroppedMode)croppedMode;

/**
 *  以左上角为坐标原点进行裁剪【FKCropModeTopLeft crop mode used】
 *
 *  @param newSize 新的尺寸
 *
 *  @return 裁剪后的图片
 */
-(UIImage*)FKImageTopLeftCroppedToSize:(CGSize)newSize;

/**
 *  图片缩放
 *
 *  @param scaleFactor 缩放比例
 */
-(UIImage*)FKImageScaleByFactor:(float)scaleFactor;

/**
 *  给定一个模式进行缩放
 *
 *  @param newSize    新的尺寸
 *  @param resizeMode 缩放模式
 *
 *  @return 缩放后的图片
 */
-(UIImage*)FKImageScaleToSize:(CGSize)newSize usingMode:(FKResizeMode)resizeMode;

/**
 *  以缩放填充的模式进行拉伸【FKResizeModeScaleToFill resize mode used】
 *
 *  @param newSize 新的尺寸
 *
 *  @return 缩放后的图片
 */
-(UIImage*)FKImageScaleToSize:(CGSize)newSize;

/**
 *  类似于scale to fill【Same as 'scale to fill' in IB.】
 *
 *  @param newSize 新的尺寸
 *
 *  @return 缩放后的图片
 */
-(UIImage*)FKImageScaleToFillSize:(CGSize)newSize;

/**
 *  保持宽高比缩放,类似于aspect fit【Preserves aspect ratio. Same as 'aspect fit' in IB.】
 *
 *  @param newSize 新的尺寸
 *
 *  @return 缩放后的图片
 */
-(UIImage*)FKImageScaleToFitSize:(CGSize)newSize;

/**
 *  保持宽高比进行填充缩放,类似于aspect fill【Preserves aspect ratio. Same as 'aspect fill' in IB.】
 *
 *  @param newSize 新的尺寸
 *
 *  @return 缩放后的图片
 */
-(UIImage*)FKImageScaleToCoverSize:(CGSize)newSize;

/****************** Resizing图片调整:裁剪、缩放【End】 ******************/



/****************** Rotate旋转效果【Begin】 ******************/

/**
 *  给定一个弧度进行旋转
 *
 *  @param radians 弧度
 *
 *  @return 旋转后的图片
 */
-(UIImage*)FKImageRotateInRadians:(float)radians;

/**
 *  给定一个角度进行旋转
 *
 *  @param angle 角度
 *
 *  @return 旋转后的图片
 */
-(UIImage*)FKImageRotateInAngle:(float)angle;

/**
 *  给定一个弧度给图片的像素进行旋转
 *
 *  @param radians 弧度
 *
 *  @return 旋转后的图片
 */
-(UIImage*)FKImageRotateImagePixelsInRadians:(float)radians;

/**
 *  给定一个角度给图片的像素进行旋转
 *
 *  @param angle 角度
 *
 *  @return 旋转后的图片
 */
-(UIImage*)FKImageRotateImagePixelsInAngle:(float)angle;

/**
 *  垂直翻转
 */
-(UIImage*)FKImageVerticalFlip;

/**
 *  水平翻转
 */
-(UIImage*)FKImageHorizontalFlip;

/****************** Rotate旋转效果【End】 ******************/




/****************** saveing保存【Begin 这个好像没有什么卵用】 ******************/

-(BOOL)FKImageSaveToURL:(NSURL*)url uti:(CFStringRef)uti backgroundFillColor:(UIColor*)fillColor;

-(BOOL)FKImageSaveToURL:(NSURL*)url type:(FKImageType)type backgroundFillColor:(UIColor*)fillColor;

-(BOOL)FKImageSaveToURL:(NSURL*)url;

-(BOOL)FKImageSaveToPath:(NSString*)path uti:(CFStringRef)uti backgroundFillColor:(UIColor*)fillColor;

-(BOOL)FKImageSaveToPath:(NSString*)path type:(FKImageType)type backgroundFillColor:(UIColor*)fillColor;

-(BOOL)FKImageSaveToPath:(NSString*)path;

/**
 *  保存到相册中去
 */
-(BOOL)FKImageSaveToPhotosAlbum;

+(NSString*)FKImageExtensionForUTI:(CFStringRef)uti;

/****************** saveing保存【End】 ******************/



/****************** 【Begin】 ******************/

/****************** 【End】 ******************/



/****************** 【Begin】 ******************/

/****************** 【End】 ******************/



/****************** 【Begin】 ******************/

/****************** 【End】 ******************/



/****************** 【Begin】 ******************/

/****************** 【End】 ******************/



@end
