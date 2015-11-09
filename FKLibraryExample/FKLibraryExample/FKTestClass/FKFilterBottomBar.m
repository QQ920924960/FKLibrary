//
//  FKFilterBottomBar.m
//  FKLibraryExample
//
//  Created by frank on 15/11/9.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "FKFilterBottomBar.h"

@interface FKFilterBottomBar ()
/** 取消按钮【叉叉】*/
@property (nonatomic, weak) UIButton *clostBtn;
/** 确定按钮【对勾】*/
@property (nonatomic, weak) UIButton *identifyBtn;
@end

@implementation FKFilterBottomBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 取消按钮
        UIButton *clostBtn = [[UIButton alloc] init];
        [self addSubview:clostBtn];
        self.clostBtn = clostBtn;
        
        // 确定按钮
        UIButton *identifyBtn = [[UIButton alloc] init];
        [self addSubview:identifyBtn];
        self.identifyBtn = identifyBtn;
    }
    return self;
}

@end
