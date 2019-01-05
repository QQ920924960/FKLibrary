//
//  UITableView+FK.m
//  FKLibraryExample
//
//  Created by frank on 2018/8/17.
//  Copyright © 2018年 zmosa - frank. All rights reserved.
//

#import "UITableView+FK.h"

@implementation UITableView (FK)

- (void)fk_tableViewCheckEmptyDataWithDataCount:(NSUInteger)dataCount
{
    [self fk_tableViewCheckEmptyDataWithDataCount:dataCount emptyView:nil];
}

- (void)fk_tableViewCheckEmptyDataWithDataCount:(NSUInteger)dataCount emptyView:(UIView *)emptyView
{
    if (dataCount == 0) {
        if (emptyView) {
            self.backgroundView = emptyView;
        } else {
            // 没有数据的时候，UILabel的显示样式
            UILabel *messageLabel = [UILabel new];
            
            messageLabel.text = @"暂无数据";
            messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
            messageLabel.textColor = [UIColor lightGrayColor];
            messageLabel.textAlignment = NSTextAlignmentCenter;
            [messageLabel sizeToFit];
            self.backgroundView = messageLabel;
        }
    } else {
        self.backgroundView = nil;
    }
}

@end
