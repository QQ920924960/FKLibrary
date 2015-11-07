//
//  UIImage+FKCategory.m
//  FKLibraryExample
//
//  Created by frank on 15-11-1.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "UIImage+FKCategory.h"
#import <Accelerate/Accelerate.h>
#import <ImageIO/ImageIO.h> // For CGImageDestination
#import <MobileCoreServices/MobileCoreServices.h> // For the UTI types constants
#import <AssetsLibrary/AssetsLibrary.h> // For photos album saving

#import "FKImageTools.h"
/**
 *  角度转弧度
 *
 *  @param Angle 角度
 *
 *  @return 弧度
 */
static CGFloat const AngleToRadian(CGFloat angle) {return angle * M_PI / 180;};

/**
 *  弧度转角度
 *
 *  @param Angle 弧度
 *
 *  @return 角度
 */
static CGFloat const RadianToAngle(CGFloat radian) {return radian * 180/M_PI;};

static int16_t __s_gaussianblur_kernel_5x5[25] = {
    1, 4, 6, 4, 1,
    4, 16, 24, 16, 4,
    6, 24, 36, 24, 6,
    4, 16, 24, 16, 4,
    1, 4, 6, 4, 1
};

/* Sepia values for manual filtering (< iOS 5) */
static float const __sepiaFactorRedRed = 0.393f;
static float const __sepiaFactorRedGreen = 0.349f;
static float const __sepiaFactorRedBlue = 0.272f;
static float const __sepiaFactorGreenRed = 0.769f;
static float const __sepiaFactorGreenGreen = 0.686f;
static float const __sepiaFactorGreenBlue = 0.534f;
static float const __sepiaFactorBlueRed = 0.189f;
static float const __sepiaFactorBlueGreen = 0.168f;
static float const __sepiaFactorBlueBlue = 0.131f;

/* Negative multiplier to invert a number */
static float __negativeMultiplier = -1.0f;

#pragma mark - Edge detection kernels
/* vImage kernel */
/*static int16_t __s_edgedetect_kernel_3x3[9] = {
	-1, -1, -1,
	-1, 8, -1,
	-1, -1, -1
 };*/
/* vDSP kernel */
static float __f_edgedetect_kernel_3x3[9] = {
    -1.0f, -1.0f, -1.0f,
    -1.0f, 8.0f, -1.0f,
    -1.0f, -1.0f, -1.0f
};

#pragma mark - Emboss kernels
/* vImage kernel */
static int16_t __s_emboss_kernel_3x3[9] = {
    -2, 0, 0,
    0, 1, 0,
    0, 0, 2
};

#pragma mark - Sharpen kernels
/* vImage kernel */
static int16_t __s_sharpen_kernel_3x3[9] = {
    -1, -1, -1,
    -1, 9, -1,
    -1, -1, -1
};

#pragma mark - Unsharpen kernels
/* vImage kernel */
static int16_t __s_unsharpen_kernel_3x3[9] = {
    -1, -1, -1,
    -1, 17, -1, 
    -1, -1, -1
};

@interface UIImage (FKCategory_private)
-(CFStringRef)utiForType:(FKImageType)type;
@end

@implementation UIImage (FKCategory)

+ (instancetype)FKImageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *pureColorImage = (UIImage *)UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pureColorImage;
}

+ (instancetype)FKImageWithColor:(UIColor *)color view:(UIView *)view
{
    CGSize size = CGSizeMake(view.bounds.size.width, view.bounds.size.height);
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *pureColorImage = (UIImage *)UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pureColorImage;
}

+ (instancetype)FKImageCaptureWithView:(UIView *)view
{
    // 1.开启上下文
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    
    // 2.将控制器view的layer渲染到上下文
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // 3.取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (instancetype)FKImageWatermarkWithBg:(NSString *)bg watermark:(NSString *)watermark
{
    UIImage *bgImage = [UIImage imageNamed:bg];
    
    // 1.创建一个基于位图的上下文(开启一个基于位图的上下文)
    UIGraphicsBeginImageContextWithOptions(bgImage.size, NO, 0.0);
    
    // 2.画背景
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    
    // 3.画右下角的水印
    UIImage *waterImage = [UIImage imageNamed:watermark];
    CGFloat scale = 0.2;
    CGFloat margin = 5;
    CGFloat waterW = waterImage.size.width * scale;
    CGFloat waterH = waterImage.size.height * scale;
    CGFloat waterX = bgImage.size.width - waterW - margin;
    CGFloat waterY = bgImage.size.height - waterH - margin;
    [waterImage drawInRect:CGRectMake(waterX, waterY, waterW, waterH)];
    
    // 4.从上下文中取得制作完毕的UIImage对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 5.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (instancetype)FKImageClipToCircle:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    // 1.加载原图
    UIImage *oldImage = [UIImage imageNamed:name];
    
    // 2.开启上下文
    CGFloat imageW = oldImage.size.width + 2 * borderWidth;
    CGFloat imageH = oldImage.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (instancetype)FKImageClipToCircle:(UIImage*)image inset:(CGFloat)inset {
    // 开启上下文
    UIGraphicsBeginImageContext(image.size);
    // 取得上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置线宽
    CGContextSetLineWidth(context, 2);
    // 设置空心颜色
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    // 得到缩进的frame
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
    // 画圆
    CGContextAddEllipseInRect(context, rect);
    // 裁剪
    CGContextClip(context);
    // 将image绘制到裁剪后的范围内
    [image drawInRect:rect];
    // 画圆
    CGContextAddEllipseInRect(context, rect);
    // 设置空心颜色
    CGContextStrokePath(context);
    // 新的图片
    UIImage *newimg = (UIImage *)UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文【释放内存】
    UIGraphicsEndImageContext();
    return newimg;
}

+ (UIImage *)FKImageResized:(NSString *)name horizontal:(CGFloat)horizontal vertical:(CGFloat)vertical
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * vertical topCapHeight:image.size.height * vertical];
}

-(UIImage *)FKImageInRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage* subImage = [UIImage imageWithCGImage: imageRef];
    CGImageRelease(imageRef);
    return subImage;
}

