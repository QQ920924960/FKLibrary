//
//  UIButton+FK.m
//  FKLibraryExample
//
//  Created by frank on 2018/8/15.
//  Copyright © 2018年 zmosa - frank. All rights reserved.
//

#import "UIButton+FK.h"

@implementation UIButton (FK)

+ (instancetype)fk_btnWithFont:(UIFont *)font
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = font;
    return btn;
}

+ (instancetype)fk_btnWithFont:(UIFont *)font title:(NSString *)title
{
    UIButton *btn = [self fk_btnWithFont:font];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}

+ (instancetype)fk_btnWithFont:(UIFont *)font titleColor:(UIColor *)titleColor title:(NSString *)title
{
    UIButton *btn = [self fk_btnWithFont:font title:title];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    return btn;
}

+ (instancetype)fk_btnWithFont:(UIFont *)font titleColor:(UIColor *)titleColor normalBg:(NSString *)normalBg title:(NSString *)title
{
    UIButton *btn = [self fk_btnWithFont:font titleColor:titleColor title:title];
    [btn setBackgroundImage:[UIImage imageNamed:normalBg] forState:UIControlStateNormal];
    return btn;
}

+ (instancetype)fk_btnWithFont:(UIFont *)font titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedTitleColor
{
    UIButton *btn = [self fk_btnWithFont:font];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    return btn;
}

+ (instancetype)fk_btnWithFont:(UIFont *)font titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedTitleColor normalBg:(NSString *)normalBg
{
    UIButton *btn = [self fk_btnWithFont:font titleColor:titleColor selectedTitleColor:selectedTitleColor];
    [btn setBackgroundImage:[UIImage imageNamed:normalBg] forState:UIControlStateNormal];
    return btn;
}

+ (instancetype)fk_btnWithFont:(UIFont *)font titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedTitleColor normalBg:(NSString *)normalBg selectedBg:(NSString *)selectedBg
{
    UIButton *btn = [self fk_btnWithFont:font titleColor:titleColor selectedTitleColor:selectedTitleColor normalBg:normalBg];
    [btn setBackgroundImage:[UIImage imageNamed:selectedBg] forState:UIControlStateSelected];
    return btn;
}

+ (instancetype)fk_btnWithFont:(UIFont *)font titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedTitleColor title:(NSString *)title
{
    UIButton *btn = [self fk_btnWithFont:font titleColor:titleColor title:title];
    [btn setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    return btn;
}

+ (instancetype)fk_btnWithFont:(UIFont *)font titleColor:(UIColor *)titleColor title:(NSString *)title selectedTitle:(NSString *)selectedTitle
{
    UIButton *btn = [self fk_btnWithFont:font titleColor:titleColor title:title];
    [btn setTitle:selectedTitle forState:UIControlStateSelected];
    return btn;
}

+ (instancetype)fk_btnWithFont:(UIFont *)font titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedTitleColor title:(NSString *)title selectedTitle:(NSString *)selectedTitle
{
    UIButton *btn = [self fk_btnWithFont:font titleColor:titleColor title:title selectedTitle:selectedTitle];
    [btn setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    return btn;
}

+ (instancetype)fk_btnWithFrame:(CGRect)frame font:(UIFont *)font
{
    UIButton *btn = [[self alloc] initWithFrame:frame];
    btn.titleLabel.font = font;
    btn.frame = frame;
    return btn;
}

+ (instancetype)fk_btnWithFrame:(CGRect)frame font:(UIFont *)font normalTitleColor:(UIColor *)normalTitleColor normalTitle:(NSString *)normalTitle
{
    UIButton *btn = [self fk_btnWithFrame:frame font:font];
    [btn setTitleColor:normalTitleColor forState:UIControlStateNormal];
    [btn setTitle:normalTitle forState:UIControlStateNormal];
    return btn;
}

/** 以下为分割线 */
+ (instancetype)fk_btnWithTarget:(id)target action:(SEL)action img:(UIImage *)img
{
    UIButton *btn = [self fk_btnWithTarget:target action:action font:nil normalTitle:nil normalTitleColor:nil selectedTitle:nil selectedTitleColor:nil normalImg:img selectedImg:nil bgImg:nil selectedBgImg:nil];
    return btn;
}

+ (instancetype)fk_btnWithTarget:(id)target action:(SEL)action font:(UIFont *)font normalTitle:(NSString *)normalTitle normalTitleColor:(UIColor *)normalTitleColor selectedTitle:(NSString *)selectedTitle selectedTitleColor:(UIColor *)selectedTitleColor normalImg:(UIImage *)normalImg selectedImg:(UIImage *)selectedImg bgImg:(UIImage *)bgImg selectedBgImg:(UIImage *)selectedBgImg
{
    UIButton *btn = [self buttonWithType:UIButtonTypeCustom];
    if (action) [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (font) btn.titleLabel.font = font;
    if (normalTitle) [btn setTitle:normalTitle forState:UIControlStateNormal];
    if (normalTitleColor) [btn setTitleColor:normalTitleColor forState:UIControlStateNormal];
    if (selectedTitle) [btn setTitle:selectedTitle forState:UIControlStateSelected];
    if (selectedTitleColor) [btn setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    if (normalImg) [btn setImage:normalImg forState:UIControlStateNormal];
    if (selectedImg) [btn setImage:selectedImg forState:UIControlStateSelected];
    if (bgImg) [btn setBackgroundImage:bgImg forState:UIControlStateNormal];
    if (selectedBgImg) [btn setBackgroundImage:selectedBgImg forState:UIControlStateSelected];
    return btn;
}



- (void)fk_startWithTime:(NSInteger)timeCount title:(NSString *)title countDownTitle:(NSString *)subTitle normalColor:(UIColor *)normalColor countdownColor:(UIColor *)countdownColor
{
    // 倒计时时间
    __block NSInteger timeOut = timeCount;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        // 倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = normalColor;
                [self setTitle:title forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
                self.enabled = true;
            });
        } else {
            int seconds = timeOut % 60;
            NSString * timeStr = [NSString stringWithFormat:@"%0.2d",seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = countdownColor;
                [self setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
                self.enabled = false;
            });
            timeOut--;
        }
    });
    
    dispatch_resume(_timer);
}


@end

