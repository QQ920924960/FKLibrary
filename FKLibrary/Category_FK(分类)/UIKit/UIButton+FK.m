//
//  UIButton+FK.m
//  FKLibraryExample
//
//  Created by frank on 15/11/7.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "UIButton+FK.h"

@implementation UIButton (FK)

- (void)fk_buttonSetTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font forState:(UIControlState)state
{
    [self setTitle:title forState:state];
    [self setTitleColor:titleColor forState:state];
    self.titleLabel.font = font;
}

@end