- (UIImage *)FKImageByScaleProportionallyMinSize:(CGSize)minSize {
    
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = minSize.width;
    CGFloat targetHeight = minSize.height;
    
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, minSize) == NO) {
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(minSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(newImage == nil) NSLog(@"could not scale image");
    
    
    return newImage ;
}


- (UIImage *)FKImageByScalingProportionallyToSize:(CGSize)targetSize {
    
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor < heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        
        if (widthFactor < heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor > heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(newImage == nil) NSLog(@"could not scale image");
    
    
    return newImage ;
}


- (UIImage *)FKImageByScaleToSize:(CGSize)size {
    
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(newImage == nil) NSLog(@"could not scale image");
    
    return newImage ;
}


- (UIImage *)FKImageRotateByRadian:(CGFloat)radian
{
    return [self FKImageRotateByAngle:RadianToAngle(radian)];
}

- (UIImage *)FKImageRotateByAngle:(CGFloat)angle
{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(AngleToRadian(angle));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    // ARC环境下不用release
//    [rotatedViewBox release];
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, AngleToRadian(angle));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}

+ (UIImage *)FKImageGenerateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height{
    
    // 生成二维码图片
    CIImage *qrcodeImage;
    // 将字符串采用utf-8编码生成NSData
    NSData *data = [code dataUsingEncoding:NSUTF8StringEncoding];
    // 添加滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 输入数据
    [filter setValue:data forKey:@"inputMessage"];
    // 输入校正水平
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    // 输出二维码
    qrcodeImage = [filter outputImage];
    
    // 消除模糊【extent:返回图片的frame】
    CGFloat scaleX = width / qrcodeImage.extent.size.width;
    CGFloat scaleY = height / qrcodeImage.extent.size.height;
    CIImage *transformedImage = [qrcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    return [UIImage imageWithCIImage:transformedImage];
}










/****************** blur模糊效果【Begin】 ******************/

-(UIImage*)FKImageGaussianBlurWithBias:(NSInteger)bias
{
    // Create an ARGB bitmap context【创建一个ARGB的位图上下文】
    const size_t width = (size_t)self.size.width;
    const size_t height = (size_t)self.size.height;
    const size_t bytesPerRow = width * kFKNumberOfComponentsPerARBGPixel;
    CGContextRef bmContext = FKCreateARGBBitmapContext(width, height, bytesPerRow, FKImageHasAlpha(self.CGImage));
    if (!bmContext)
        return nil;
    
    /// Draw the image in the bitmap context【将image画在上下文中】
    CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage);
    
    /// Grab the image raw data【获取image数据】
    UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
    if (!data)
    {
        CGContextRelease(bmContext);
        return nil;
    }
    
    const size_t n = sizeof(UInt8) * width * height * 4;
    void* outt = malloc(n);
    vImage_Buffer src = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {outt, height, width, bytesPerRow};
    vImageConvolveWithBias_ARGB8888(&src, &dest, NULL, 0, 0, __s_gaussianblur_kernel_5x5, 5, 5, 256/*divisor*/, (int32_t)bias, NULL, kvImageCopyInPlace);
    memcpy(data, outt, n);
    free(outt);
    
    CGImageRef blurredImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* blurred = [UIImage imageWithCGImage:blurredImageRef];
    
    /// Cleanup【释放内存】
    CGImageRelease(blurredImageRef);
    CGContextRelease(bmContext);
    
    return blurred;
}

/****************** blur模糊效果【End】 ******************/



/****************** enhance增强效果【Begin】 ******************/

-(UIImage*)FKImageAutoEnhance
{
    /// No Core Image, return original image【如果不是核心图像，则放回原始图片】
    if (![CIImage class]) return self;
    
    CIImage* ciImage = [[CIImage alloc] initWithCGImage:self.CGImage];
    
    NSArray* adjustments = [ciImage autoAdjustmentFiltersWithOptions:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:kCIImageAutoAdjustRedEye]];
    
    for (CIFilter* filter in adjustments)
    {
        [filter setValue:ciImage forKey:kCIInputImageKey];
        ciImage = filter.outputImage;
    }
    
    CIContext* ctx = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [ctx createCGImage:ciImage fromRect:[ciImage extent]];
    UIImage* final = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return final;
}

-(UIImage*)FKImageRedEyeCorrection
{
    /// No Core Image, return original image
    if (![CIImage class])
        return self;
    
    CIImage* ciImage = [[CIImage alloc] initWithCGImage:self.CGImage];
    
    /// Get the filters and apply them to the image
    NSArray* filters = [ciImage autoAdjustmentFiltersWithOptions:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:kCIImageAutoAdjustEnhance]];
    for (CIFilter* filter in filters)
    {
        [filter setValue:ciImage forKey:kCIInputImageKey];
        ciImage = filter.outputImage;
    }
    
    /// Create the corrected image
    CIContext* ctx = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [ctx createCGImage:ciImage fromRect:[ciImage extent]];
    UIImage* final = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return final;
}

/****************** enhance增强效果【End】 ******************/


/****************** filter滤镜效果【Begin】 ******************/

// Value should be in the range (-255, 255)
-(UIImage*)FKImageBrightenWithValue:(float)value
{
    /// Create an ARGB bitmap context
    const size_t width = (size_t)self.size.width;
    const size_t height = (size_t)self.size.height;
    CGContextRef bmContext = FKCreateARGBBitmapContext(width, height, width * kFKNumberOfComponentsPerARBGPixel, FKImageHasAlpha(self.CGImage));
    if (!bmContext)
        return nil;
    
    /// Draw the image in the bitmap context
    CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage);
    
    /// Grab the image raw data
    UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
    if (!data)
    {
        CGContextRelease(bmContext);
        return nil;
    }
    
    const size_t pixelsCount = width * height;
    float* dataAsFloat = (float*)malloc(sizeof(float) * pixelsCount);
    float min = (float)kFKMinPixelComponentValue, max = (float)kFKMaxPixelComponentValue;
    
    /// Calculate red components
    vDSP_vfltu8(data + 1, 4, dataAsFloat, 1, pixelsCount);
    vDSP_vsadd(dataAsFloat, 1, &value, dataAsFloat, 1, pixelsCount);
    vDSP_vclip(dataAsFloat, 1, &min, &max, dataAsFloat, 1, pixelsCount);
    vDSP_vfixu8(dataAsFloat, 1, data + 1, 4, pixelsCount);
    
    /// Calculate green components
    vDSP_vfltu8(data + 2, 4, dataAsFloat, 1, pixelsCount);
    vDSP_vsadd(dataAsFloat, 1, &value, dataAsFloat, 1, pixelsCount);
    vDSP_vclip(dataAsFloat, 1, &min, &max, dataAsFloat, 1, pixelsCount);
    vDSP_vfixu8(dataAsFloat, 1, data + 2, 4, pixelsCount);
    
    /// Calculate blue components
    vDSP_vfltu8(data + 3, 4, dataAsFloat, 1, pixelsCount);
    vDSP_vsadd(dataAsFloat, 1, &value, dataAsFloat, 1, pixelsCount);
    vDSP_vclip(dataAsFloat, 1, &min, &max, dataAsFloat, 1, pixelsCount);
    vDSP_vfixu8(dataAsFloat, 1, data + 3, 4, pixelsCount);
    
    CGImageRef brightenedImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* brightened = [UIImage imageWithCGImage:brightenedImageRef scale:self.scale orientation:self.imageOrientation];
    
    /// Cleanup
    CGImageRelease(brightenedImageRef);
    free(dataAsFloat);
    CGContextRelease(bmContext);
    
    return brightened;
}

