//
//  FKTableCell.h
//  HHShopping
//
//  Created by frank on 2018/8/21.
//  Copyright © 2018年 嘉瑞科技有限公司 - 凯叔叔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FKTableCell : UITableViewCell

+ (instancetype)cellWith:(UITableView *)tableView;
+ (instancetype)cellWith:(UITableView *)tableView className:(NSString *)className;
- (void)setupSubviews;

@end
