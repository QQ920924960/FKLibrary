//
//  FKPayTypeVC.h
//  inspectVehicle
//
//  Created by frank on 2018/12/14.
//  Copyright © 2018 胡俊杰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FKPayTypeVC : UIViewController

@property (nonatomic, copy) void(^selectedPayType) (NSString *payType);

@end

NS_ASSUME_NONNULL_END
