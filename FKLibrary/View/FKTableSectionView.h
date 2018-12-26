//
//  FKTableSectionView.h
//  FKLibraryExample
//
//  Created by frank on 2018/9/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FKTableSectionView : UITableViewHeaderFooterView

+ (instancetype)sectionView:(UITableView *)tableView;

- (void)setupSubviews;

@end
