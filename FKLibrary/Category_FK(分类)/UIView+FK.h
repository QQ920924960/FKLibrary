//
//  UIView+FK.h
//  FKLibraryExample
//
//  Created by frank on 15/11/2.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FK)

@property (nonatomic, assign) CGFloat fk_x;
@property (nonatomic, assign) CGFloat fk_y;
@property (nonatomic, assign) CGFloat fk_centerX;
@property (nonatomic, assign) CGFloat fk_centerY;
@property (nonatomic, assign) CGFloat fk_width;
@property (nonatomic, assign) CGFloat fk_height;
@property (nonatomic, assign) CGSize fk_size;


- (void)fk_viewCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)width borderColor:(UIColor *)borderColor;

@end
