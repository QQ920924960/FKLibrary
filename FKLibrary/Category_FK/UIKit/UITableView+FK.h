//
//  UITableView+FK.h
//  HHShopping
//
//  Created by frank on 2018/8/17.
//  Copyright © 2018年 嘉瑞科技有限公司 - 凯叔叔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (FK)

- (void)hg_tableViewCheckEmptyDataWithDataCount:(NSUInteger)dataCount;

- (void)hg_tableViewCheckEmptyDataWithDataCount:(NSUInteger)dataCount emptyView:(UIView *)emptyView;

@end
