//
//  FKAlignmentLayout.h
//  HappyTest
//
//  Created by Macbook Pro on 2019/1/5.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM (NSInteger, AlignType){
    AlignLeft,
    AlignCenter,
    AlignRight
};

@interface FKAlignmentLayout : UICollectionViewFlowLayout

// 两个Cell之间的距离
@property (nonatomic, assign) CGFloat marginOfCell;
// cell对齐方式
@property (nonatomic, assign) AlignType alignType;

- (instancetype)initWithType:(AlignType)alignType;

- (instancetype)initWithType:(AlignType)alignType marginOfCell:(CGFloat)marginOfCell;

@end

