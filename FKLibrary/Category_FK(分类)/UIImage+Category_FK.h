//
//  UIImage+Category_FK.h
//  FKLibraryExample
//
//  Created by frank on 15-11-1.
//  Copyright © 2015年 zmosa. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIImage (Category_FK)

/**
 *  屏幕截图
 *
 *  @param view 需要截图的view
 *
 *  @return 返回的图片
 */
+ (instancetype)captureWithView:(UIView *)view;

/**
 *  打水印
 *
 *  @param bg   背景图片
 *  @param logo 右下角的水印图片
 *
 *  @return 打好水印后的图片
 */
+ (instancetype)waterImageWithBg:(NSString *)bg logo:(NSString *)logo;

/**
 *  图片裁剪
 *
 *  @param name        传入的图片名
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *
 *  @return 裁剪后的新图片
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  根据图片名返回一张能够自由拉伸的图片
 */
+ (UIImage *)resizedImage:(NSString *)name;

@end
