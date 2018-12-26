//
//  UIButton+FK.h
//  HHShopping
//
//  Created by frank on 2018/8/15.
//  Copyright © 2018年 嘉瑞科技有限公司 - 凯叔叔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (FK)

+ (instancetype)fk_btnWithFont:(UIFont *)font;
+ (instancetype)fk_btnWithFont:(UIFont *)font title:(NSString *)title;
+ (instancetype)fk_btnWithFont:(UIFont *)font titleColor:(UIColor *)titleColor title:(NSString *)title;
+ (instancetype)fk_btnWithFont:(UIFont *)font titleColor:(UIColor *)titleColor normalBg:(NSString *)normalBg title:(NSString *)title;
+ (instancetype)fk_btnWithFont:(UIFont *)font titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedTitleColor;
+ (instancetype)fk_btnWithFont:(UIFont *)font titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedTitleColor normalBg:(NSString *)normalBg;
+ (instancetype)fk_btnWithFont:(UIFont *)font titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedTitleColor normalBg:(NSString *)normalBg selectedBg:(NSString *)selectedBg;
+ (instancetype)fk_btnWithFont:(UIFont *)font titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedTitleColor title:(NSString *)title;
+ (instancetype)fk_btnWithFont:(UIFont *)font titleColor:(UIColor *)titleColor title:(NSString *)title selectedTitle:(NSString *)selectedTitle;
+ (instancetype)fk_btnWithFont:(UIFont *)font titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedTitleColor title:(NSString *)title selectedTitle:(NSString *)selectedTitle;

+ (instancetype)fk_btnWithFrame:(CGRect)frame font:(UIFont *)font;

+ (instancetype)fk_btnWithFrame:(CGRect)frame font:(UIFont *)font normalTitleColor:(UIColor *)normalTitleColor normalTitle:(NSString *)normalTitle;



+ (instancetype)fk_btnWithTarget:(id)target action:(SEL)action img:(UIImage *)img;
+ (instancetype)fk_btnWithTarget:(id)target action:(SEL)action img:(UIImage *)img selectedImg:(UIImage *)selectedImg;
+ (instancetype)fk_btnWithTarget:(id)target action:(SEL)action font:(UIFont *)font normalTitle:(NSString *)normalTitle normalTitleColor:(UIColor *)normalTitleColor;
+ (instancetype)fk_btnWithTarget:(id)target action:(SEL)action font:(UIFont *)font normalTitle:(NSString *)normalTitle normalTitleColor:(UIColor *)normalTitleColor bgImg:(UIImage *)bgImg;


/** 参数最多的一个 */
+ (instancetype)fk_btnWithTarget:(id)target action:(SEL)action font:(UIFont *)font normalTitle:(NSString *)normalTitle normalTitleColor:(UIColor *)normalTitleColor selectedTitle:(NSString *)selectedTitle selectedTitleColor:(UIColor *)selectedTitleColor normalImg:(UIImage *)normalImg selectedImg:(UIImage *)selectedImg bgImg:(UIImage *)bgImg selectedBgImg:(UIImage *)selectedBgImg;


@end
