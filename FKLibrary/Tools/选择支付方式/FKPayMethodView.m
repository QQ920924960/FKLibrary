//
//  FKPayMethodView.m
//  FKLibraryExample
//
//  Created by frank on 2018/10/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FKPayMethodView.h"
#import "FKPayMethodCell.h"

@interface FKPayMethodView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UIView *container;
@property (nonatomic, weak) UILabel *amountLabel;
@property(nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, copy) NSString *payMethodName;
@property (nonatomic, copy) NSString *payType;

@end

@implementation FKPayMethodView

- (NSArray *)datas
{
    if (!_datas) {
        _datas = @[
                   //                   @{@"title" : @"余额支付", @"icon" : @"fk_payment_balance"},
                   @{@"title" : @"微信支付", @"icon" : @"fk_payment_wechat", @"type" : @"1"},
                   @{@"title" : @"支付宝支付", @"icon" : @"fk_payment_alipay", @"type" : @"2"}];
    }
    return _datas;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    self.backgroundColor = [UIColor clearColor];
    
    CGFloat margin = 20;
    CGFloat amountViewH = fk_adjustW(120);
    CGFloat tableH = 45 * (self.datas.count);
    //    CGFloat containerH = 44 + margin + 45 * 3 + margin + 40 + margin + fkOffsetBottom;
    CGFloat containerH = 44 + amountViewH + tableH + margin + 40 + margin + fkOffsetBottom;
    //    CGFloat containerY = fkScreenH - containerH;
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, fkScreenH, fkScreenW, containerH)];
    container.backgroundColor = [UIColor whiteColor];
    [self addSubview:container];
    self.container = container;
    
    // 头部
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fkScreenW, 44)];
    [container addSubview:header];
    
    UIButton *closeBtn = [UIButton fk_btnWithTarget:self action:@selector(closeBtnClicked) img:[UIImage imageNamed:@"dissmiss"]];
    [header addSubview:closeBtn];
    
    UILabel *titleLabel = [UILabel fk_labelWithFont:fk_adjustFont(16) textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter text:@"支付方式"];
    [header addSubview:titleLabel];
    
    UIView *separator = [UIView fk_lineWithFrame:CGRectMake(0, 44 - 0.8, fkScreenW, 0.8)];
    [header addSubview:separator];
    
    // 金额栏
    UIView *amountView = [[UIView alloc] initWithFrame:CGRectMake(0, header.fk_bottom, fkScreenW, amountViewH)];
    [container addSubview:amountView];
    
    UILabel *amountTitleLabel = [UILabel fk_labelWithFont:fk_adjustFont(13) textColor:fkColor666666 textAlignment:NSTextAlignmentCenter text:@"支付金额"];
    [amountView addSubview:amountTitleLabel];
    
    UILabel *amountLabel = [UILabel fk_labelWithFont:fk_adjustFont(30) textColor:[UIColor orangeColor] textAlignment:NSTextAlignmentCenter];
    [amountView addSubview:amountLabel];
    self.amountLabel = amountLabel;
    
    UIView *separator2 = [UIView fk_lineWithFrame:CGRectMake(0, amountViewH - 0.8, fkScreenW, 0.8)];
    [amountView addSubview:separator2];
    
    // tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, amountView.fk_bottom, fkScreenW, tableH)];
    [container addSubview:tableView];
    self.tableView = tableView;
    tableView.scrollEnabled = NO;
    //    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    tableView.dataSource = self;
    tableView.delegate = self;
    
    UIButton *payBtn = [UIButton fk_btnWithTarget:self action:@selector(payBtnClicked) font:fk_adjustFont(16) normalTitle:@"确认支付" normalTitleColor:[UIColor whiteColor] selectedTitle:nil selectedTitleColor:nil normalImg:nil selectedImg:nil bgImg:[UIImage fk_imageWithColor:fkMainColor] selectedBgImg:nil];
    [container addSubview:payBtn];
    [payBtn fk_viewCornerRadius:20 borderWidth:0 borderColor:nil];
    
    
    // 设置frame
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(header);
        make.left.equalTo(header).offset(15);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(header);
    }];
    [amountTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(fk_adjustW(26));
        make.centerX.offset(0);
    }];
    [amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(amountTitleLabel.mas_bottom).offset(fk_adjustW(15));
        make.centerX.equalTo(amountTitleLabel);
    }];
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tableView.mas_bottom).offset(margin);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(fkScreenW - 30);
        make.centerX.equalTo(container);
    }];
    
    [tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self tableView:tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
}

- (void)closeBtnClicked
{
    if (self.closeBlock) self.closeBlock();
    [self dismiss];
}

-(void)payBtnClicked
{
    if (self.selectePayMethodBlock) {
        self.selectePayMethodBlock(self.payType);
    }
    [self dismiss];
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:self];
    self.frame = [UIScreen mainScreen].bounds;
    
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.container.fk_top = fkScreenH - self.container.fk_height;
        self.backgroundColor = fkColorAlpha(0, 0, 0, 0.5);
    } completion:^(BOOL finished) {
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        self.container.fk_top = fkScreenH;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.datas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FKPayMethodCell *cell = [FKPayMethodCell cellWith:tableView];
    cell.model = self.datas[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.datas[indexPath.row];
    self.payMethodName = dict[@"title"];
    self.payType = dict[@"type"];
}

- (void)setAmount:(NSString *)amount
{
    _amount = amount;
    
    self.amountLabel.text = fkFORMAT(@"%@元", amount);
}


@end
