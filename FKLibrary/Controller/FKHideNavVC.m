//
//  FKHideNavVC.m
//  TimesCloud
//
//  Created by frank on 2018/11/7.
//  Copyright © 2018年 mfwlzlg. All rights reserved.
//

#import "FKHideNavVC.h"

@interface FKHideNavVC ()<UINavigationControllerDelegate>

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIButton *rightItem;

@end

@implementation FKHideNavVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self setupNav];
    
    if (self.isNeedRemoveBeforeVc) {
        [self fk_removeBeforeVC];
    }
}

- (void)setupNav
{
    [self setupNav:nil];
}

- (void)setupNav:(NSString *)leftItemImgName
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fkScreenW, fkOffsetTop + fkStatusAndNaBarH)];
    [self.view addSubview:topView];
    topView.layer.zPosition = MAXFLOAT;
    
    CGFloat navY = [UIApplication sharedApplication].statusBarFrame.size.height;
    UIView *navBar = [[UIView alloc] initWithFrame:CGRectMake(0, navY, fkScreenW, fkNavBarH)];
    [topView addSubview:navBar];
    
    UIButton *backBtn = [UIButton fk_btnWithTarget:self action:@selector(back) img:[UIImage imageNamed:leftItemImgName ? : @"icon_white_back"]];
    [navBar addSubview:backBtn];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    // 根据研究，左边的间距为20
    backBtn.frame = CGRectMake(20, 0, fkNavBarH, fkNavBarH);
//    backBtn.backgroundColor = [UIColor redColor];
    
    UILabel *titleLabel = [UILabel fk_labelWithFont:fk_adjustFont(18) textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    [navBar addSubview:titleLabel];
    self.titleLabel = titleLabel;
    self.titleLabel.text = self.title;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(navBar);
    }];
    
    UIButton *rightItem = [UIButton fk_btnWithTarget:self action:@selector(rightItemClicked) img:self.rightImgName ? [UIImage imageNamed:self.rightImgName] : nil];
    [navBar addSubview:rightItem];
    self.rightItem = rightItem;
    rightItem.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    // 根据研究，左边的间距为20
    rightItem.frame = CGRectMake(fkScreenW - 20 - fkNavBarH, 0, fkNavBarH, fkNavBarH);
}

- (void)back
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:true];
    }
}

- (void)rightItemClicked
{
    
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];

    if (self.titleLabel) {
        self.titleLabel.text = title;
    }
}

- (void)setRightImgName:(NSString *)rightImgName
{
    _rightImgName = rightImgName;
    
    if (self.rightItem) {
        [self.rightItem setImage:[UIImage imageNamed:rightImgName] forState:UIControlStateNormal];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
//    self.navigationController.navigationBar.hidden = false;
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:[viewController isKindOfClass:[self class]] animated:YES];
}

- (void)dealloc {
    self.navigationController.delegate = nil;
}

@end
