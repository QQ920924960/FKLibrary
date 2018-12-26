//
//  FKPayTypeVC.m
//  inspectVehicle
//
//  Created by frank on 2018/12/14.
//  Copyright © 2018 胡俊杰. All rights reserved.
//

#import "FKPayTypeVC.h"
#import "FKPayTypeRowCell.h"

@interface FKPayTypeVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UIView *container;
@property (nonatomic, strong) NSArray *datas;

@end

@implementation FKPayTypeVC

- (NSArray *)datas
{
    if (!_datas) {
        _datas = @[@{@"icon" : @"paytype_alipay", @"title" : @"支付宝支付", @"type" : @"alipay"},
                   @{@"icon" : @"paytype_wechat", @"title" : @"微信支付", @"type" : @"wechat"},
                   @{@"icon" : @"paytype_amount", @"title" : @"账户余额支付", @"type" : @"account"}];
    }
    return _datas;
}

- (instancetype)init
{
    FKPayTypeVC *vc = [super init];
    // 防止presentViewController过后控制器的view的背景色变成黑色
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UIView *bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:bgView];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    UIView *container = [[UIView alloc] init];
    [self.view addSubview:container];
    self.container = container;
    container.backgroundColor = [UIColor whiteColor];
    
    CGFloat topViewH = 44;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fkScreenW, topViewH)];
    [container addSubview:topView];
    
    UIButton *closeBtn = [UIButton fk_btnWithTarget:self action:@selector(close) img:[UIImage imageNamed:@"me_close"]];
    [topView addSubview:closeBtn];
    closeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    CGFloat closeH = 36;
    CGFloat closeY = (topViewH - closeH) * 0.5;
    closeBtn.frame = CGRectMake(12, closeY, closeH, closeH);
    
    UILabel *titleLabel = [UILabel fk_labelWithFont:fk_adjustFont(14) textColor:fkColor333333 textAlignment:NSTextAlignmentCenter text:@"请选择支付方式"];
    [topView addSubview:titleLabel];
    titleLabel.frame = CGRectMake((fkScreenW - 160) * 0.5, 0, 160, topViewH);
    
    UIView *separator = [UIView fk_lineWithFrame:CGRectMake(0, topViewH - 0.8, fkScreenW, 0.8)];
    [topView addSubview:separator];
    
    CGFloat rowH = 45;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topView.fk_bottom, fkScreenW, self.datas.count * rowH) style:UITableViewStylePlain];
    [container addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.tableFooterView = [UIView new];
    tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    CGFloat containerH = topViewH + tableView.fk_height + 30 + fkOffsetBottom;
    container.frame = CGRectMake(0, fkScreenH, fkScreenW, containerH);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat containerH = self.container.fk_height;
        CGFloat containerY = fkScreenH - containerH;
        self.container.frame = CGRectMake(0, containerY, fkScreenW, containerH);
    }];
}

- (void)close
{
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat containerH = self.container.fk_height;
        self.container.frame = CGRectMake(0, fkScreenH, fkScreenW, containerH);
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:false completion:nil];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FKPayTypeRowCell *cell = [FKPayTypeRowCell cellWith:tableView];
    cell.dict = self.datas[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.datas[indexPath.row];
    if (self.selectedPayType) {
        self.selectedPayType(dict[@"type"]);
    }
    [self close];
}


@end