/// (-255, 255)
-(UIImage*)FKImageContrastAdjustmentWithValue:(float)value
{
    /// Create an ARGB bitmap context
    const size_t width = (size_t)self.size.width;
    const size_t height = (size_t)self.size.height;
    CGContextRef bmContext = FKCreateARGBBitmapContext(width, height, width * kFKNumberOfComponentsPerARBGPixel, FKImageHasAlpha(self.CGImage));
    if (!bmContext)
        return nil;
    
    /// Draw the image in the bitmap context
    CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage);
    
    /// Grab the image raw data
    UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
    if (!data)
    {
        CGContextRelease(bmContext);
        return nil;
    }
    
    const size_t pixelsCount = width * height;
    float* dataAsFloat = (float*)malloc(sizeof(float) * pixelsCount);
    float min = (float)kFKMinPixelComponentValue, max = (float)kFKMaxPixelComponentValue;
    
    /// Contrast correction factor
    const float factor = (259.0f * (value + 255.0f)) / (255.0f * (259.0f - value));
    
    float v1 = -128.0f, v2 = 128.0f;
    
    /// Calculate red components
    vDSP_vfltu8(data + 1, 4, dataAsFloat, 1, pixelsCount);
    vDSP_vsadd(dataAsFloat, 1, &v1, dataAsFloat, 1, pixelsCount);
    vDSP_vsmul(dataAsFloat, 1, &factor, dataAsFloat, 1, pixelsCount);
    vDSP_vsadd(dataAsFloat, 1, &v2, dataAsFloat, 1, pixelsCount);
    vDSP_vclip(dataAsFloat, 1, &min, &max, dataAsFloat, 1, pixelsCount);
    vDSP_vfixu8(dataAsFloat, 1, data + 1, 4, pixelsCount);
    
    /// Calculate green components
    vDSP_vfltu8(data + 2, 4, dataAsFloat, 1, pixelsCount);
    vDSP_vsadd(dataAsFloat, 1, &v1, dataAsFloat, 1, pixelsCount);
    vDSP_vsmul(dataAsFloat, 1, &factor, dataAsFloat, 1, pixelsCount);
    vDSP_vsadd(dataAsFloat, 1, &v2, dataAsFloat, 1, pixelsCount);
    vDSP_vclip(dataAsFloat, 1, &min, &max, dataAsFloat, 1, pixelsCount);
    vDSP_vfixu8(dataAsFloat, 1, data + 2, 4, pixelsCount);
    
    /// Calculate blue components
    vDSP_vfltu8(data + 3, 4, dataAsFloat, 1, pixelsCount);
    vDSP_vsadd(dataAsFloat, 1, &v1, dataAsFloat, 1, pixelsCount);
    vDSP_vsmul(dataAsFloat, 1, &factor, dataAsFloat, 1, pixelsCount);
    vDSP_vsadd(dataAsFloat, 1, &v2, dataAsFloat, 1, pixelsCount);
    vDSP_vclip(dataAsFloat, 1, &min, &max, dataAsFloat, 1, pixelsCount);
    vDSP_vfixu8(dataAsFloat, 1, data + 3, 4, pixelsCount);
    
    /// Create an image object from the context
    CGImageRef contrastedImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* contrasted = [UIImage imageWithCGImage:contrastedImageRef scale:self.scale orientation:self.imageOrientation];
    
    /// Cleanup
    CGImageRelease(contrastedImageRef);
    free(dataAsFloat);
    CGContextRelease(bmContext);
    
    return contrasted;
}

-(UIImage*)FKImageEdgeDetectionWithBias:(NSInteger)bias
{
#pragma unused(bias)
    /// Create an ARGB bitmap context
    const size_t width = (size_t)self.size.width;
    const size_t height = (size_t)self.size.height;
    const size_t bytesPerRow = width * kFKNumberOfComponentsPerARBGPixel;
    CGContextRef bmContext = FKCreateARGBBitmapContext(width, height, bytesPerRow, FKImageHasAlpha(self.CGImage));
    if (!bmContext)
        return nil;
    
    /// Draw the image in the bitmap context
    CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage);
    
    /// Grab the image raw data
    UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
    if (!data)
    {
        CGContextRelease(bmContext);
        return nil;
    }
    
    /// vImage (iOS 5) works on simulator but not on device
    /*if ((&vImageConvolveWithBias_ARGB8888))
     {
     const size_t n = sizeof(UInt8) * width * height * 4;
     void* outt = malloc(n);
     vImage_Buffer src = {data, height, width, bytesPerRow};
     vImage_Buffer dest = {outt, height, width, bytesPerRow};
     
     vImageConvolveWithBias_ARGB8888(&src, &dest, NULL, 0, 0, __s_edgedetect_kernel_3x3, 3, 3, 1, bias, NULL, kvImageCopyInPlace);
     
     CGDataProviderRef dp = CGDataProviderCreateWithData(NULL, data, n, NULL);
     
     CGColorSpaceRef cs = CGColorSpaceCreateDeviceRGB();
     CGImageRef edgedImageRef = CGImageCreate(width, height, 8, 32, bytesPerRow, cs, kCGBitmapByteOrderDefault | kCGImageAlphaNoneSkipFirst, dp, NULL, true, kCGRenderingIntentDefault);
     CGColorSpaceRelease(cs);
     
     //memcpy(data, outt, n);
     //CGImageRef edgedImageRef = CGBitmapContextCreateImage(bmContext);
     UIImage* edged = [UIImage imageWithCGImage:edgedImageRef];
     
     /// Cleanup
     CGImageRelease(edgedImageRef);
     CGDataProviderRelease(dp);
     free(outt);
     CGContextRelease(bmContext);
     
     return edged;
     }
     else
     {*/
    const size_t pixelsCount = width * height;
    const size_t n = sizeof(float) * pixelsCount;
    float* dataAsFloat = malloc(n);
    float* resultAsFloat = malloc(n);
    float min = (float)kFKMinPixelComponentValue, max = (float)kFKMaxPixelComponentValue;
    
    /// Red components
    vDSP_vfltu8(data + 1, 4, dataAsFloat, 1, pixelsCount);
    vDSP_f3x3(dataAsFloat, height, width, __f_edgedetect_kernel_3x3, resultAsFloat);
    vDSP_vclip(resultAsFloat, 1, &min, &max, resultAsFloat, 1, pixelsCount);
    vDSP_vfixu8(resultAsFloat, 1, data + 1, 4, pixelsCount);
    
    /// Green components
    vDSP_vfltu8(data + 2, 4, dataAsFloat, 1, pixelsCount);
    vDSP_f3x3(dataAsFloat, height, width, __f_edgedetect_kernel_3x3, resultAsFloat);
    vDSP_vclip(resultAsFloat, 1, &min, &max, resultAsFloat, 1, pixelsCount);
    vDSP_vfixu8(resultAsFloat, 1, data + 2, 4, pixelsCount);
    
    /// Blue components
    vDSP_vfltu8(data + 3, 4, dataAsFloat, 1, pixelsCount);
    vDSP_f3x3(dataAsFloat, height, width, __f_edgedetect_kernel_3x3, resultAsFloat);
    vDSP_vclip(resultAsFloat, 1, &min, &max, resultAsFloat, 1, pixelsCount);
    vDSP_vfixu8(resultAsFloat, 1, data + 3, 4, pixelsCount);
    
    CGImageRef edgedImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* edged = [UIImage imageWithCGImage:edgedImageRef];
    
    /// Cleanup
    CGImageRelease(edgedImageRef);
    free(resultAsFloat);
    free(dataAsFloat);
    CGContextRelease(bmContext);
    
    return edged;
    //}
}

-(UIImage*)FKImageEmbossWithBias:(NSInteger)bias
{
    /// Create an ARGB bitmap context
    const size_t width = (size_t)self.size.width;
    const size_t height = (size_t)self.size.height;
    const size_t bytesPerRow = width * kFKNumberOfComponentsPerARBGPixel;
    CGContextRef bmContext = FKCreateARGBBitmapContext(width, height, bytesPerRow, FKImageHasAlpha(self.CGImage));
    if (!bmContext)
        return nil;
    
    /// Draw the image in the bitmap context
    CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage);
    
    /// Grab the image raw data
    UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
    if (!data)
    {
        CGContextRelease(bmContext);
        return nil;
    }
    
    const size_t n = sizeof(UInt8) * width * height * 4;
    void* outt = malloc(n);
    vImage_Buffer src = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {outt, height, width, bytesPerRow};
    vImageConvolveWithBias_ARGB8888(&src, &dest, NULL, 0, 0, __s_emboss_kernel_3x3, 3, 3, 1/*divisor*/, (int32_t)bias, NULL, kvImageCopyInPlace);
    
    memcpy(data, outt, n);
    
    free(outt);
    
    CGImageRef embossImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* emboss = [UIImage imageWithCGImage:embossImageRef];
    
    /// Cleanup
    CGImageRelease(embossImageRef);
    CGContextRelease(bmContext);
    
    return emboss;
}

