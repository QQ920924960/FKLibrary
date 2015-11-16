//
//  FKPopView.m
//  FKLibraryExample
//
//  Created by frank on 15/11/11.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "FKPopView.h"
#import "UIView+FK.h"

static CGFloat const defaultBorder = 20;
/** 按钮与容器尖角的偏移值 */
static CGFloat btnOffectWithSuperView = 10;

@interface FKPopView ()
/** 最底部的遮盖 ：屏蔽除菜单以外控件的事件 */
@property (nonatomic, weak) UIButton *coverBtn;
@property (nonatomic, weak) UIImageView *containerView;
@property (nonatomic, weak) UIButton *firstBtn;
@property (nonatomic, weak) UIButton *secondBtn;
@property (nonatomic, weak) UIView *firstLine;
@property (nonatomic, assign, getter=isArrowUp) BOOL arrowUp;
@end

@implementation FKPopView


+ (instancetype)popView
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
        
        // 创建屏蔽事件的遮盖按钮
        UIButton *coverBtn = [[UIButton alloc] init];
        coverBtn.backgroundColor = [UIColor clearColor];
        [coverBtn addTarget:self action:@selector(coverBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:coverBtn];
        self.coverBtn = coverBtn;
        
        // 创建容器view
        UIImageView *containerView = [[UIImageView alloc] init];
        containerView.userInteractionEnabled = YES;
        containerView.layer.masksToBounds = YES;
        [self addSubview:containerView];
        self.containerView = containerView;
        
        // 创建第一个按钮
        UIButton *firstBtn = [[UIButton alloc] init];
        [firstBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        firstBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        firstBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        firstBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        [firstBtn addTarget:self action:@selector(firstBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.containerView addSubview:firstBtn];
        self.firstBtn = firstBtn;
        
        // 中间的横线
        UIView *firstLine = [[UIView alloc] init];
        firstLine.backgroundColor = [UIColor lightGrayColor];
        [self.containerView addSubview:firstLine];
        self.firstLine = firstLine;
        
        // 创建第二个按钮
        UIButton *secondBtn = [[UIButton alloc] init];
        [secondBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        secondBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        secondBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        secondBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        [secondBtn addTarget:self action:@selector(secondBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.containerView addSubview:secondBtn];
        self.secondBtn = secondBtn;
    }
    return self;
}


- (void)setImages:(NSArray<NSString *> *)images titles:(NSArray<NSString *> *)titles
{
    static CGFloat const btnH = 40;
    CGFloat btnW = [UIScreen mainScreen].bounds.size.width - defaultBorder * 2;
    if (images.count > 0) {
        [self.firstBtn setImage:[UIImage imageNamed:images[0]] forState:UIControlStateNormal];
        [self.firstBtn setTitle:titles[0] forState:UIControlStateNormal];
        self.firstBtn.frame = CGRectMake(0, btnOffectWithSuperView, btnW, btnH);
        self.containerView.frame = CGRectMake(defaultBorder, 0, btnW, self.firstBtn.fk_bottom);
    }
    if (images.count > 1) {
        self.firstLine.frame = CGRectMake(defaultBorder, CGRectGetMaxY(self.firstBtn.frame), self.firstBtn.fk_width - 2 * defaultBorder, 1);
        [self.secondBtn setImage:[UIImage imageNamed:images[1]] forState:UIControlStateNormal];
        [self.secondBtn setTitle:titles[1] forState:UIControlStateNormal];
        self.secondBtn.frame = CGRectMake(0, CGRectGetMaxY(self.firstLine.frame), self.firstBtn.fk_width, btnH);
        self.containerView.frame = CGRectMake(defaultBorder, 0, btnW, self.secondBtn.fk_bottom);
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.coverBtn.frame = self.frame;
}

- (void)coverBtnClicked:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(coverBtnDelegate:button:)]) {
        [self.delegate coverBtnDelegate:self button:button];
    }
}

- (void)firstBtnClicked:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(firstBtnDelegate:button:)]) {
        [self.delegate firstBtnDelegate:self button:button];
    }
}
- (void)secondBtnClicked:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(secondBtnDelegate:button:)]) {
        [self.delegate secondBtnDelegate:self button:button];
    }
}

- (void)showWithPoint:(CGPoint)point
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    self.frame = window.bounds;
    [window addSubview:self];
    
    // 设置遮盖的frame
    self.coverBtn.frame = self.frame;
    
    // 设置容器的frame
    // 判断箭头是否朝上
    self.arrowUp = point.y + self.containerView.fk_height > window.bounds.size.height;
    if (self.isArrowUp) {
        self.containerView.fk_bottom = point.y;
        self.containerView.image = [UIImage imageNamed:@"share_more_pop_down_box"];
        // 内部控件的Y值上移
        self.firstBtn.fk_top = self.firstBtn.fk_top - btnOffectWithSuperView;
        self.firstLine.fk_top = self.firstLine.fk_top - btnOffectWithSuperView;
        self.secondBtn.fk_top = self.secondBtn.fk_top - btnOffectWithSuperView;
    } else {
        self.containerView.fk_top = point.y;
        self.containerView.image = [UIImage imageNamed:@"share_more_pop_up_box"];
    }
    // 等有时间了再用quartzcore画一遍
//    [self.containerView.image setSharpCornerChatWithPoint:point];
}

- (void)dismiss
{
    // 先通知外面
    if ([self.delegate respondsToSelector:@selector(popViewDismissed:)]) {
        [self.delegate popViewDismissed:self];
    }
    // 然后再销毁自己
    [self removeFromSuperview];
}

@end
