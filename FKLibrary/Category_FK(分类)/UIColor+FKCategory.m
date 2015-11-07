//
//  UIColor+FKCategory.m
//  FKLibraryExample
//
//  Created by frank on 15/11/7.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "UIColor+FKCategory.h"

@implementation UIColor (FKCategory)

+ (UIColor *)FKColorWithHex:(NSInteger)rgbHexValue
{
    if (rgbHexValue <= 0xFFFFFF) {
        return [UIColor FKColorWithHex:rgbHexValue alpha:1.0];
    } else {
        return [UIColor FKColorWithHex:(rgbHexValue & 0xFFFFFF00) >> 8 alpha:((float)(rgbHexValue & 0xFF)) / 255.0];
    }
}

+ (UIColor *)FKColorWithHex:(NSInteger)rgbHexValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((rgbHexValue & 0xFF0000) >> 16)) / 255.0
                           green:((float)((rgbHexValue & 0xFF00) >> 8)) / 255.0
                            blue:((float)(rgbHexValue & 0xFF)) / 255.0
                           alpha:alpha];
}

@end