/// (0.01, 8)
-(UIImage*)FKImageGammaCorrectionWithValue:(float)value
{
    const size_t width = (size_t)self.size.width;
    const size_t height = (size_t)self.size.height;
    /// Number of bytes per row, each pixel in the bitmap will be represented by 4 bytes (ARGB), 8 bits of alpha/red/green/blue
    const size_t bytesPerRow = width * kFKNumberOfComponentsPerARBGPixel;
    
    /// Create an ARGB bitmap context
    CGContextRef bmContext = FKCreateARGBBitmapContext(width, height, bytesPerRow, FKImageHasAlpha(self.CGImage));
    if (!bmContext)
        return nil;
    
    /// Draw the image in the bitmap context
    CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage);
    
    /// Grab the image raw data
    UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
    if (!data)
    {
        CGContextRelease(bmContext);
        return nil;
    }
    
    const size_t pixelsCount = width * height;
    const size_t n = sizeof(float) * pixelsCount;
    float* dataAsFloat = (float*)malloc(n);
    float* temp = (float*)malloc(n);
    float min = (float)kFKMinPixelComponentValue, max = (float)kFKMaxPixelComponentValue;
    const int iPixels = (int)pixelsCount;
    
    /// Need a vector with same size :(
    vDSP_vfill(&value, temp, 1, pixelsCount);
    
    /// Calculate red components
    vDSP_vfltu8(data + 1, 4, dataAsFloat, 1, pixelsCount);
    vDSP_vsdiv(dataAsFloat, 1, &max, dataAsFloat, 1, pixelsCount);
    vvpowf(dataAsFloat, temp, dataAsFloat, &iPixels);
    vDSP_vsmul(dataAsFloat, 1, &max, dataAsFloat, 1, pixelsCount);
    vDSP_vclip(dataAsFloat, 1, &min, &max, dataAsFloat, 1, pixelsCount);
    vDSP_vfixu8(dataAsFloat, 1, data + 1, 4, pixelsCount);
    
    /// Calculate green components
    vDSP_vfltu8(data + 2, 4, dataAsFloat, 1, pixelsCount);
    vDSP_vsdiv(dataAsFloat, 1, &max, dataAsFloat, 1, pixelsCount);
    vvpowf(dataAsFloat, temp, dataAsFloat, &iPixels);
    vDSP_vsmul(dataAsFloat, 1, &max, dataAsFloat, 1, pixelsCount);
    vDSP_vclip(dataAsFloat, 1, &min, &max, dataAsFloat, 1, pixelsCount);
    vDSP_vfixu8(dataAsFloat, 1, data + 2, 4, pixelsCount);
    
    /// Calculate blue components
    vDSP_vfltu8(data + 3, 4, dataAsFloat, 1, pixelsCount);
    vDSP_vsdiv(dataAsFloat, 1, &max, dataAsFloat, 1, pixelsCount);
    vvpowf(dataAsFloat, temp, dataAsFloat, &iPixels);
    vDSP_vsmul(dataAsFloat, 1, &max, dataAsFloat, 1, pixelsCount);
    vDSP_vclip(dataAsFloat, 1, &min, &max, dataAsFloat, 1, pixelsCount);
    vDSP_vfixu8(dataAsFloat, 1, data + 3, 4, pixelsCount);
    
    /// Cleanup
    free(temp);
    free(dataAsFloat);
    
    /// Create an image object from the context
    CGImageRef gammaImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* gamma = [UIImage imageWithCGImage:gammaImageRef];
    
    /// Cleanup
    CGImageRelease(gammaImageRef);
    CGContextRelease(bmContext);
    
    return gamma;
}

-(UIImage*)FKImageGrayscale
{
    /* const UInt8 luminance = (red * 0.2126) + (green * 0.7152) + (blue * 0.0722); // Good luminance value */
    /// Create a gray bitmap context
    const size_t width = (size_t)(self.size.width * self.scale);
    const size_t height = (size_t)(self.size.height * self.scale);
    
    CGRect imageRect = CGRectMake(0, 0, width, height);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8/*Bits per component*/, width * kFKNumberOfComponentsPerGreyPixel, colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    
    // Image quality【图像质量】
    CGContextSetShouldAntialias(bmContext, false);
    CGContextSetInterpolationQuality(bmContext, kCGInterpolationHigh);
    
    /// Draw the image in the bitmap context【将image画在位图上下文中】
    CGContextDrawImage(bmContext, imageRect, self.CGImage);
    
    /// Create an image object from the context【在上下文中创建一个位图对象】
    CGImageRef grayscaledImageRef = CGBitmapContextCreateImage(bmContext);
    CGContextRelease(bmContext);
    
    // Preserve alpha channel by creating context with 'alpha only' values【通过alpah值创建上下文来保存alpha通道】
    bmContext = CGBitmapContextCreate(nil, width, height, 8, width, nil, (CGBitmapInfo) kCGImageAlphaOnly);
    CGContextDrawImage(bmContext, imageRect, [self CGImage]);
    
    // and using it as a mask for previously generated `grayscaledImageRef`【将上面生成的“grayscaledImageRef”作为一个遮罩】
    CGImageRef mask = CGBitmapContextCreateImage(bmContext);
    CGImageRef finalImageRef = CGImageCreateWithMask(grayscaledImageRef, mask);
    UIImage *grayscaled = [UIImage imageWithCGImage:finalImageRef scale:self.scale orientation:self.imageOrientation];
    
    /// Cleanup
    CGImageRelease(grayscaledImageRef);
    CGContextRelease(bmContext);
    CGImageRelease(mask);
    CGImageRelease(finalImageRef);
    
    return grayscaled;
}

-(UIImage*)FKImageInvert
{
    /// Create an ARGB bitmap context
    const size_t width = (size_t)self.size.width;
    const size_t height = (size_t)self.size.height;
    CGContextRef bmContext = FKCreateARGBBitmapContext(width, height, width * kFKNumberOfComponentsPerARBGPixel, FKImageHasAlpha(self.CGImage));
    if (!bmContext)
        return nil;
    
    /// Draw the image in the bitmap context
    CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage);
    
    /// Grab the image raw data
    UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
    if (!data)
    {
        CGContextRelease(bmContext);
        return nil;
    }
    
    const size_t pixelsCount = width * height;
    float* dataAsFloat = (float*)malloc(sizeof(float) * pixelsCount);
    float min = (float)kFKMinPixelComponentValue, max = (float)kFKMaxPixelComponentValue;
    UInt8* dataRed = data + 1;
    UInt8* dataGreen = data + 2;
    UInt8* dataBlue = data + 3;
    
    /// vDSP_vsmsa() = multiply then add
    /// slightly faster than the couple vDSP_vneg() & vDSP_vsadd()
    /// Probably because there are 3 function calls less
    
    /// Calculate red components
    vDSP_vfltu8(dataRed, 4, dataAsFloat, 1, pixelsCount);
    vDSP_vsmsa(dataAsFloat, 1, &__negativeMultiplier, &max, dataAsFloat, 1, pixelsCount);
    vDSP_vclip(dataAsFloat, 1, &min, &max, dataAsFloat, 1, pixelsCount);
    vDSP_vfixu8(dataAsFloat, 1, dataRed, 4, pixelsCount);
    
    /// Calculate green components
    vDSP_vfltu8(dataGreen, 4, dataAsFloat, 1, pixelsCount);
    vDSP_vsmsa(dataAsFloat, 1, &__negativeMultiplier, &max, dataAsFloat, 1, pixelsCount);
    vDSP_vclip(dataAsFloat, 1, &min, &max, dataAsFloat, 1, pixelsCount);
    vDSP_vfixu8(dataAsFloat, 1, dataGreen, 4, pixelsCount);
    
    /// Calculate blue components
    vDSP_vfltu8(dataBlue, 4, dataAsFloat, 1, pixelsCount);
    vDSP_vsmsa(dataAsFloat, 1, &__negativeMultiplier, &max, dataAsFloat, 1, pixelsCount);
    vDSP_vclip(dataAsFloat, 1, &min, &max, dataAsFloat, 1, pixelsCount);
    vDSP_vfixu8(dataAsFloat, 1, dataBlue, 4, pixelsCount);
    
    CGImageRef invertedImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* inverted = [UIImage imageWithCGImage:invertedImageRef];
    
    /// Cleanup
    CGImageRelease(invertedImageRef);
    free(dataAsFloat);
    CGContextRelease(bmContext);
    
    return inverted;
}

