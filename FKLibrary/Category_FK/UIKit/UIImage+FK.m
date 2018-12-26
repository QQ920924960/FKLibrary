//
//  UIImage+FK.m
//  FKLibraryExample
//
//  Created by frank on 15-11-1.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "UIImage+FK.h"
#import <Accelerate/Accelerate.h>
#import <ImageIO/ImageIO.h> // For CGImageDestination
#import <MobileCoreServices/MobileCoreServices.h> // For the UTI types constants
#import <AssetsLibrary/AssetsLibrary.h> // For photos album saving

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



@implementation UIImage (FK)

+ (UIImage *)fk_imageWithColor:(UIColor *)color
{
    return [self fk_imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (instancetype)fk_imageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *pureColorImage = (UIImage *)UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pureColorImage;
}

+ (instancetype)fk_imageWithColor:(UIColor *)color view:(UIView *)view
{
    CGSize size = CGSizeMake(view.bounds.size.width, view.bounds.size.height);
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *pureColorImage = (UIImage *)UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pureColorImage;
}

+ (instancetype)fk_imageCaptureWithView:(UIView *)view
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

+ (instancetype)fk_imageWatermarkWithBg:(NSString *)bg watermark:(NSString *)watermark
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

+ (instancetype)fk_imageClipToCircle:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
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

+ (instancetype)fk_imageClipToCircle:(UIImage*)image inset:(CGFloat)inset {
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

+ (UIImage *)fk_imageResized:(NSString *)name horizontal:(CGFloat)horizontal vertical:(CGFloat)vertical
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * vertical topCapHeight:image.size.height * vertical];
}

-(UIImage *)fk_imageInRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage* subImage = [UIImage imageWithCGImage: imageRef];
    CGImageRelease(imageRef);
    return subImage;
}

- (UIImage *)fk_imageByScaleProportionallyMinSize:(CGSize)minSize {
    
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


- (UIImage *)fk_imageByScalingProportionallyToSize:(CGSize)targetSize {
    
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


- (UIImage *)fk_imageByScaleToSize:(CGSize)size {
    
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


- (UIImage *)fk_imageRotateByRadian:(CGFloat)radian
{
    return [self fk_imageRotateByAngle:RadianToAngle(radian)];
}

- (UIImage *)fk_imageRotateByAngle:(CGFloat)angle
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

+ (UIImage *)fk_imageGenerateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height{
    
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




/****************** saveing保存【Begin 这个好像没有什么卵用】 ******************/

-(BOOL)fk_imageSaveToURL:(NSURL*)url uti:(CFStringRef)uti backgroundFillColor:(UIColor*)fillColor
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

-(BOOL)fk_imageSaveToURL:(NSURL*)url type:(FKImageType)type backgroundFillColor:(UIColor*)fillColor
{
    return [self fk_imageSaveToURL:url uti:[self fk_imageUtiForType:type] backgroundFillColor:fillColor];
}

-(BOOL)fk_imageSaveToURL:(NSURL*)url
{
    return [self fk_imageSaveToURL:url uti:kUTTypePNG backgroundFillColor:nil];
}

-(BOOL)fk_imageSaveToPath:(NSString*)path uti:(CFStringRef)uti backgroundFillColor:(UIColor*)fillColor
{
    if (!path) return NO;
    
    NSURL* url = [[NSURL alloc] initFileURLWithPath:path];
    const BOOL ret = [self fk_imageSaveToURL:url uti:uti backgroundFillColor:fillColor];
    return ret;
}


-(BOOL)fk_imageSaveToPath:(NSString*)path
{
    if (!path) return NO;
    
    NSURL* url = [[NSURL alloc] initFileURLWithPath:path];
    const BOOL ret = [self fk_imageSaveToURL:url type:FKImageTypePNG backgroundFillColor:nil];
    return ret;
}

-(BOOL)fk_imageSaveToPhotosAlbum
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

+(NSString*)fk_imageExtensionForUTI:(CFStringRef)uti
{
    if (!uti) return nil;
    
    NSDictionary* declarations = (__bridge_transfer NSDictionary*)UTTypeCopyDeclaration(uti);
    if (!declarations) return nil;
    
    id extensions = [(NSDictionary*)[declarations objectForKey:(__bridge NSString*)kUTTypeTagSpecificationKey] objectForKey:(__bridge NSString*)kUTTagClassFilenameExtension];
    NSString* extension = ([extensions isKindOfClass:[NSArray class]]) ? [extensions objectAtIndex:0] : extensions;
    
    return extension;
}

#pragma mark - Private
-(CFStringRef)fk_imageUtiForType:(FKImageType)type
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
