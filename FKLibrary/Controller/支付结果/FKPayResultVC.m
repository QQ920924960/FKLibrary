//
//  FKPayResultVC.m
//  HappyTest
//
//  Created by Macbook Pro on 2019/2/19.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

#import "FKPayResultVC.h"

@interface FKPayResultVC ()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIButton *leftBtn;
@property (nonatomic, weak) UIButton *rightBtn;

@end

@implementation FKPayResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.isFailure ? @"支付失败" : @"支付成功";
    
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.view addSubview:iconView];
    self.iconView = iconView;
    
    UILabel *titleLabel = [UILabel fk_labelWithFont:fk_adjustFont(17) textColor:fkColor333333];
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIButton *leftBtn = [UIButton fk_btnWithTarget:self action:@selector(leftBtnClicked:) font:fk_adjustFont(14) normalTitle:nil normalTitleColor:fkPriceRed selectedTitle:nil selectedTitleColor:nil normalImg:nil selectedImg:nil bgImg:[UIImage imageNamed:@"bg_white"] selectedBgImg:nil];
    [self.view addSubview:leftBtn];
    self.leftBtn = leftBtn;
    [leftBtn fk_viewCornerRadius:fk_adjustW(17) borderWidth:0.8 borderColor:fkMainColor];
    
    UIButton *rightBtn = [UIButton fk_btnWithTarget:self action:@selector(rightBtnClicked:) font:fk_adjustFont(14) normalTitle:nil normalTitleColor:fkColor666666 selectedTitle:nil selectedTitleColor:nil normalImg:nil selectedImg:nil bgImg:[UIImage imageNamed:@"bg_white"] selectedBgImg:nil];
    [self.view addSubview:rightBtn];
    self.rightBtn = rightBtn;
    [rightBtn fk_viewCornerRadius:fk_adjustW(17) borderWidth:0.8 borderColor:fkColor666666];
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(fk_adjustW(60));
        make.top.offset(fk_adjustW(40));
        make.centerX.offset(0);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconView.mas_bottom).offset(fk_adjustW(15));
        make.centerX.offset(0);
    }];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(fk_adjustW(112));
        make.height.offset(fk_adjustW(34));
        make.left.offset(fk_adjustW(32));
        make.top.equalTo(titleLabel.mas_bottom).offset(fk_adjustW(44));
    }];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.top.equalTo(leftBtn);
        make.right.offset(fk_adjustW(-32));
    }];
    
    if (self.isFailure) {
        iconView.image = [UIImage imageNamed:@"fk_pay_failure"];
        titleLabel.text = @"支付失败";
        [leftBtn setTitle:@"重新支付" forState:UIControlStateNormal];
        [rightBtn setTitle:@"返回首页" forState:UIControlStateNormal];
        
    } else {
        iconView.image = [UIImage imageNamed:@"fk_pay_successful"];
        titleLabel.text = @"支付成功";
        [leftBtn setTitle:@"查看订单" forState:UIControlStateNormal];
        [rightBtn setTitle:@"返回首页" forState:UIControlStateNormal];
    }
}

- (void)leftBtnClicked:(UIButton *)btn
{
    
}

- (void)rightBtnClicked:(UIButton *)btn
{
    
}


@end