-(UIImage*)FKImageOpacity:(float)value
{
    /// Create an ARGB bitmap context
    const size_t width = (size_t)self.size.width;
    const size_t height = (size_t)self.size.height;
    CGContextRef bmContext = FKCreateARGBBitmapContext(width, height, width * kFKNumberOfComponentsPerARBGPixel, YES);
    if (!bmContext)
        return nil;
    
    /// Set the alpha value and draw the image in the bitmap context
    CGContextSetAlpha(bmContext, value);
    CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage);
    
    /// Create an image object from the context
    CGImageRef transparentImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* transparent = [UIImage imageWithCGImage:transparentImageRef];
    
    /// Cleanup
    CGImageRelease(transparentImageRef);
    CGContextRelease(bmContext);
    
    return transparent;
}

-(UIImage*)FKImageSepia
{
    if ([CIImage class])
    {
        /// The sepia output from Core Image is nicer than manual method and 1.6x faster than vDSP
        CIImage* ciImage = [[CIImage alloc] initWithCGImage:self.CGImage];
        CIImage* output = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputImageKey, ciImage, @"inputIntensity", [NSNumber numberWithFloat:1.0f], nil].outputImage;
        CGImageRef cgImage = [FKGetCIContext() createCGImage:output fromRect:[output extent]];
        UIImage* sepia = [UIImage imageWithCGImage:cgImage];
        CGImageRelease(cgImage);
        return sepia;
    }
    else
    {
        /* 1.6x faster than before */
        /// Create an ARGB bitmap context
        const size_t width = (size_t)self.size.width;
        const size_t height = (size_t)self.size.height;
        CGContextRef bmContext = FKCreateARGBBitmapContext(width, height, width * kFKNumberOfComponentsPerARBGPixel, FKImageHasAlpha(self.CGImage));
        if (!bmContext)
            return nil;
        
        /// Draw the image in the bitmap context
        CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage);
        
        /// Grab the image raw data
        UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
        if (!data)
        {
            CGContextRelease(bmContext);
            return nil;
        }
        
        const size_t pixelsCount = width * height;
        const size_t n = sizeof(float) * pixelsCount;
        float* reds = (float*)malloc(n);
        float* greens = (float*)malloc(n);
        float* blues = (float*)malloc(n);
        float* tmpRed = (float*)malloc(n);
        float* tmpGreen = (float*)malloc(n);
        float* tmpBlue = (float*)malloc(n);
        float* finalRed = (float*)malloc(n);
        float* finalGreen = (float*)malloc(n);
        float* finalBlue = (float*)malloc(n);
        float min = (float)kFKMinPixelComponentValue, max = (float)kFKMaxPixelComponentValue;
        
        /// Convert byte components to float
        vDSP_vfltu8(data + 1, 4, reds, 1, pixelsCount);
        vDSP_vfltu8(data + 2, 4, greens, 1, pixelsCount);
        vDSP_vfltu8(data + 3, 4, blues, 1, pixelsCount);
        
        /// Calculate red components
        vDSP_vsmul(reds, 1, &__sepiaFactorRedRed, tmpRed, 1, pixelsCount);
        vDSP_vsmul(greens, 1, &__sepiaFactorGreenRed, tmpGreen, 1, pixelsCount);
        vDSP_vsmul(blues, 1, &__sepiaFactorBlueRed, tmpBlue, 1, pixelsCount);
        vDSP_vadd(tmpRed, 1, tmpGreen, 1, finalRed, 1, pixelsCount);
        vDSP_vadd(finalRed, 1, tmpBlue, 1, finalRed, 1, pixelsCount);
        vDSP_vclip(finalRed, 1, &min, &max, finalRed, 1, pixelsCount);
        vDSP_vfixu8(finalRed, 1, data + 1, 4, pixelsCount);
        
        /// Calculate green components
        vDSP_vsmul(reds, 1, &__sepiaFactorRedGreen, tmpRed, 1, pixelsCount);
        vDSP_vsmul(greens, 1, &__sepiaFactorGreenGreen, tmpGreen, 1, pixelsCount);
        vDSP_vsmul(blues, 1, &__sepiaFactorBlueGreen, tmpBlue, 1, pixelsCount);
        vDSP_vadd(tmpRed, 1, tmpGreen, 1, finalGreen, 1, pixelsCount);
        vDSP_vadd(finalGreen, 1, tmpBlue, 1, finalGreen, 1, pixelsCount);
        vDSP_vclip(finalGreen, 1, &min, &max, finalGreen, 1, pixelsCount);
        vDSP_vfixu8(finalGreen, 1, data + 2, 4, pixelsCount);
        
        /// Calculate blue components
        vDSP_vsmul(reds, 1, &__sepiaFactorRedBlue, tmpRed, 1, pixelsCount);
        vDSP_vsmul(greens, 1, &__sepiaFactorGreenBlue, tmpGreen, 1, pixelsCount);
        vDSP_vsmul(blues, 1, &__sepiaFactorBlueBlue, tmpBlue, 1, pixelsCount);
        vDSP_vadd(tmpRed, 1, tmpGreen, 1, finalBlue, 1, pixelsCount);
        vDSP_vadd(finalBlue, 1, tmpBlue, 1, finalBlue, 1, pixelsCount);
        vDSP_vclip(finalBlue, 1, &min, &max, finalBlue, 1, pixelsCount);
        vDSP_vfixu8(finalBlue, 1, data + 3, 4, pixelsCount);
        
        /// Create an image object from the context
        CGImageRef sepiaImageRef = CGBitmapContextCreateImage(bmContext);
        UIImage* sepia = [UIImage imageWithCGImage:sepiaImageRef];
        
        /// Cleanup
        CGImageRelease(sepiaImageRef);
        free(reds), free(greens), free(blues), free(tmpRed), free(tmpGreen), free(tmpBlue), free(finalRed), free(finalGreen), free(finalBlue);
        CGContextRelease(bmContext);
        
        return sepia;
    }
}

