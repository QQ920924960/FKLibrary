//
//  FKFormVC.h
//  BaiYeMallShop
//
//  Created by frank on 2018/11/27.
//  Copyright © 2018 凯叔叔. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FKFormVC : UITableViewController

@property (nonatomic, strong) NSArray *datas;

/** 设置确认按钮的title和背景色 */
- (void)setupBottomBtnTitle:(NSString *)title bgColor:(UIColor *)bgColor;
/** 点击确定按钮 */
- (void)confirmBtnClicked:(UIButton *)btn;

@end

NS_ASSUME_NONNULL_END
