//
//  FKConst.m
//  FKLibraryExample
//
//  Created by frank on 15/11/6.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
/**
 *  角度转弧度
 *
 *  @param Angle 角度
 *
 *  @return 弧度
 */
CGFloat const FKAngleToRadian(CGFloat Angle) {return Angle * M_PI / 180;};

/**
 *  弧度转角度
 *
 *  @param Angle 弧度
 *
 *  @return 角度
 */
CGFloat const FKRadianToAngle(CGFloat radian) {return radian * 180/M_PI;};