-(UIImage*)FKImagesSarpenWithBias:(NSInteger)bias
{
    /// Create an ARGB bitmap context
    const size_t width = (size_t)self.size.width;
    const size_t height = (size_t)self.size.height;
    const size_t bytesPerRow = width * kFKNumberOfComponentsPerARBGPixel;
    CGContextRef bmContext = FKCreateARGBBitmapContext(width, height, bytesPerRow, FKImageHasAlpha(self.CGImage));
    if (!bmContext)
        return nil;
    
    /// Draw the image in the bitmap context
    CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage);
    
    /// Grab the image raw data
    UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
    if (!data)
    {
        CGContextRelease(bmContext);
        return nil;
    }
    
    const size_t n = sizeof(UInt8) * width * height * 4;
    void* outt = malloc(n);
    vImage_Buffer src = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {outt, height, width, bytesPerRow};
    vImageConvolveWithBias_ARGB8888(&src, &dest, NULL, 0, 0, __s_sharpen_kernel_3x3, 3, 3, 1/*divisor*/, (int32_t)bias, NULL, kvImageCopyInPlace);
    
    memcpy(data, outt, n);
    
    free(outt);
    
    CGImageRef sharpenedImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* sharpened = [UIImage imageWithCGImage:sharpenedImageRef];
    
    /// Cleanup
    CGImageRelease(sharpenedImageRef);
    CGContextRelease(bmContext);
    
    return sharpened;
}

-(UIImage*)FKImageUnsharpenWithBias:(NSInteger)bias
{
    /// Create an ARGB bitmap context
    const size_t width = (size_t)self.size.width;
    const size_t height = (size_t)self.size.height;
    const size_t bytesPerRow = width * kFKNumberOfComponentsPerARBGPixel;
    CGContextRef bmContext = FKCreateARGBBitmapContext(width, height, bytesPerRow, FKImageHasAlpha(self.CGImage));
    if (!bmContext) 
        return nil;
    
    /// Draw the image in the bitmap context
    CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage); 
    
    /// Grab the image raw data
    UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
    if (!data)
    {
        CGContextRelease(bmContext);
        return nil;
    }
    
    const size_t n = sizeof(UInt8) * width * height * 4;
    void* outt = malloc(n);
    vImage_Buffer src = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {outt, height, width, bytesPerRow};
    vImageConvolveWithBias_ARGB8888(&src, &dest, NULL, 0, 0, __s_unsharpen_kernel_3x3, 3, 3, 9/*divisor*/, (int32_t)bias, NULL, kvImageCopyInPlace);
    
    memcpy(data, outt, n);
    
    free(outt);
    
    CGImageRef unsharpenedImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* unsharpened = [UIImage imageWithCGImage:unsharpenedImageRef];
    
    /// Cleanup
    CGImageRelease(unsharpenedImageRef);
    CGContextRelease(bmContext);
    
    return unsharpened;
}

/****************** filter滤镜效果【End】 ******************/



/****************** mask遮罩效果【Begin】 ******************/

-(UIImage*)FKImageMaskWithImage:(UIImage*)maskImage
{
    /// Create a bitmap context with valid alpha
    const size_t originalWidth = (size_t)(self.size.width * self.scale);
    const size_t originalHeight = (size_t)(self.size.height * self.scale);
    CGContextRef bmContext = FKCreateARGBBitmapContext(originalWidth, originalHeight, 0, YES);
    if (!bmContext)
        return nil;
    
    /// Image quality
    CGContextSetShouldAntialias(bmContext, true);
    CGContextSetAllowsAntialiasing(bmContext, true);
    CGContextSetInterpolationQuality(bmContext, kCGInterpolationHigh);
    
    /// Image mask
    CGImageRef cgMaskImage = maskImage.CGImage;
    CGImageRef mask = CGImageMaskCreate((size_t)maskImage.size.width, (size_t)maskImage.size.height, CGImageGetBitsPerComponent(cgMaskImage), CGImageGetBitsPerPixel(cgMaskImage), CGImageGetBytesPerRow(cgMaskImage), CGImageGetDataProvider(cgMaskImage), NULL, false);
    
    /// Draw the original image in the bitmap context
    const CGRect r = (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = originalWidth, .size.height = originalHeight};
    CGContextClipToMask(bmContext, r, cgMaskImage);
    CGContextDrawImage(bmContext, r, self.CGImage);
    
    /// Get the CGImage object
    CGImageRef imageRefWithAlpha = CGBitmapContextCreateImage(bmContext);
    /// Apply the mask
    CGImageRef maskedImageRef = CGImageCreateWithMask(imageRefWithAlpha, mask);
    
    UIImage* result = [UIImage imageWithCGImage:maskedImageRef scale:self.scale orientation:self.imageOrientation];
    
    /// Cleanup
    CGImageRelease(maskedImageRef);
    CGImageRelease(imageRefWithAlpha);
    CGContextRelease(bmContext);
    CGImageRelease(mask);
    
    return result;
}

/****************** mask遮罩效果【End】 ******************/



/****************** Reflection光照效果【Begin】 ******************/

-(UIImage*)reflectedImageWithHeight:(NSUInteger)height fromAlpha:(float)fromAlpha toAlpha:(float)toAlpha
{
    if (!height)
        return nil;
    
    // create a bitmap graphics context the size of the image
    UIGraphicsBeginImageContextWithOptions((CGSize){.width = self.size.width, .height = height}, NO, 0.0f);
    CGContextRef mainViewContentContext = UIGraphicsGetCurrentContext();
    
    // create a 2 bit CGImage containing a gradient that will be used for masking the
    // main view content to create the 'fade' of the reflection. The CGImageCreateWithMask
    // function will stretch the bitmap image as required, so we can create a 1 pixel wide gradient
    CGImageRef gradientMaskImage = FKCreateGradientImage(1, height, fromAlpha, toAlpha);
    
    // create an image by masking the bitmap of the mainView content with the gradient view
    // then release the  pre-masked content bitmap and the gradient bitmap
    CGContextClipToMask(mainViewContentContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = self.size.width, .size.height = height}, gradientMaskImage);
    CGImageRelease(gradientMaskImage);
    
    // draw the image into the bitmap context
    CGContextDrawImage(mainViewContentContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size = self.size}, self.CGImage);
    
    // convert the finished reflection image to a UIImage
    UIImage* theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
}

/****************** Reflection光照效果【End】 ******************/



/****************** Resizing图片调整:裁剪、缩放【Begin】 ******************/

