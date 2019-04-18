//
//  FKGradientNav.m
//  HappyTest
//
//  Created by Macbook Pro on 2019/2/15.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

#import "FKGradientNav.h"

@interface FKGradientNav ()

@property (nonatomic, weak) UIButton *leftItem;
@property (nonatomic, weak) UIButton *rightItem;
@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation FKGradientNav

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    // 自定义导航栏
    self.backgroundColor = fkColorAlpha(255, 255, 255, 0);
    
    UIView *navContainer = [[UIView alloc] initWithFrame:CGRectMake(0, fkStatusBarH, fkScreenW, fkNavBarH)];
    [self addSubview:navContainer];
    
    UIButton *leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [navContainer addSubview:leftItem];
    self.leftItem = leftItem;
    CGFloat itemWH = 36;
    CGFloat backBtnY = (fkNavBarH - itemWH) * 0.5;
    leftItem.frame = CGRectMake(12, backBtnY, itemWH, itemWH);
    
    UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [navContainer addSubview:rightItem];
    self.rightItem = rightItem;
    CGFloat rightItemX = fkScreenW - 12 - itemWH;
    rightItem.frame = CGRectMake(rightItemX, backBtnY, itemWH, itemWH);
    
    UILabel *titleLabel = [UILabel fk_labelWithFont:[UIFont systemFontOfSize:16] textColor:fkColor333333 textAlignment:NSTextAlignmentCenter];
    [navContainer addSubview:titleLabel];
    self.titleLabel = titleLabel;
    titleLabel.alpha = 0;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(navContainer);
    }];
}

- (void)setRatio:(CGFloat)ratio
{
    _ratio = ratio;
    
    self.backgroundColor = fkColorAlpha(255, 255, 255, ratio);
    self.titleLabel.alpha = ratio;
    if (ratio == 1) {
        if (self.leftEndImg) [self.leftItem setImage:[UIImage imageNamed:self.leftEndImg] forState:UIControlStateNormal];
        if (self.rightEndImg) [self.rightItem setImage:[UIImage imageNamed:self.rightEndImg] forState:UIControlStateNormal];
    } else {
        if (self.leftBeginImg) [self.leftItem setImage:[UIImage imageNamed:self.leftBeginImg] forState:UIControlStateNormal];
        if (self.rightBeginImg) [self.rightItem setImage:[UIImage imageNamed:self.rightBeginImg] forState:UIControlStateNormal];
    }
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)setLeftBeginImg:(NSString *)leftBeginImg
{
    _leftBeginImg = leftBeginImg;
    
    [self.leftItem setImage:[UIImage imageNamed:leftBeginImg] forState:UIControlStateNormal];
}

- (void)setRightBeginImg:(NSString *)rightBeginImg
{
    _rightBeginImg = rightBeginImg;
    
    [self.rightItem setImage:[UIImage imageNamed:rightBeginImg] forState:UIControlStateNormal];
}

- (void)fk_leftItemAddTarget:(id)target action:(SEL)action
{
    [self.leftItem addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)fk_rightItemAddTarget:(id)target action:(SEL)action
{
    [self.rightItem addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end
