//
//  UIColor+FK.m
//  FKLibraryExample
//
//  Created by frank on 15/11/7.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "UIColor+FK.h"
#import <CoreGraphics/CoreGraphics.h>
#import <CoreImage/CoreImage.h>
#import <UIKit/UIKitDefines.h>

@interface UIColor ()

@property (nonatomic, readonly) CGFloat red;
@property (nonatomic, readonly) CGFloat green;
@property (nonatomic, readonly) CGFloat blue;
@property (nonatomic, readonly) CGFloat alpha;

@end

@implementation UIColor (FK)

static UIColor *initWith;

+ (instancetype)colorShared {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        initWith = [[UIColor alloc] init];
    });
    return initWith;
}

+ (NSMutableDictionary *)standardColors {
    static NSMutableDictionary *colors = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        colors = [@{@"black": [self blackColor], // 0.0 white
                    @"darkgray": [self darkGrayColor], // 0.333 white
                    @"lightgray": [self lightGrayColor], // 0.667 white
                    @"white": [self whiteColor], // 1.0 white
                    @"gray": [self grayColor], // 0.5 white
                    @"red": [self redColor], // 1.0, 0.0, 0.0 RGB
                    @"green": [self greenColor], // 0.0, 1.0, 0.0 RGB
                    @"blue": [self blueColor], // 0.0, 0.0, 1.0 RGB
                    @"cyan": [self cyanColor], // 0.0, 1.0, 1.0 RGB
                    @"yellow": [self yellowColor], // 1.0, 1.0, 0.0 RGB
                    @"magenta": [self magentaColor], // 1.0, 0.0, 1.0 RGB
                    @"orange": [self orangeColor], // 1.0, 0.5, 0.0 RGB
                    @"purple": [self purpleColor], // 0.5, 0.0, 0.5 RGB
                    @"brown": [self brownColor], // 0.6, 0.4, 0.2 RGB
                    @"clear": [self clearColor]} mutableCopy];
    });
    
    return colors;
}

- (void)fk_getRGBAComponents:(CGFloat[4])rgba {
    CGColorSpaceModel model = CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    switch (model)
    {
        case kCGColorSpaceModelMonochrome:
        {
            rgba[0] = components[0];
            rgba[1] = components[0];
            rgba[2] = components[0];
            rgba[3] = components[1];
            break;
        }
        case kCGColorSpaceModelRGB:
        {
            rgba[0] = components[0];
            rgba[1] = components[1];
            rgba[2] = components[2];
            rgba[3] = components[3];
            break;
        }
        default:
        {
            
#ifdef DEBUG
            //不支持的格式
            NSLog(@"不支持的颜色 格式: %i", model);
#endif
            rgba[0] = 0.0f;
            rgba[1] = 0.0f;
            rgba[2] = 0.0f;
            rgba[3] = 1.0f;
            break;
        }
    }
}

+ (void)fk_registerColor:(UIColor *)color forName:(NSString *)name
{
    name = [name lowercaseString];
#ifdef DEBUG
    //不允许重新登记
    NSAssert([self standardColors][name] == nil || [[self standardColors][name] fk_isEquivalentToColor:color], @"无法重新注册的颜色 '%@' 这是已分配", name);
#endif
    [self standardColors][[name lowercaseString]] = color;
}

+ (UIColor *)fk_colorWithString:(NSString *)string
{
    //转换为小写
    string = [string lowercaseString];
    
    //首先尝试标准颜色
    UIColor *color = [self standardColors][string];
    if (color) {
        return color;
    }
    
    //返回一个新的实例
    return [[self alloc] initWithString:string];
}

+ (UIColor *)fk_colorWithRGBValue:(uint32_t)rgb
{
    return [[self alloc] fk_initWithRGBValue:rgb];
}

+ (UIColor *)fk_colorWithRGBAValue:(uint32_t)rgba
{
    return [[self alloc] fk_initWithRGBAValue:rgba];
}