-(UIImage*)FKImageCroppedToSize:(CGSize)newSize usingMode:(FKCroppedMode)croppedMode
{
    const CGSize size = self.size;
    CGFloat x, y;
    switch (croppedMode)
    {
        case FKCroppedModeTopLeft:
            x = y = 0.0f;
            break;
        case FKCroppedModeTopCenter:
            x = (size.width - newSize.width) * 0.5f;
            y = 0.0f;
            break;
        case FKCroppedModeTopRight:
            x = size.width - newSize.width;
            y = 0.0f;
            break;
        case FKCroppedModeBottomLeft:
            x = 0.0f;
            y = size.height - newSize.height;
            break;
        case FKCroppedModeBottomCenter:
            x = (size.width - newSize.width) * 0.5f;
            y = size.height - newSize.height;
            break;
        case FKCroppedModeBottomRight:
            x = size.width - newSize.width;
            y = size.height - newSize.height;
            break;
        case FKCroppedModeLeftCenter:
            x = 0.0f;
            y = (size.height - newSize.height) * 0.5f;
            break;
        case FKCroppedModeRightCenter:
            x = size.width - newSize.width;
            y = (size.height - newSize.height) * 0.5f;
            break;
        case FKCroppedModeCenter:
            x = (size.width - newSize.width) * 0.5f;
            y = (size.height - newSize.height) * 0.5f;
            break;
        default: // Default to top left
            x = y = 0.0f;
            break;
    }
    
    if (self.imageOrientation == UIImageOrientationLeft || self.imageOrientation == UIImageOrientationLeftMirrored || self.imageOrientation == UIImageOrientationRight || self.imageOrientation == UIImageOrientationRightMirrored)
    {
        CGFloat temp = x;
        x = y;
        y = temp;
        
        temp = newSize.width;
        newSize.width = newSize.height;
        newSize.height = temp;
    }
    
    CGRect cropRect = CGRectMake(x * self.scale, y * self.scale, newSize.width * self.scale, newSize.height * self.scale);
    
    /// Create the cropped image【创建裁剪后的图片】
    CGImageRef croppedImageRef = CGImageCreateWithImageInRect(self.CGImage, cropRect);
    UIImage* cropped = [UIImage imageWithCGImage:croppedImageRef scale:self.scale orientation:self.imageOrientation];
    
    /// Cleanup【释放内存】
    CGImageRelease(croppedImageRef);
    
    return cropped;
}

/* Convenience method to crop the image from the top left corner */
-(UIImage*)FKImageTopLeftCroppedToSize:(CGSize)newSize
{
    return [self FKImageCroppedToSize:newSize usingMode:FKCroppedModeTopLeft];
}

-(UIImage*)FKImageScaleByFactor:(float)scaleFactor
{
    CGSize scaledSize = CGSizeMake(self.size.width * scaleFactor, self.size.height * scaleFactor);
    return [self FKImageScaleToFillSize:scaledSize];
}

-(UIImage*)FKImageScaleToSize:(CGSize)newSize usingMode:(FKResizeMode)resizeMode
{
    switch (resizeMode)
    {
        case FKResizeModeAspectFit:
            return [self FKImageScaleToFitSize:newSize];
        case FKResizeModeAspectFill:
            return [self FKImageScaleToCoverSize:newSize];
        default:
            return [self FKImageScaleToFillSize:newSize];
    }
}

/* Convenience method to scale the image using the FKResizeModeScaleToFill mode */
-(UIImage*)FKImageScaleToSize:(CGSize)newSize
{
    return [self FKImageScaleToFillSize:newSize];
}

-(UIImage*)FKImageScaleToFillSize:(CGSize)newSize
{
    size_t destWidth = (size_t)(newSize.width * self.scale);
    size_t destHeight = (size_t)(newSize.height * self.scale);
    if (self.imageOrientation == UIImageOrientationLeft
        || self.imageOrientation == UIImageOrientationLeftMirrored
        || self.imageOrientation == UIImageOrientationRight
        || self.imageOrientation == UIImageOrientationRightMirrored)
    {
        size_t temp = destWidth;
        destWidth = destHeight;
        destHeight = temp;
    }
    
    /// Create an ARGB bitmap context
    CGContextRef bmContext = FKCreateARGBBitmapContext(destWidth, destHeight, destWidth * kFKNumberOfComponentsPerARBGPixel, FKImageHasAlpha(self.CGImage));
    if (!bmContext)
        return nil;
    
    /// Image quality
    CGContextSetShouldAntialias(bmContext, true);
    CGContextSetAllowsAntialiasing(bmContext, true);
    CGContextSetInterpolationQuality(bmContext, kCGInterpolationHigh);
    
    /// Draw the image in the bitmap context
    
    UIGraphicsPushContext(bmContext);
    CGContextDrawImage(bmContext, CGRectMake(0.0f, 0.0f, destWidth, destHeight), self.CGImage);
    UIGraphicsPopContext();
    
    /// Create an image object from the context
    CGImageRef scaledImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* scaled = [UIImage imageWithCGImage:scaledImageRef scale:self.scale orientation:self.imageOrientation];
    
    /// Cleanup
    CGImageRelease(scaledImageRef);
    CGContextRelease(bmContext);
    
    return scaled;
}

-(UIImage*)FKImageScaleToFitSize:(CGSize)newSize
{
    /// Keep aspect ratio
    size_t destWidth, destHeight;
    if (self.size.width > self.size.height)
    {
        destWidth = (size_t)newSize.width;
        destHeight = (size_t)(self.size.height * newSize.width / self.size.width);
    }
    else
    {
        destHeight = (size_t)newSize.height;
        destWidth = (size_t)(self.size.width * newSize.height / self.size.height);
    }
    if (destWidth > newSize.width)
    {
        destWidth = (size_t)newSize.width;
        destHeight = (size_t)(self.size.height * newSize.width / self.size.width);
    }
    if (destHeight > newSize.height)
    {
        destHeight = (size_t)newSize.height;
        destWidth = (size_t)(self.size.width * newSize.height / self.size.height);
    }
    return [self FKImageScaleToFillSize:CGSizeMake(destWidth, destHeight)];
}

-(UIImage*)FKImageScaleToCoverSize:(CGSize)newSize
{
    size_t destWidth, destHeight;
    CGFloat widthRatio = newSize.width / self.size.width;
    CGFloat heightRatio = newSize.height / self.size.height;
    /// Keep aspect ratio
    if (heightRatio > widthRatio)
    {
        destHeight = (size_t)newSize.height;
        destWidth = (size_t)(self.size.width * newSize.height / self.size.height);
    }
    else
    {
        destWidth = (size_t)newSize.width;
        destHeight = (size_t)(self.size.height * newSize.width / self.size.width);
    }
    return [self FKImageScaleToFillSize:CGSizeMake(destWidth, destHeight)];
}

/****************** Resizing图片调整:裁剪、缩放【End】 ******************/




/****************** Rotate旋转效果【Begin】 ******************/

-(UIImage*)FKImageRotateInRadians:(CGFloat)radians flipOverHorizontalAxis:(BOOL)doHorizontalFlip verticalAxis:(BOOL)doVerticalFlip
{
    /// Create an ARGB bitmap context
    const size_t width = (size_t)CGImageGetWidth(self.CGImage);
    const size_t height = (size_t)CGImageGetHeight(self.CGImage);
    
    CGRect rotatedRect = CGRectApplyAffineTransform(CGRectMake(0., 0., width, height), CGAffineTransformMakeRotation(radians));
    
    CGContextRef bmContext = FKCreateARGBBitmapContext((size_t)rotatedRect.size.width, (size_t)rotatedRect.size.height, (size_t)rotatedRect.size.width * kFKNumberOfComponentsPerARBGPixel, YES);
    if (!bmContext)
        return nil;
    
    /// Image quality
    CGContextSetShouldAntialias(bmContext, true);
    CGContextSetAllowsAntialiasing(bmContext, true);
    CGContextSetInterpolationQuality(bmContext, kCGInterpolationHigh);
    
    /// Rotation happen here (around the center)
    CGContextTranslateCTM(bmContext, +(rotatedRect.size.width / 2.0f), +(rotatedRect.size.height / 2.0f));
    CGContextRotateCTM(bmContext, radians);
    
    // Do flips
    CGContextScaleCTM(bmContext, (doHorizontalFlip ? -1.0f : 1.0f), (doVerticalFlip ? -1.0f : 1.0f));
    
    /// Draw the image in the bitmap context
    CGContextDrawImage(bmContext, CGRectMake(-(width / 2.0f), -(height / 2.0f), width, height), self.CGImage);
    
    /// Create an image object from the context
    CGImageRef resultImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* resultImage = [UIImage imageWithCGImage:resultImageRef scale:self.scale orientation:self.imageOrientation];
    
    /// Cleanup
    CGImageRelease(resultImageRef);
    CGContextRelease(bmContext);
    
    return resultImage;
}

