//
//  CALayer+FKCategory.m
//  FKLibraryExample
//
//  Created by frank on 15/11/7.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "CALayer+FKCategory.h"
#import <UIKit/UIKit.h>

@implementation CALayer (FKCategory)

- (void)FKLayerSetCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)brderColor
{
    [self setCornerRadius:cornerRadius];
    [self setBorderWidth:borderWidth];
    [self setMasksToBounds:YES];
    [self setBorderColor:brderColor.CGColor];
}

- (void)FKLayerSetCornerRadius:(CGFloat)cornerRadius
{
    self.cornerRadius = cornerRadius;
    self.masksToBounds = YES;
}

- (void)FKLayerSetBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    self.borderWidth = borderWidth;
    self.borderColor = borderColor.CGColor;
}

- (void)FKLayerSetShadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)offset
{
    self.shadowColor = shadowColor.CGColor;
    self.shadowOffset = offset;
    self.shadowOpacity = YES;
}

@end
