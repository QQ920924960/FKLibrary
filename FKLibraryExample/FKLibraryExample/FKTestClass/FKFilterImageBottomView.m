//
//  FKFilterImageBottomView.m
//  FKLibraryExample
//
//  Created by frank on 15/11/9.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "FKFilterImageBottomView.h"
#import "FKMacro.h"
#import "FKFilterBottomBar.h"
#import "Masonry.h"


@interface FKFilterImageBottomView ()
/** 滑动条 */
@property (nonatomic, weak) UISlider *slider;
/** 底部的collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;
/** 底部装着一排按钮的工具条 */
@property (nonatomic, strong) FKFilterBottomBar *bottomBar;
@end

@implementation FKFilterImageBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 因为Y值从底部算起,所以就按倒序的方式来一个个创建控件
        FKFilterBottomBar *bottomBar = [[FKFilterBottomBar alloc] init];
        bottomBar.backgroundColor = [UIColor blueColor];
        [self addSubview:bottomBar];
        self.bottomBar = bottomBar;
        
        UICollectionView *collectionView = [[UICollectionView alloc] init];
        collectionView.backgroundColor = [UIColor redColor];
        [self addSubview:collectionView];
        self.collectionView = collectionView;
        
        UISlider *slider = [[UISlider alloc] init];
        slider.backgroundColor = [UIColor yellowColor];
        [self addSubview:slider];
        self.slider = slider;
    }
    return self;
}

/**
 *  在这个方法中计算所有子控件的frame
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 底部工具条
    [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo([UIScreen mainScreen]);
        make.bottom.equalTo([UIScreen mainScreen]);
        make.width.equalTo([UIScreen mainScreen]);
        make.height.equalTo(@40);
    }];
    
    // 底部的collectionView
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([UIScreen mainScreen]);
        make.bottom.equalTo(self.bottomBar.mas_top);
        make.width.equalTo([UIScreen mainScreen]);
        make.height.equalTo(@50);
    }];
  
    // 滑动条
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([UIScreen mainScreen]);
        make.bottom.equalTo(self.collectionView.mas_top);
        make.width.equalTo([UIScreen mainScreen]);
        make.height.equalTo(@30);
    }];
    
    // 自己的约束
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([UIScreen mainScreen]);
        make.bottom.equalTo([UIScreen mainScreen]);
        make.width.equalTo([UIScreen mainScreen]);
        make.height.equalTo(self.slider.mas_top);
    }];
}

@end
