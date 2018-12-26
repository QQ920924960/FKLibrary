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
@property(nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, copy) NSString *payMethodName;

@end

@implementation FKPayMethodView

- (NSArray *)datas
{
    if (!_datas) {
        _datas = @[@{@"title" : @"余额支付", @"icon" : @"flowers_pay_balance"},
                   @{@"title" : @"微信支付", @"icon" : @"flowers_pay_wx"},
                   @{@"title" : @"支付宝支付", @"icon" : @"flowers_pay_zfb"}];
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
    CGFloat containerH = 44 + margin + 45 * 3 + margin + 40 + margin + fkOffsetBottom;
//    CGFloat containerY = fkScreenH - containerH;
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, fkScreenH, fkScreenW, containerH)];
    container.backgroundColor = [UIColor whiteColor];
    [self addSubview:container];
    self.container = container;
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fkScreenW, 44)];
    [container addSubview:header];
    
    UIButton *closeBtn = [UIButton fk_btnWithTarget:self action:@selector(closeBtnClicked) img:[UIImage imageNamed:@"flowers_pay_close"] selectedImg:nil];
    [header addSubview:closeBtn];
    
    UILabel *titleLabel = [UILabel fk_labelWithFont:fk_adjustFont(16) textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter text:@"选择支付方式"];
    [header addSubview:titleLabel];
    
    UIView *separator = [UIView fk_lineWithFrame:CGRectMake(0, 44 - 0.8, fkScreenW, 0.8)];
    [header addSubview:separator];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, header.fk_bottom + margin, fkScreenW, 135)];
    [container addSubview:tableView];
    self.tableView = tableView;
    tableView.scrollEnabled = NO;
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    tableView.dataSource = self;
    tableView.delegate = self;
    
    UIButton *payBtn = [UIButton fk_btnWithTarget:self action:@selector(payBtnClicked) font:fk_adjustFont(16) normalTitle:@"立即支付" normalTitleColor:[UIColor whiteColor] selectedTitle:nil selectedTitleColor:nil normalImg:nil selectedImg:nil bgImg:[UIImage fk_imageWithColor:fkMainColor] selectedBgImg:nil];
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
    [self dismiss];
}

-(void)payBtnClicked
{
    if (self.selectePayMethodBlock) {
        self.selectePayMethodBlock(self.payMethodName);
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
//    cell.model = self.datas[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.datas[indexPath.row];
    self.payMethodName = dict[@"title"];
}


@end
