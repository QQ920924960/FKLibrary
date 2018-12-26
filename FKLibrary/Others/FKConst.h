//
//  FKConst.h
//  FKLibraryExample
//
//  Created by frank on 15/11/6.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#ifndef FKConst_h
#define FKConst_h
/*************** 内容 ***************/
#import <UIKit/UIKit.h>

/* 统一的请求路径 */
UIKIT_EXTERN NSString * const HostURL;
UIKIT_EXTERN NSString * const TestURL;


// ShareSDK
UIKIT_EXTERN NSString *const AppKey_UMCShare;
// QQ登录
UIKIT_EXTERN NSString *const AppID_QQ;
UIKIT_EXTERN NSString *const AppKey_QQ;
// 微信
UIKIT_EXTERN NSString *const AppID_WX;
UIKIT_EXTERN NSString *const AppSecret_WX;
// 微博
UIKIT_EXTERN NSString *const AppKey_Weibo;
UIKIT_EXTERN NSString *const AppSecret_Weibo;


// 高德地图
UIKIT_EXTERN NSString *const AppKey_AMap;




/**
 *  角度转弧度
 *
 *  @param Angle 角度
 *
 *  @return 弧度
 */
UIKIT_EXTERN CGFloat const FKAngleToRadian(CGFloat Angle);

/**
 *  弧度转角度
 *
 *  @param Angle 弧度
 *
 *  @return 角度
 */
UIKIT_EXTERN CGFloat const FKRadianToAngle(CGFloat radian);


/*************** 内容 ***************/
#endif /* FKConst_h */
