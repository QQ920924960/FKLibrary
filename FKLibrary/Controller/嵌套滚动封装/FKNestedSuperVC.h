//
//  FKNestedSuperVC.h
//  HappyTest
//
//  Created by Macbook Pro on 2019/2/15.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FKPenetrateTouchTableView;

@interface FKNestedSuperVC : UIViewController

/** 是否需要隐藏导航栏 */
@property(nonatomic, assign, getter=isNeedHideNav) BOOL needHideNav;
@property (nonatomic, weak) FKPenetrateTouchTableView *tableView;
@property (nonatomic, assign) CGFloat criticalPointOffsetY; // 临界点的offsetY

/** 如果子类实现了scrollViewDidScroll:方法，则需要在子类调用scrollViewDidScroll的内部调用该方法 */
- (void)fk_scrollViewDidScroll:(UIScrollView *)scrollView;

@end

