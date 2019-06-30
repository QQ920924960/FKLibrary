//
//  UICollectionView+FK.m
//  HappyTest
//
//  Created by Macbook Pro on 2019/1/24.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

#import "UICollectionView+FK.h"

@implementation UICollectionView (FK)

- (void)fk_checkEmptyDataWithDataCount:(NSUInteger)dataCount
{
    [self fk_checkEmptyDataWithDataCount:dataCount emptyView:nil];
}

- (void)fk_checkEmptyDataWithDataCount:(NSUInteger)dataCount emptyView:(UIView *)emptyView
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
