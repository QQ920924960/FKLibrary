//
//  UIColor+FKCategory.h
//  FKLibraryExample
//
//  Created by frank on 15/11/7.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (FKCategory)

/**
 *  通过传入一个16进制的颜色值来返回一个颜色
 *
 *  @param rgbHexValue 16进制的颜色值
 *
 *  @return 返回颜色
 */
+ (UIColor *)FKColorWithHex:(NSInteger)rgbHexValue;

/**
 *  通过传入一个16进制的颜色值来返回一个带alpha通道的颜色
 *
 *  @param rgbHexValue 16进制的颜色值
 *  @param alpha       alpha值
 *
 *  @return 返回的颜色
 */
+ (UIColor *)FKColorWithHex:(NSInteger)rgbHexValue alpha:(CGFloat)alpha;

@end
