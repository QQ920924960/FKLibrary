//
//  CALayer+FK.m
//  FKLibraryExample
//
//  Created by frank on 15/11/7.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "CALayer+FK.h"
#import <UIKit/UIKit.h>

@implementation CALayer (FK)

- (void)fk_layerSetCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)brderColor
{
    [self setCornerRadius:cornerRadius];
    [self setBorderWidth:borderWidth];
    [self setMasksToBounds:YES];
    [self setBorderColor:brderColor.CGColor];
}

- (void)fk_layerSetCornerRadius:(CGFloat)cornerRadius
{
    self.cornerRadius = cornerRadius;
    self.masksToBounds = YES;
}

- (void)fk_layerSetBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    self.borderWidth = borderWidth;
    self.borderColor = borderColor.CGColor;
}

- (void)fk_layerSetShadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)offset
{
    self.shadowColor = shadowColor.CGColor;
    self.shadowOffset = offset;
    self.shadowOpacity = YES;
}

@end
