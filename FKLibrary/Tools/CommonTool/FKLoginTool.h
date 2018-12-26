//
//  FKLoginTool.h
//  HHShopping
//
//  Created by frank on 2018/8/16.
//  Copyright © 2018年 嘉瑞科技有限公司 - 凯叔叔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FKLoginTool : NSObject

+ (void)showLoginByPresent;

+ (void)showLoginBySwitchRootVC;

+ (void)checkLogin:(void (^)(void))completion;

@end
