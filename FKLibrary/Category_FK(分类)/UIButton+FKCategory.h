//
//  UIButton+FKCategory.h
//  FKLibraryExample
//
//  Created by frank on 15/11/7.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (FKCategory)


- (void)FKButtonSetTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font forState:(UIControlState)state;

@end
