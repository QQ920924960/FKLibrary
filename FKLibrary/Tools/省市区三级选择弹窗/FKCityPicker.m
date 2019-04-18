//
//  FKCityPicker.m
//  HappyTest
//
//  Created by Macbook Pro on 2019/1/11.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

#import "FKCityPicker.h"

@interface FKCityPicker ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) UIView *container;
@property (nonatomic, weak) UIPickerView *picker;

@property (nonatomic, strong) NSArray *provinces;
@property (nonatomic, strong) NSArray *cities;
@property (nonatomic, strong) NSArray *areas;

@end

@implementation FKCityPicker

- (NSArray *)provinces
{
    if (!_provinces) {
        _provinces = [NSArray array];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"province_city_area.json" ofType:nil];
        NSData *cacheData = [NSData dataWithContentsOfFile:path];
        _provinces = [cacheData mj_JSONObject];
    }
    return _provinces;
}

- (NSArray *)cities
{
    if (!_cities) {
        _cities = [NSArray array];
    }
    return _cities;
}

- (NSArray *)areas
{
    if (!_areas) {
        _areas = [NSArray array];
    }
    return _areas;
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
    //    UIView *coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //    [self addSubview:coverView];
    //    coverView.backgroundColor = kColorAlpha(0, 0, 0, 0.5);
    
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, fkScreenH - 120, fkScreenW, 0)];
    [self addSubview:container];
    self.container = container;
    container.backgroundColor = [UIColor whiteColor];
    container.clipsToBounds = true;
    
    CGFloat toolbarH = 44;
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, fkScreenW, toolbarH)];
    [container addSubview:toolbar];
    toolbar.barTintColor = [UIColor fk_colorWithHex:0xf2f2f2];
    toolbar.tintColor = [UIColor whiteColor];
//    toolbar.barTintColor = fkMainColor;
    
    UIBarButtonItem *cancel = [UIBarButtonItem fk_itemWithTarget:self action:@selector(cancelBtnClicked) text:@"取消" textColor:fkColor666666 font:fkFont14];
    UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *titleItem = [[UIBarButtonItem alloc] initWithTitle:@"选择所在城市" style:0 target:nil action:nil];
    titleItem.tintColor = fkColor333333;
    UIBarButtonItem *rightSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *confirm = [UIBarButtonItem fk_itemWithTarget:self action:@selector(confirmBtnClicked) text:@"确定" textColor:fkMainColor font:fkFont14];
    toolbar.items = @[cancel, leftSpace, titleItem, rightSpace, confirm];
    
    UIPickerView *picker = [[UIPickerView alloc] init];
    [container addSubview:picker];
    self.picker = picker;
    picker.delegate = self;
    picker.tintColor = fkMainColor;
    picker.frame = CGRectMake(0, toolbarH, fkScreenW, picker.fk_height);
    
    CGFloat containerH = toolbarH + picker.fk_height;
    CGFloat containerY = fkScreenH - containerH;
    container.frame = CGRectMake(0, containerY, fkScreenW, containerH);
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.provinces.count;
    } else if (component == 1) {
        return self.cities.count;
    } else if (component == 2) {
        return self.areas.count;
    }
    return 0;
}

#pragma mark - UIPickerViewDelegate
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    if (component == 0) {
//        NSDictionary *dict = self.provinces[row];
//        return dict[@"label"];
//    } else if (component == 1) {
//        NSDictionary *dict = self.cities[row];
//        return dict[@"label"];
//    } else if (component == 2) {
//        NSDictionary *dict = self.areas[row];
//        return dict[@"label"];
//    }
//    return nil;
//}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel*)view;
    if (!pickerLabel) {
        pickerLabel = [UILabel fk_labelWithFont:fk_adjustFont(14) textColor:fkColor333333 textAlignment:NSTextAlignmentCenter];
    }
    NSDictionary *dict;
    if (component == 0) {
        dict = self.provinces[row];
    } else if (component == 1) {
        dict = self.cities[row];
    } else if (component == 2) {
        dict = self.areas[row];
    }
    pickerLabel.text = dict[@"label"];
    
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    UILabel *labelSelected = (UILabel*)[pickerView viewForRow:row forComponent:component];
    [labelSelected setTextColor:fkMainColor];
    
    if (component == 0) {
        NSDictionary *province = self.provinces[row];
        NSArray *cities = province[@"children"];
        if (cities > 0) {
            self.cities = cities;
            [pickerView reloadComponent:1];
            [self pickerView:pickerView didSelectRow:0 inComponent:1];
        }
    } else if (component == 1) {
        NSDictionary *city = self.cities[row];
        NSArray *areas = city[@"children"];
        if (areas.count > 0) {
            self.areas = areas;
            [pickerView reloadComponent:2];
            [self pickerView:pickerView didSelectRow:0 inComponent:2];
        }
    } else if (component == 2) {
        
    }
}


- (void)cancelBtnClicked
{
    [self dismiss];
}

- (void)confirmBtnClicked
{
    NSInteger provinceRow = [self.picker selectedRowInComponent:0];
    NSDictionary *province = self.provinces[provinceRow];
    NSInteger cityRow = [self.picker selectedRowInComponent:1];
    NSDictionary *city = self.cities[cityRow];
    NSInteger areaRow = [self.picker selectedRowInComponent:2];
    NSDictionary *area = self.areas[areaRow];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"province"] = province[@"label"];
    dict[@"city"] = city[@"label"];
    dict[@"area"] = area[@"label"];
    if (self.selectedCityBlock) {
        self.selectedCityBlock(dict);
    }
    [self dismiss];
}

- (BOOL)anySubViewScrolling:(UIView *)view
{
    if ([view isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)view;
        if (scrollView.dragging || scrollView.decelerating) {
            return YES;
        }
    }
    for (UIView *theSubView in view.subviews) {
        if ([self anySubViewScrolling:theSubView]) {
            return YES;
        }
    }
    return NO;
}


- (void)showWithSuperView:(UIView *)view
{
    if (self.provinces.count > 0) {
        [self pickerView:self.picker didSelectRow:0 inComponent:0];
    }
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
