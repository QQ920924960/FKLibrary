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
@property (nonatomic, weak) UIScrollView *scrollView;
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
        [self addSubview:bottomBar];
        self.bottomBar = bottomBar;
        
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        UISlider *slider = [[UISlider alloc] init];
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
}

- (void)setBottomBarConstraint
{
    // 底部工具条
    self.bottomBar.backgroundColor = [UIColor blueColor];
    [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(@40);
    }];
    
    // 底部的scrollView
    self.scrollView.backgroundColor = [UIColor redColor];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.bottomBar.mas_top);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(@50);
    }];
    
    // 滑动条
//    self.slider.backgroundColor = [UIColor yellowColor];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.bottom.equalTo(self.scrollView.mas_top);
        make.right.equalTo(self.mas_right).offset(-20);
    }];
    [self sizeToFit];
}



@end