- (UIColor *)initWithString:(NSString *)string
{
    //转换为小写
    string = [string lowercaseString];
    
    //试标准颜色
    UIColor *color = [[self class] standardColors][string];
    if (color)
    {
        return ((self = color));
    }
    
    //try hex
    string = [string stringByReplacingOccurrencesOfString:@"#" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"0x" withString:@""];
    switch ([string length])
    {
        case 0:
        {
            string = @"00000000";
            break;
        }
        case 3:
        {
            NSString *red = [string substringWithRange:NSMakeRange(0, 1)];
            NSString *green = [string substringWithRange:NSMakeRange(1, 1)];
            NSString *blue = [string substringWithRange:NSMakeRange(2, 1)];
            string = [NSString stringWithFormat:@"%1$@%1$@%2$@%2$@%3$@%3$@ff", red, green, blue];
            break;
        }
        case 6:
        {
            string = [string stringByAppendingString:@"ff"];
            break;
        }
        case 8:
        {
            //什么都不做
            break;
        }
        default:
        {
            
#ifdef DEBUG
            
            //不支持的格式
            NSLog(@"不持的格式颜色字符串: %@", string);
#endif
            return nil;
        }
    }
    uint32_t rgba;
    NSScanner *scanner = [NSScanner scannerWithString:string];
    [scanner scanHexInt:&rgba];
    return [self fk_initWithRGBAValue:rgba];
}

- (UIColor *)fk_initWithRGBValue:(uint32_t)rgb {
    CGFloat red = ((rgb & 0xFF0000) >> 16) / 255.0f;
    CGFloat green = ((rgb & 0x00FF00) >> 8) / 255.0f;
    CGFloat blue = (rgb & 0x0000FF) / 255.0f;
    return [self initWithRed:red green:green blue:blue alpha:1.0f];
}

- (UIColor *)fk_initWithRGBAValue:(uint32_t)rgba {
    CGFloat red = ((rgba & 0xFF000000) >> 24) / 255.0f;
    CGFloat green = ((rgba & 0x00FF0000) >> 16) / 255.0f;
    CGFloat blue = ((rgba & 0x0000FF00) >> 8) / 255.0f;
    CGFloat alpha = (rgba & 0x000000FF) / 255.0f;
    return [self initWithRed:red green:green blue:blue alpha:alpha];
}

- (uint32_t)fk_RGBValue {
    CGFloat rgba[4];
    [self fk_getRGBAComponents:rgba];
    uint8_t red = rgba[0]*255;
    uint8_t green = rgba[1]*255;
    uint8_t blue = rgba[2]*255;
    return (red << 16) + (green << 8) + blue;
}

- (uint32_t)fk_RGBAValue {
    CGFloat rgba[4];
    [self fk_getRGBAComponents:rgba];
    uint8_t red = rgba[0]*255;
    uint8_t green = rgba[1]*255;
    uint8_t blue = rgba[2]*255;
    uint8_t alpha = rgba[3]*255;
    return (red << 24) + (green << 16) + (blue << 8) + alpha;
}

- (NSString *)fk_stringValue {
    //try 标准颜色
    NSUInteger index = [[[[self class] standardColors] allValues] indexOfObject:self];
    if (index != NSNotFound)
    {
        return [[[self class] standardColors] allKeys][index];
    }
    
    //转换为十六进制
    if (self.alpha < 1.0f)
    {
        //包含一个透明成份
        return [NSString stringWithFormat:@"#%.8x", self.fk_RGBAValue];
    }
    else
    {
        //不包含 alpha 分量
        return [NSString stringWithFormat:@"#%.6x", self.fk_RGBValue];
    }
}

- (CGFloat)red {
    CGFloat rgba[4];
    [self fk_getRGBAComponents:rgba];
    return rgba[0];
}

- (CGFloat)green {
    CGFloat rgba[4];
    [self fk_getRGBAComponents:rgba];
    return rgba[1];
}

- (CGFloat)blue {
    CGFloat rgba[4];
    [self fk_getRGBAComponents:rgba];
    return rgba[2];
}

- (CGFloat)alpha {
    return CGColorGetAlpha(self.CGColor);
}

- (BOOL)fk_isMonochromeOrRGB {
    CGColorSpaceModel model = CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
    return model == kCGColorSpaceModelMonochrome || model == kCGColorSpaceModelRGB;
}

- (BOOL)fk_isEquivalent:(id)object {
    if ([object isKindOfClass:[self class]])
    {
        return [self fk_isEquivalentToColor:object];
    }
    return NO;
}

