//
//  FKTableCell.h
//  FKLibraryExample
//
//  Created by frank on 2018/8/21.
//  Copyright © 2018年 zmosa - frank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FKTableCell : UITableViewCell

@property (nonatomic, strong) id data;
@property (nonatomic, weak) id delegate;

+ (instancetype)cellWith:(UITableView *)tableView;
+ (instancetype)cellWith:(UITableView *)tableView className:(NSString *)className;
- (void)setupSubviews;

@end
