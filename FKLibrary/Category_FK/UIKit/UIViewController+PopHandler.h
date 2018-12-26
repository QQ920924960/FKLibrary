//
//  UIViewController+PopHandler.h
//  BaiYeMallShop
//
//  Created by frank on 2018/11/28.
//  Copyright © 2018 凯叔叔. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PopHandlerProtocol <NSObject>
@optional
- (BOOL)navigationShouldPop;
@end

@interface UIViewController (PopHandler)<PopHandlerProtocol>

@end

NS_ASSUME_NONNULL_END
