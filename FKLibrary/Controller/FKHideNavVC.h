//
//  FKHideNavVC.h
//  TimesCloud
//
//  Created by frank on 2018/11/7.
//  Copyright © 2018年 mfwlzlg. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FKHideNavVC : UIViewController

@property (nonatomic, copy) NSString *rightImgName;
/** 是否需要移除navigationcontroller中的上一个childVC */
@property(nonatomic, assign, getter=isNeedRemoveBeforeVc) BOOL needRemoveBeforeVc;

- (void)setupNav;
- (void)setupNav:(NSString *)leftItemImgName;

- (void)rightItemClicked;

@end

