//
//  UIImage+FK.h
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


@interface UIImage (FK)


+ (UIImage *)fk_imageWithColor:(UIColor *)color;
/**
 *  通过传入的尺寸创建纯色UIImage
 */
+ (instancetype)fk_imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  通过传入一个view和UIColor来创建纯色image【因为view是所有UI控件的父控件】
 *
 *  @param color 传入的颜色
 *  @param view  传入的view【为了获取view的尺寸】
 *
 *  @return image
 */
+ (instancetype)fk_imageWithColor:(UIColor *)color view:(UIView *)view;

/**
 *  屏幕截图
 *
 *  @param view 需要截图的view
 *
 *  @return 返回的图片
 */
+ (instancetype)fk_imageCaptureWithView:(UIView *)view;

/**
 *  打水印
 *
 *  @param bg   背景图片
 *  @param logo 右下角的水印图片
 *
 *  @return 打好水印后的图片
 */
+ (instancetype)fk_imageWatermarkWithBg:(NSString *)bg watermark:(NSString *)watermark;

/**
 *  图片圆形裁剪
 *
 *  @param name        传入的图片名
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *
 *  @return 裁剪后的新图片
 */
+ (instancetype)fk_imageClipToCircle:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  剪切为圆形图片
 *
 *  @param image 图片
 *  @param inset 缩进的距离
 *
 *  @return 返回圆形图片
 */
+ (instancetype)fk_imageClipToCircle:(UIImage*)image inset:(CGFloat)inset;

/**
 *  根据图片名返回一张能够自由拉伸的图片
 *
 *  @param name     图片名
 *  @param horizontal 水平位置（取值范围0-1）
 *  @param vertical 垂直位置（取值范围0-1）
 *
 *  @return 返回的图片
 */
+ (UIImage *)fk_imageResized:(NSString *)name horizontal:(CGFloat)horizontal vertical:(CGFloat)vertical;

/**
 *  图片矩形裁剪
 *
 *  @param rect 传入的矩形框
 *
 *  @return 裁剪后的图片
 */
- (UIImage *)fk_imageInRect:(CGRect)rect;

/**
 *  返回一张按比例缩放的图片
 *
 *  @param size 传入的size
 *
 *  @return 缩放后的图片
 */
- (UIImage *)fk_imageByScaleToSize:(CGSize)size;
- (UIImage *)fk_imageByScaleProportionallyMinSize:(CGSize)minSize;
- (UIImage *)fk_imageByScalingProportionallyToSize:(CGSize)targetSize;

/**
 *  返回一张通过弧度旋转后的图片
 *
 *  @param radians 传入的弧度
 *
 *  @return 旋转后的图片
 */
- (UIImage *)fk_imageRotateByRadian:(CGFloat)radian;

/**
 *  返回一张通过角度旋转后的图片
 *
 *  @param angle 传入的角度
 *
 *  @return 旋转后的图片
 */
- (UIImage *)fk_imageRotateByAngle:(CGFloat)angle;

/**
 *  生成二维码
 *
 *  @param code   传入的文字
 *  @param width  宽度
 *  @param height 高度
 *
 *  @return 生成的二维码
 */
+ (UIImage *)fk_imageGenerateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height;



/****************** saveing保存【Begin 这个好像没有什么卵用】 ******************/

-(BOOL)fk_imageSaveToURL:(NSURL*)url uti:(CFStringRef)uti backgroundFillColor:(UIColor*)fillColor;

-(BOOL)fk_imageSaveToURL:(NSURL*)url type:(FKImageType)type backgroundFillColor:(UIColor*)fillColor;

-(BOOL)fk_imageSaveToURL:(NSURL*)url;

-(BOOL)fk_imageSaveToPath:(NSString*)path uti:(CFStringRef)uti backgroundFillColor:(UIColor*)fillColor;

-(BOOL)fk_imageSaveToPath:(NSString*)path;

/**
 *  保存到相册中去
 */
-(BOOL)fk_imageSaveToPhotosAlbum;

+(NSString*)fk_imageExtensionForUTI:(CFStringRef)uti;

/****************** saveing保存【End】 ******************/



/****************** 【Begin】 ******************/

/****************** 【End】 ******************/





@end
