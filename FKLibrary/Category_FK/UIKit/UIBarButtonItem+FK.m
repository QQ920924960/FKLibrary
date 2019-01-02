//
//  UIBarButtonItem+FK.m
//  FKLibraryExample
//
//  Created by frank on 15/11/2.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "UIBarButtonItem+FK.h"

@implementation UIBarButtonItem (FK)

+ (UIBarButtonItem *)fk_itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    
    // 设置按钮的尺寸为背景图片的尺寸
    CGRect buttonF = button.frame;
    buttonF.size = (CGSize)button.currentBackgroundImage.size;
    button.frame = buttonF;
    
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)fk_itemWithTarget:(id)target action:(SEL)action text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    CGSize Btnsize = [button sizeThatFits:CGSizeMake(fkScreenW, fkScreenH)];
    button.fk_size = CGSizeMake(Btnsize.width + 10, Btnsize.height + 5);
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


@end
