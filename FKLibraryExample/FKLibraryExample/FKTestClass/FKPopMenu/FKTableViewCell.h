//
//  FKTableViewCell.h
//  FKLibraryExample
//
//  Created by frank on 15/11/11.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FKTableViewCell;

@protocol FKTableViewCellDelegate <NSObject>
//@optional
- (void)buttonDelegate:(FKTableViewCell *)fkTableViewCell button:(UIButton *)button;
@end

@interface FKTableViewCell : UITableViewCell
@property (nonatomic, weak) id<FKTableViewCellDelegate> delegate;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
