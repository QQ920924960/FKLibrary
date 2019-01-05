//
//  FKCustomBtn.m
//  FKLibraryExample
//
//  Created by Macbook Pro on 2019/1/3.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

#import "FKCustomBtn.h"

@implementation FKCustomBtn


#pragma mark-实例化方法
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.space = 5;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.space = 5;
}

#pragma mark-强制布局
-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置自适应
    [self.imageView sizeToFit];
    [self.titleLabel sizeToFit];
    
    switch (self.imagePosition) {
        case FKImagePositionUp:
            [self layoutSubviewsWithUpView:self.imageView downView:self.titleLabel];
            break;
        case FKImagePositionDown:
            [self layoutSubviewsWithUpView:self.titleLabel downView:self.imageView];
            break;
        case FKImagePositionLeft:
            [self layoutSubviewsWithLeftView:self.imageView rightView:self.titleLabel];
            break;
        case FKImagePositionRight:
            [self layoutSubviewsWithLeftView:self.titleLabel rightView:self.imageView];
            break;
        default:
            break;
    }
}

#pragma mark - 强制水平布局
-(void)layoutSubviewsWithLeftView:(UIView *)leftView rightView:(UIView *)rightView
{
    CGRect LeftViewFrame = leftView.frame;
    CGRect rightViewFrame = rightView.frame;
    //总宽度CGRectGetWidth（获取宽度）
    CGFloat totalWidth = CGRectGetWidth(LeftViewFrame) + self.space + CGRectGetWidth(rightViewFrame);
    //获取左边view的X值
    LeftViewFrame.origin.x = (CGRectGetWidth(self.frame) - totalWidth) * 0.5;
    //获取左边view的Y值
    LeftViewFrame.origin.y = (CGRectGetHeight(self.frame) - CGRectGetHeight(LeftViewFrame)) * 0.5;
    leftView.frame = LeftViewFrame;
    //获取右边view的X值==左边view的X值加上间距
    rightViewFrame.origin.x = CGRectGetMaxX(LeftViewFrame)+self.space;
    //获取右边view的Y值
    rightViewFrame.origin.y = (CGRectGetHeight(self.frame) - CGRectGetHeight(rightViewFrame)) * 0.5;
    rightView.frame = rightViewFrame;
}

#pragma mark - 强制垂直布局
-(void)layoutSubviewsWithUpView:(UIView *)upView downView:(UIView *)downView
{
    CGRect upViewFrame = upView.frame;
    CGRect downViewFrame = downView.frame;
    CGFloat totalHeight = CGRectGetHeight(upViewFrame) + self.space + CGRectGetHeight(downViewFrame);
    //获取上边view的X值
    upViewFrame.origin.x = (CGRectGetWidth(self.frame) - CGRectGetWidth(upViewFrame)) * 0.5;
    //获取上边的Y值
    upViewFrame.origin.y = (CGRectGetHeight(self.frame) - totalHeight) * 0.5;
    
    upView.frame = upViewFrame;
    
    //获取下边的view值
    downViewFrame.origin.x = (CGRectGetWidth(self.frame) - CGRectGetWidth(downViewFrame)) * 0.5;
    //获取Y值
    downViewFrame.origin.y = CGRectGetMaxY(upViewFrame) + self.space;
    downView.frame = downViewFrame;
}


@end
