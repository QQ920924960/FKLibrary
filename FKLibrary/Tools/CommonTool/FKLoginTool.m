//
//  FKLoginTool.m
//  HHShopping
//
//  Created by frank on 2018/8/16.
//  Copyright © 2018年 嘉瑞科技有限公司 - 凯叔叔. All rights reserved.
//

#import "FKLoginTool.h"
#import "FKNavVC.h"

@implementation FKLoginTool

+ (void)showLoginByPresent
{
    UIViewController *login = [[UIViewController alloc] init];
    FKNavVC *nav = [[FKNavVC alloc] initWithRootViewController:login];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window.rootViewController presentViewController:nav animated:YES completion:nil];
}

+ (void)showLoginBySwitchRootVC
{
    UIViewController *login = [[UIViewController alloc] init];
    FKNavVC *nav = [[FKNavVC alloc] initWithRootViewController:login];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    window.rootViewController = nav;
}

+ (void)checkLogin:(void (^)(void))completion
{
    NSDictionary *loginInfo = [FKCacheTool loginInfo];
    if (!loginInfo) {
        [self showLoginByPresent];
    } else {
        completion();
    }
}

@end
