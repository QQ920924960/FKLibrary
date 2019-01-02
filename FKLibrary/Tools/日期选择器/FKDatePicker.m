//
//  FKDatePicker.m
//  Festival
//
//  Created by Macbook Pro on 2018/10/11.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FKDatePicker.h"

@interface FKDatePicker ()

@property (nonatomic, weak) UIView *container;
@property (nonatomic, weak) UIDatePicker *picker;

@end

@implementation FKDatePicker

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
//    UIView *coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    [self addSubview:coverView];
//    coverView.backgroundColor = kColorAlpha(0, 0, 0, 0.5);
    
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, fkScreenH - 120, fkScreenW, 60)];
    [self addSubview:container];
    self.container = container;
    container.backgroundColor = [UIColor whiteColor];
    container.clipsToBounds = true;
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, fkScreenW, 40)];
    [container addSubview:toolbar];
    toolbar.backgroundColor = fkMainColor;
    toolbar.tintColor = [UIColor whiteColor];
    toolbar.barTintColor = fkMainColor;
    
    UIBarButtonItem *cancel = [UIBarButtonItem fk_itemWithTarget:self action:@selector(cancelBtnClicked) text:@"取消" textColor:[UIColor whiteColor] font:fkFont14];
    UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *titleItem = [[UIBarButtonItem alloc] initWithTitle:@"选择时间" style:0 target:nil action:nil];
    UIBarButtonItem *rightSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *confirm = [UIBarButtonItem fk_itemWithTarget:self action:@selector(confirmBtnClicked) text:@"确定" textColor:[UIColor whiteColor] font:fkFont14];
    toolbar.items = @[cancel, leftSpace, titleItem, rightSpace, confirm];
    
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    [container addSubview:picker];
    self.picker = picker;
    picker.datePickerMode = UIDatePickerModeDate;
    picker.date = [NSDate date];
    // 设置为中文
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    picker.locale = locale;
    
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(container);
        make.top.equalTo(toolbar.mas_bottom);
    }];
}

- (void)cancelBtnClicked
{
    [self dismiss];
}

- (void)confirmBtnClicked
{
    [self dismiss];
    
}

- (void)showWithSuperView:(UIView *)view
{
    self.frame = [UIScreen mainScreen].bounds;
    if (view) {
        [view.window addSubview:self];
    } else {
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        [window addSubview:self];
    }
    fkWeakSelf(self);
    CGFloat containerH = 40 + self.picker.fk_height;
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8f initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [weakself setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f]];
        self.container.frame = CGRectMake(0, fkScreenH - containerH, fkScreenW, containerH);
    } completion:nil];
}

- (void)show
{
    [self showWithSuperView:nil];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8f initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [self setAlpha:0];
        self.container.frame = CGRectMake(0, fkScreenH - 120, fkScreenW, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
