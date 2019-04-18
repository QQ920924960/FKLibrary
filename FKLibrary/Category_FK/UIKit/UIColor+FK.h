//
//  UIColor+FK.h
//  FKLibraryExample
//
//  Created by frank on 15/11/7.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (FK)



/**
 *  单例
 *
 
 */
+ (instancetype)colorShared;

+ (void)fk_registerColor:(UIColor *)color forName:(NSString *)name;

/**
 *  十六制颜色值
 *
 *  @param string #XXXX
 *
 *  @return 返回一个新的颜色对象
 */
+ (UIColor *)fk_colorWithString:(NSString *)string;
/** 32位RGB值 **/
+ (UIColor *)fk_colorWithRGBValue:(uint32_t)rgb;
+ (UIColor *)fk_colorWithRGBAValue:(uint32_t)rgba;
/**
 *  十六进制颜色值
 *
 *  @param string #XXXXXX
 *
 *  @return 返回一个新的颜色对象
 */
- (UIColor *)initWithString:(NSString *)string;
- (UIColor *)fk_initWithRGBValue:(uint32_t)rgb;
- (UIColor *)fk_initWithRGBAValue:(uint32_t)rgba;

- (uint32_t)fk_RGBValue;
- (uint32_t)fk_RGBAValue;
- (NSString *)fk_stringValue;

- (BOOL)fk_isMonochromeOrRGB;
- (BOOL)fk_isEquivalent:(id)object;
- (BOOL)fk_isEquivalentToColor:(UIColor *)color;

- (UIColor *)fk_colorWithBrightness:(CGFloat)brightness;
- (UIColor *)fk_colorBlendedWithColor:(UIColor *)color factor:(CGFloat)factor;

+ (UIColor *)fk_colorWithHex:(NSInteger)rgbHexValue;
+ (UIColor *)fk_colorWithHex:(NSInteger)rgbHexValue alpha:(CGFloat)alpha;

+ (UIColor *)fk_colorWithHexString:(NSString *)hexStr;

//返回一个随机的颜色
+ (UIColor *)fk_randomColor;
//随机返回数组里面的任一个颜色
+ (UIColor *)fk_randomColorWithColorArray:(NSArray *)colorArray;

@end
