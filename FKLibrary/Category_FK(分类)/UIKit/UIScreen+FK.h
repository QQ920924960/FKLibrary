//
//  UIScreen+FK.h
//  FKLibraryExample
//
//  Created by frank on 15/11/9.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (FK)


/**
 *  返回屏幕缩放的比例
 */
+ (CGFloat)fk_screenScale;

/**
 *  返回当前屏幕的边界
 */
- (CGRect)fk_currentBounds;

/**
 *  根据传入的操作返回边界
 *
 *  @param orientation 传入的操作
 *
 *  @return 边界
 */
- (CGRect)fk_boundsForOrientation:(UIInterfaceOrientation)orientation;

/**
 用像素表示的屏幕的真实尺寸
 The screen's real size in pixel (width is always smaller than height).
 This value may not be very accurate in an unknown device, or simulator.
 e.g. (768,1024)
 */
@property (nonatomic, readonly) CGSize sizeInPixel;

/**
 The screen's PPI.
 This value may not be very accurate in an unknown device, or simulator.
 Default value is 96.
 */
@property (nonatomic, readonly) CGFloat pixelsPerInch;

@end
