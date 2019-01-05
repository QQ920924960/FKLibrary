//
//  UITableView+FK.h
//  FKLibraryExample
//
//  Created by frank on 2018/8/17.
//  Copyright © 2018年 zmosa - frank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (FK)

- (void)fk_tableViewCheckEmptyDataWithDataCount:(NSUInteger)dataCount;

- (void)fk_tableViewCheckEmptyDataWithDataCount:(NSUInteger)dataCount emptyView:(UIView *)emptyView;

@end
