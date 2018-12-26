//
//  UILabel+FK.m
//  HHShopping
//
//  Created by frank on 2018/8/15.
//  Copyright © 2018年 嘉瑞科技有限公司 - 凯叔叔. All rights reserved.
//

#import "UILabel+FK.h"

@implementation UILabel (FK)

+ (UILabel *)fk_labelWithFont:(UIFont *)font textColor:(UIColor *)textColor
{
    UILabel *label = [[self alloc] init];
    label.font = font;
    label.textColor = textColor;
    return label;
}

+ (UILabel *)fk_labelWithFont:(UIFont *)font text:(NSString *)text
{
    UILabel *label = [[self alloc] init];
    label.font = font;
    label.text = text;
    return label;
}

+ (UILabel *)fk_labelWithFont:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text
{
    UILabel *label = [self fk_labelWithFont:font text:text];
    label.textAlignment = textAlignment;
    return label;
}

+ (UILabel *)fk_labelWithFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [self fk_labelWithFont:font textColor:textColor];
    label.textAlignment = textAlignment;
    return label;
}

+ (UILabel *)fk_labelWithFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text
{
    UILabel *label = [self fk_labelWithFont:font textColor:textColor textAlignment:textAlignment];
    label.text = text;
    return label;
}

#pragma mark - 必填frame
+ (UILabel *)fk_labelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor
{
    UILabel *label = [self fk_labelWithFont:font textColor:textColor];
    label.frame = frame;
    return label;
}

+ (instancetype)fk_labelWithFont:(UIFont *)font textColor:(UIColor *)textColor text:(NSString *)text
{
    UILabel *label = [self fk_labelWithFrame:CGRectZero font:font textColor:textColor];
    label.text = text;
    return label;
}

+ (instancetype)fk_labelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [self fk_labelWithFrame:frame font:font textColor:textColor];
    label.textAlignment = textAlignment;
    return label;
}

+ (instancetype)fk_labelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor text:(NSString *)text
{
    UILabel *label = [self fk_labelWithFrame:frame font:font textColor:textColor];
    label.text = text;
    return label;
}

+ (instancetype)fk_labelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text
{
    UILabel *label = [self fk_labelWithFrame:frame font:font textColor:textColor text:text];
    label.textAlignment = textAlignment;
    return label;
}



@end