- (BOOL)fk_isEquivalentToColor:(UIColor *)color {
    if ([self fk_isMonochromeOrRGB] && [color fk_isMonochromeOrRGB])
    {
        return self.fk_RGBAValue == color.fk_RGBAValue;
    }
    return [self isEqual:color];
}

- (UIColor *)fk_colorWithBrightness:(CGFloat)brightness {
    brightness = fminf(fmaxf(brightness, 0.0f), 1.0f);
    
    CGFloat rgba[4];
    [self fk_getRGBAComponents:rgba];
    
    return [[self class] colorWithRed:rgba[0] * brightness
                                green:rgba[1] * brightness
                                 blue:rgba[2] * brightness
                                alpha:rgba[3]];
}

- (UIColor *)fk_colorBlendedWithColor:(UIColor *)color factor:(CGFloat)factor {
    factor = fminf(fmaxf(factor, 0.0f), 1.0f);
    
    CGFloat fromRGBA[4], toRGBA[4];
    [self fk_getRGBAComponents:fromRGBA];
    [color fk_getRGBAComponents:toRGBA];
    
    return [[self class] colorWithRed:fromRGBA[0] + (toRGBA[0] - fromRGBA[0]) * factor
                                green:fromRGBA[1] + (toRGBA[1] - fromRGBA[1]) * factor
                                 blue:fromRGBA[2] + (toRGBA[2] - fromRGBA[2]) * factor
                                alpha:fromRGBA[3] + (toRGBA[3] - fromRGBA[3]) * factor];
}

+ (UIColor *)fk_colorWithHex:(NSInteger)rgbHexValue
{
    if (rgbHexValue <= 0xFFFFFF) {
        return [UIColor fk_colorWithHex:rgbHexValue alpha:1.0];
    } else {
        return [UIColor fk_colorWithHex:(rgbHexValue & 0xFFFFFF00) >> 8 alpha:((float)(rgbHexValue & 0xFF)) / 255.0];
    }
}

+ (UIColor *)fk_colorWithHex:(NSInteger)rgbHexValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((rgbHexValue & 0xFF0000) >> 16)) / 255.0
                           green:((float)((rgbHexValue & 0xFF00) >> 8)) / 255.0
                            blue:((float)(rgbHexValue & 0xFF)) / 255.0
                           alpha:alpha];
}

+ (UIColor *)fk_colorWithHexString:(NSString *)hexStr
{
    @autoreleasepool
    {
        NSString *cleanString_1 = [hexStr stringByReplacingOccurrencesOfString:@"#" withString:@""];
        NSString *cleanString = [cleanString_1 stringByReplacingOccurrencesOfString:@"0x" withString:@""];
        if ([cleanString length] == 3) {
            cleanString =
            [NSString stringWithFormat:@"%@%@%@%@%@%@", [cleanString substringWithRange:NSMakeRange(0, 1)],
             [cleanString substringWithRange:NSMakeRange(0, 1)],
             [cleanString substringWithRange:NSMakeRange(1, 1)],
             [cleanString substringWithRange:NSMakeRange(1, 1)],
             [cleanString substringWithRange:NSMakeRange(2, 1)],
             [cleanString substringWithRange:NSMakeRange(2, 1)]];
        }
        if ([cleanString length] == 6) {
            cleanString = [cleanString stringByAppendingString:@"ff"];
        }
        
        unsigned int baseValue;
        [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
        
        float red = ((baseValue >> 24) & 0xFF) / 255.0f;
        float green = ((baseValue >> 16) & 0xFF) / 255.0f;
        float blue = ((baseValue >> 8) & 0xFF) / 255.0f;
        float alpha = ((baseValue >> 0) & 0xFF) / 255.0f;
        
        return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    }
}

//返回一个随机的颜色
+ (UIColor *)fk_randomColor
{
    return [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0];
}

//返回一个随机的颜色
+ (UIColor *)fk_randomColorWithColorArray:(NSArray *)colorArray
{
    NSInteger index = arc4random() % colorArray.count;
    NSString * hexString = [colorArray objectAtIndex:index];
    return [UIColor fk_colorWithHexString:hexString];
}


@end