-(UIImage*)FKImageRotateInRadians:(float)radians
{
    return [self FKImageRotateInRadians:radians flipOverHorizontalAxis:NO verticalAxis:NO];
}

-(UIImage*)FKImageRotateInAngle:(float)angle
{
    return [self FKImageRotateInRadians:(float)FK_DEGREES_TO_RADIANS(angle)];
}

-(UIImage*)FKImageVerticalFlip
{
    return [self FKImageRotateInRadians:0. flipOverHorizontalAxis:NO verticalAxis:YES];
}

-(UIImage*)FKImageHorizontalFlip
{
    return [self FKImageRotateInRadians:0. flipOverHorizontalAxis:YES verticalAxis:NO];
}

-(UIImage*)FKImageRotateImagePixelsInRadians:(float)radians
{
    /// Create an ARGB bitmap context
    const size_t width = (size_t)(self.size.width * self.scale);
    const size_t height = (size_t)(self.size.height * self.scale);
    const size_t bytesPerRow = width * kFKNumberOfComponentsPerARBGPixel;
    CGContextRef bmContext = FKCreateARGBBitmapContext(width, height, bytesPerRow, YES);
    if (!bmContext)
        return nil;
    
    /// Draw the image in the bitmap context
    CGContextDrawImage(bmContext, CGRectMake(0.0f, 0.0f, width, height), self.CGImage);
    
    /// Grab the image raw data
    UInt8* data = (UInt8*)CGBitmapContextGetData(bmContext);
    if (!data)
    {
        CGContextRelease(bmContext);
        return nil;
    }
    
    vImage_Buffer src = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {data, height, width, bytesPerRow};
    Pixel_8888 bgColor = {0, 0, 0, 0};
    vImageRotate_ARGB8888(&src, &dest, NULL, radians, bgColor, kvImageBackgroundColorFill);
    
    CGImageRef rotatedImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* rotated = [UIImage imageWithCGImage:rotatedImageRef scale:self.scale orientation:self.imageOrientation];
    
    /// Cleanup
    CGImageRelease(rotatedImageRef);
    CGContextRelease(bmContext);
    
    return rotated;
}

-(UIImage*)FKImageRotateImagePixelsInAngle:(float)angle
{
    return [self FKImageRotateImagePixelsInRadians:(float)FK_DEGREES_TO_RADIANS(angle)];
}

/****************** Rotate旋转效果【End】 ******************/



/****************** saveing保存【Begin 这个好像没有什么卵用】 ******************/

-(BOOL)FKImageSaveToURL:(NSURL*)url uti:(CFStringRef)uti backgroundFillColor:(UIColor*)fillColor
{
    if (!url) return NO;
    
    if (!uti) uti = kUTTypePNG;
    
    CGImageDestinationRef dest = CGImageDestinationCreateWithURL((__bridge CFURLRef)url, uti, 1, NULL);
    if (!dest) return NO;
    
    /// Set the options, 1 -> lossless
    CFMutableDictionaryRef options = CFDictionaryCreateMutable(kCFAllocatorDefault, 2, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    if (!options)
    {
        CFRelease(dest);
        return NO;
    }
    CFDictionaryAddValue(options, kCGImageDestinationLossyCompressionQuality, (__bridge CFNumberRef)[NSNumber numberWithFloat:1.0f]); // No compression
    if (fillColor)
        CFDictionaryAddValue(options, kCGImageDestinationBackgroundColor, fillColor.CGColor);
    
    /// Add the image【添加图片】
    CGImageDestinationAddImage(dest, self.CGImage, (CFDictionaryRef)options);
    
    /// Write it to the destination【写入目的地】
    const bool success = CGImageDestinationFinalize(dest);
    
    /// Cleanup
    CFRelease(options);
    CFRelease(dest);
    
    return success;
}

-(BOOL)FKImageSaveToURL:(NSURL*)url type:(FKImageType)type backgroundFillColor:(UIColor*)fillColor
{
    return [self FKImageSaveToURL:url uti:[self FKImageUtiForType:type] backgroundFillColor:fillColor];
}

-(BOOL)FKImageSaveToURL:(NSURL*)url
{
    return [self FKImageSaveToURL:url uti:kUTTypePNG backgroundFillColor:nil];
}

-(BOOL)FKImageSaveToPath:(NSString*)path uti:(CFStringRef)uti backgroundFillColor:(UIColor*)fillColor
{
    if (!path) return NO;
    
    NSURL* url = [[NSURL alloc] initFileURLWithPath:path];
    const BOOL ret = [self FKImageSaveToURL:url uti:uti backgroundFillColor:fillColor];
    return ret;
}

-(BOOL)FKImageSaveToPath:(NSString*)path type:(FKImageType)type backgroundFillColor:(UIColor*)fillColor
{
    if (!path) return NO;
    
    NSURL* url = [[NSURL alloc] initFileURLWithPath:path];
    const BOOL ret = [self FKImageSaveToURL:url uti:[self utiForType:type] backgroundFillColor:fillColor];
    return ret;
}

-(BOOL)FKImageSaveToPath:(NSString*)path
{
    if (!path) return NO;
    
    NSURL* url = [[NSURL alloc] initFileURLWithPath:path];
    const BOOL ret = [self FKImageSaveToURL:url type:FKImageTypePNG backgroundFillColor:nil];
    return ret;
}

-(BOOL)FKImageSaveToPhotosAlbum
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    __block BOOL ret = YES;
    [library writeImageToSavedPhotosAlbum:self.CGImage orientation:(ALAssetOrientation)self.imageOrientation completionBlock:^(NSURL* assetURL, NSError* error) {
        if (!assetURL)
        {
            NSLog(@"%@", error);
            ret = NO;
        }
    }];
    return ret;
}

+(NSString*)FKImageExtensionForUTI:(CFStringRef)uti
{
    if (!uti) return nil;
    
    NSDictionary* declarations = (__bridge_transfer NSDictionary*)UTTypeCopyDeclaration(uti);
    if (!declarations) return nil;
    
    id extensions = [(NSDictionary*)[declarations objectForKey:(__bridge NSString*)kUTTypeTagSpecificationKey] objectForKey:(__bridge NSString*)kUTTagClassFilenameExtension];
    NSString* extension = ([extensions isKindOfClass:[NSArray class]]) ? [extensions objectAtIndex:0] : extensions;
    
    return extension;
}

#pragma mark - Private
-(CFStringRef)FKImageUtiForType:(FKImageType)type
{
    CFStringRef uti = NULL;
    switch (type)
    {
        case FKImageTypeBMP:
            uti = kUTTypeBMP;
            break;
        case FKImageTypeJPEG:
            uti = kUTTypeJPEG;
            break;
        case FKImageTypePNG:
            uti = kUTTypePNG;
            break;
        case FKImageTypeTIFF:
            uti = kUTTypeTIFF;
            break;
        case FKImageTypeGIF:
            uti = kUTTypeGIF;
            break;
        default:
            uti = kUTTypePNG;
            break;
    }
    return uti;
}

/****************** saveing保存【End】 ******************/


@end
