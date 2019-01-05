//
//  FKLoginTool.h
//  FKLibraryExample
//
//  Created by frank on 2018/8/16.
//  Copyright © 2018年 zmosa - frank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FKLoginTool : NSObject

+ (void)showLoginByPresent;

+ (void)showLoginBySwitchRootVC;

+ (void)checkLogin:(void (^)(void))completion;

@end
