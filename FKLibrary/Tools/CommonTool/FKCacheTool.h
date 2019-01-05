//
//  FKCacheTool.h
//  FKLibraryExample
//
//  Created by frank on 2018/8/13.
//  Copyright © 2018年 zmosa - frank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FKCacheTool : NSObject

// 登录信息
+ (NSDictionary *)loginInfo;
+ (void)saveLoginInfo:(NSDictionary *)loginInfo;
+ (BOOL)isLogin;

// 用户信息
+ (void)saveUserInfo:(NSDictionary *)userInfo;
+ (NSDictionary *)userInfo;
+ (BOOL)isHasPayPwd;
+ (void)savePayPwd:(NSString *)payPwd; // 缓存支付密码的状态


#pragma mark - 文件缓存





@end

