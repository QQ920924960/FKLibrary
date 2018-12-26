//
//  FKConst.m
//  FKLibraryExample
//
//  Created by frank on 15/11/6.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

/* 统一的请求路径 */
NSString * const HostURL = @"";
NSString * const TestURL = @"";

// 友盟
NSString *const AppKey_UMCShare = @"";
// QQ登录(ok)
NSString *const AppID_QQ = @"";
NSString *const AppKey_QQ = @"";
// 微信(ok)
NSString *const AppID_WX = @"";
NSString *const AppSecret_WX = @"";
// 微博
NSString *const AppKey_Weibo = @"";
NSString *const AppSecret_Weibo = @"";

// 高德地图的apiKey =
NSString *const AppKey_AMap = @"";

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


