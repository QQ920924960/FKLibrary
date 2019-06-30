//
//  UICollectionView+FK.h
//  HappyTest
//
//  Created by Macbook Pro on 2019/1/24.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UICollectionView (FK)

- (void)fk_checkEmptyDataWithDataCount:(NSUInteger)dataCount;
- (void)fk_checkEmptyDataWithDataCount:(NSUInteger)dataCount emptyView:(UIView *)emptyView;

@end

