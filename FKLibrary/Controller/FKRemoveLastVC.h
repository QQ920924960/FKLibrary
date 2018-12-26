//
//  FKRemoveLastVC.h
//  BaiYeMallShop
//
//  Created by frank on 2018/12/3.
//  Copyright © 2018 凯叔叔. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FKRemoveLastVC : UIViewController

/** 是否需要移除navigationcontroller中的上一个childVC */
@property(nonatomic, assign, getter=isNeedRemoveBeforeVc) BOOL needRemoveBeforeVc;

@end

NS_ASSUME_NONNULL_END
