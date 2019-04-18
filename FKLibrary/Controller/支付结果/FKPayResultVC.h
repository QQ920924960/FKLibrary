//
//  FKPayResultVC.h
//  HappyTest
//
//  Created by Macbook Pro on 2019/2/19.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FKRemoveLastVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface FKPayResultVC : FKRemoveLastVC

@property (nonatomic, assign, getter=isFailure) BOOL failure;

@end

NS_ASSUME_NONNULL_END
