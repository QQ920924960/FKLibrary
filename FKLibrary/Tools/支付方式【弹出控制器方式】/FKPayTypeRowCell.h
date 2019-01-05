//
//  FKPayTypeRowCell.h
//  TimesCloud
//
//  Created by frank on 2018/11/23.
//  Copyright © 2018 mfwlzlg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FKPayTypeRowCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *dict;

+ (instancetype)cellWith:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
