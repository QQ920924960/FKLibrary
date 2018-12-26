//
//  FKPayPwdInputView.h
//  HHShopping
//
//  Created by frank on 2018/9/17.
//  Copyright © 2018年 嘉瑞科技有限公司 - 凯叔叔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FKPayPwdInputView : UIView

@property(nonatomic, weak) UIViewController *superVC;
@property(nonatomic, copy) void(^inputFinishBlock) (NSString *pwd);
@property(nonatomic, copy) void(^closeBlock) (void);
- (void)show;
+ (instancetype)payPwdInputViewWith:(UIViewController *)superVC;

@end
