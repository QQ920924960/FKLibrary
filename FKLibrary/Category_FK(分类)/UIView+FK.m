//
//  UIView+FK.m
//  FKLibraryExample
//
//  Created by frank on 15/11/2.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "UIView+FK.h"

@implementation UIView (FK)

- (void)setFk_x:(CGFloat)fk_x
{
    CGRect frame = self.frame;
    frame.origin.x = fk_x;
    self.frame = frame;
}

- (CGFloat)fk_x
{
    return self.frame.origin.x;
}

- (void)setFk_y:(CGFloat)fk_y
{
    CGRect frame = self.frame;
    frame.origin.y = fk_y;
    self.frame = frame;
}

- (CGFloat)fk_y
{
    return self.frame.origin.y;
}

- (void)setFk_centerX:(CGFloat)fk_centerX
{
    CGPoint center = self.center;
    center.x = fk_centerX;
    self.center = center;
}

- (CGFloat)fk_centerX
{
    return self.center.x;
}

- (void)setFk_centerY:(CGFloat)fk_centerY
{
    CGPoint center = self.center;
    center.y = fk_centerY;
    self.center = center;
}

- (CGFloat)fk_centerY
{
    return self.center.y;
}

- (void)setFk_width:(CGFloat)fk_width
{
    CGRect frame = self.frame;
    frame.size.width = fk_width;
    self.frame = frame;
}

- (CGFloat)fk_width
{
    return self.frame.size.width;
}

- (void)setFk_height:(CGFloat)fk_height
{
    CGRect frame = self.frame;
    frame.size.height = fk_height;
    self.frame = frame;
}

- (CGFloat)fk_height
{
    return self.frame.size.height;
}

- (void)setFk_size:(CGSize)fk_size
{
    CGRect frame = self.frame;
    frame.size = fk_size;
    self.frame = frame;
}

- (CGSize)fk_size
{
    return self.frame.size;
}

- (void)fk_viewCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
    // 图层栅格化的范围
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    // 是否应该栅格化
    self.layer.shouldRasterize = YES;
    self.clipsToBounds = YES;
}

@end
