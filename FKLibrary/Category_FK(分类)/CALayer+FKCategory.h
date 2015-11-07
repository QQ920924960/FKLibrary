//
//  CALayer+FKCategory.h
//  FKLibraryExample
//
//  Created by frank on 15/11/7.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
@class UIColor;

@interface CALayer (FKCategory)

/**
 *  设置圆角半径和边框
 *
 *  @param cornerRadius 半径
 *  @param borderWidth  边框宽度
 *  @param brderColor   边框颜色
 */
- (void)FKLayerSetCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)brderColor;

/**
 *  绘制圆角
 *
 *  @param cornerRadius 圆角弧度值
 */
- (void)FKLayerSetCornerRadius:(CGFloat)cornerRadius;

/**
 *  绘制边框
 *
 *  @param borderWidth 边框厚度
 *  @param brderColor  边框颜色
 */
- (void)FKLayerSetBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  绘制阴影
 *
 *  @param shadowColor 阴影颜色
 *  @param offset      阴影宽高
 *
 *  CGSizeMake(offset, offset)
 */
- (void)FKLayerSetShadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)offset;

@end
