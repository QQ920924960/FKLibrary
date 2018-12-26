//
//  FKPayPwdInputView.m
//  HHShopping
//
//  Created by frank on 2018/9/17.
//  Copyright © 2018年 嘉瑞科技有限公司 - 凯叔叔. All rights reserved.
//

#import "FKPayPwdInputView.h"


@interface FKPayPwdInputView()

@property(nonatomic, strong) NSMutableArray *nums;
@property(nonatomic, weak) UIView *container;
@property(nonatomic, weak) UIView *inputView;

@end

@implementation FKPayPwdInputView

+ (instancetype)payPwdInputViewWith:(UIViewController *)superVC
{
    FKPayPwdInputView *view = [[self alloc] init];
    view.superVC = superVC;
    return view;
}

- (NSMutableArray *)nums
{
    if (!_nums) {
        _nums = [NSMutableArray array];
    }
    return _nums;
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
    self.backgroundColor = fkColorAlpha(0, 0, 0, 0.5);
    
    UIView *container = [[UIView alloc] init];
    [self addSubview:container];
    self.container = container;
    container.backgroundColor = [UIColor whiteColor];
    
    UIButton *closeBtn = [UIButton fk_btnWithTarget:self action:@selector(closeBtnClicked) img:[UIImage imageNamed:@"dissmiss"] selectedImg:nil];
    [container addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.left.equalTo(container);
        make.top.equalTo(container);
    }];
    
    UILabel *titleLabel = [UILabel fk_labelWithFont:fk_adjustFont(16) textColor:fkColor333333 text:@"请输入支付密码"];
    [container addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(container);
        make.top.equalTo(container);
        make.height.mas_equalTo(44);
    }];
    
    UIView *separator = [UIView fk_lineWithFrame:CGRectMake(0, 44, fkScreenW, 0.8)];
    [container addSubview:separator];
    
    UIView *inputView = [[UIView alloc] init];
    [container addSubview:inputView];
    self.inputView = inputView;
    CGFloat inputViewH = 42;
    CGFloat inputViewW = fkScreenW - 30;
    inputView.frame = CGRectMake(15, separator.fk_bottom + 20, inputViewW, inputViewH);
    
    CGFloat fieldW = inputViewW / 6;
    for (NSInteger index = 0; index < 6; index++) {
        UITextField *field = [[UITextField alloc] init];
        [inputView addSubview:field];
        field.secureTextEntry = true;
        field.enabled = false;
        field.textAlignment = NSTextAlignmentCenter;
        [field fk_viewCornerRadius:0 borderWidth:0.5 borderColor:[UIColor blackColor]];
        
        CGFloat fieldX = index * (fieldW - 0.5);
        field.frame = CGRectMake(fieldX, 0, fieldW, inputViewH);
    }
    
    
    UIButton *forgetPwBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPwBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetPwBtn.titleLabel setFont:fk_adjustFont(15)];
    [forgetPwBtn setTitleColor:fkMainColor forState:UIControlStateNormal];
    [forgetPwBtn addTarget:self action:@selector(forgetPwBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:forgetPwBtn];
    CGFloat forgetW = [forgetPwBtn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : forgetPwBtn.titleLabel.font}].width + 20;
    CGFloat forgetX = fkScreenW - forgetW - 15;
    forgetPwBtn.frame = CGRectMake(forgetX, inputView.fk_bottom + 10, forgetW, 28);
    
    UIView *numView = [[UIView alloc] init];
    [container addSubview:numView];
    numView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    NSArray *titles = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"-", @"0", @""];
    NSInteger columns = 3;
    CGFloat numBtnH = 54;
    CGFloat numBtnW = (fkScreenW - 1) / columns;
    for (NSInteger index = 0; index < titles.count; index++) {
        NSString *title = titles[index];
        if ([title isEqualToString:@"-"]) continue;
        
        UIButton *numBtn = [UIButton fk_btnWithTarget:self action:@selector(numBtnClicked:) font:fk_adjustFont(18) normalTitle:title normalTitleColor:[UIColor blackColor] selectedTitle:nil selectedTitleColor:nil normalImg:nil selectedImg:nil bgImg:[UIImage fk_imageWithColor:[UIColor whiteColor]] selectedBgImg:nil];
        [numView addSubview:numBtn];
        if ([title isEqualToString:@""]) {
            [numBtn setImage:[UIImage imageNamed:@"backspace"] forState:UIControlStateNormal];
            [numBtn setBackgroundImage:[UIImage fk_imageWithColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1]] forState:UIControlStateNormal];
        }
        
        NSInteger row = index / columns;
        NSInteger column = index % columns;
        CGFloat numBtnX = column * (numBtnW + 0.5);
        CGFloat numBtnY = 0.5 + row * (numBtnH + 0.5);
        numBtn.frame = CGRectMake(numBtnX, numBtnY, numBtnW, numBtnH);
    }
    numView.frame = CGRectMake(0, forgetPwBtn.fk_bottom + 20, fkScreenW, (numBtnH + 0.5) * 4);
    
    CGFloat containerH = numView.fk_bottom + fkOffsetBottom;
    CGFloat containerY = fkScreenH - containerH;
    container.frame = CGRectMake(0, containerY, fkScreenW, containerH);
}


- (void)closeBtnClicked
{
    if (self.closeBlock) {
        self.closeBlock();
    }
    [self removeFromSuperview];
}

- (void)forgetPwBtnClicked
{
    // 忘记密码(找回支付密码)
    UIViewController *vc = [[UIViewController alloc]init];
    [self.superVC.navigationController pushViewController:vc animated:YES];

    [self removeFromSuperview];
}

- (void)dealloc
{
    NSLog(@"---输入支付密码界面销毁了---");
}

- (void)numBtnClicked:(UIButton *)btn
{
    if (!btn.titleLabel.text) { // 点击的是退格键
        if (self.nums.count > 0) {
            [self.nums removeLastObject];
        }
    } else { // 点击的是数字
        [self.nums addObject:btn.titleLabel.text];
        if (self.nums.count == 6) {
            if (self.inputFinishBlock) {
                NSString *pwd = [self.nums componentsJoinedByString:@""];
                self.inputFinishBlock(pwd);
                [self removeFromSuperview];
            }
        }
    }
    
    for (NSInteger index = 0; index < self.inputView.subviews.count; index++) {
        UITextField *field = self.inputView.subviews[index];
        if (index < self.nums.count) {
            field.text = self.nums[index];
        } else {
            field.text = nil;
        }
    }
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:self];
    self.frame = [UIScreen mainScreen].bounds;
    
    self.container.fk_top = fkScreenH;
    [UIView animateWithDuration:0.25 animations:^{
        self.container.fk_top = fkScreenH - self.container.fk_height;
    } completion:nil];
}

@end
