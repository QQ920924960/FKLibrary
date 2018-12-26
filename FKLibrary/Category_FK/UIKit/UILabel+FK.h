//
//  UILabel+FK.h
//  HHShopping
//
//  Created by frank on 2018/8/15.
//  Copyright © 2018年 嘉瑞科技有限公司 - 凯叔叔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (FK)

+ (UILabel *)fk_labelWithFont:(UIFont *)font textColor:(UIColor *)textColor;

+ (UILabel *)fk_labelWithFont:(UIFont *)font text:(NSString *)text;

+ (UILabel *)fk_labelWithFont:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text;

+ (UILabel *)fk_labelWithFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;

+ (UILabel *)fk_labelWithFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text;

+ (UILabel *)fk_labelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor;

+ (instancetype)fk_labelWithFont:(UIFont *)font textColor:(UIColor *)textColor text:(NSString *)text;

+ (instancetype)fk_labelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;

+ (instancetype)fk_labelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor text:(NSString *)text;

+ (instancetype)fk_labelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text;


@end
