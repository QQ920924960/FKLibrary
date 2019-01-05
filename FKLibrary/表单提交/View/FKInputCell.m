//
//  FKInputCell.m
//  BaiYeMallShop
//
//  Created by frank on 2018/11/27.
//  Copyright © 2018 凯叔叔. All rights reserved.
//

#import "FKInputCell.h"

@interface FKInputCell ()<UITextFieldDelegate>

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UITextField *valueField;
@property (nonatomic, weak) UIButton *getCodeBtn;

@end

@implementation FKInputCell

- (void)setupSubviews
{
    [super setupSubviews];
    
    UILabel *titleLabel = [UILabel fk_labelWithFont:fk_adjustFont(14) textColor:fkColor333333];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UITextField *valueField = [[UITextField alloc] init];
    [self.contentView addSubview:valueField];
    self.valueField = valueField;
    valueField.font = fk_adjustFont(14);
    valueField.delegate = self;
    [valueField addTarget:self action:@selector(valueFieldEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    UIButton *getCodeBtn = [UIButton fk_btnWithTarget:self action:@selector(getCodeBtnClicked:) font:fk_adjustFont(14) normalTitle:@"获取动态验证码" normalTitleColor:fkMainColor selectedTitle:nil selectedTitleColor:nil normalImg:nil selectedImg:nil bgImg:nil selectedBgImg:nil];
    [self.contentView addSubview:getCodeBtn];
    self.getCodeBtn = getCodeBtn;
    getCodeBtn.hidden = true;
    
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(12);
//        make.centerY.equalTo(self);
//    }];
    [valueField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(titleLabel.mas_right).offset(10);
//        make.right.lessThanOrEqualTo(self).offset(-12);
        make.right.offset(-12);
    }];
    [getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.offset(-12);
    }];
}

- (void)valueFieldEndEditing:(UITextField *)field
{
    self.item[@"value"] = field.text;
}

- (void)getCodeBtnClicked:(UIButton *)btn
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sendCodeNoti" object:btn userInfo:nil];
}

- (void)dealloc
{
    FKLog(@"----------cell成功销毁了---------");
}

- (void)setItem:(NSMutableDictionary *)item
{
    [super setItem:item];
    
    self.titleLabel.text = item[@"title"];
    // 计算title的frame
    CGFloat titleW = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}].width + 2;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.centerY.offset(0);
        make.width.mas_equalTo(titleW);
    }];
    
    self.valueField.text = item[@"value"];
    self.valueField.placeholder = item[@"placeholder"];
    self.valueField.keyboardType = [item[@"keyboardType"] integerValue];
    self.valueField.enabled = ![item[@"disabled"] boolValue];
    self.getCodeBtn.hidden = ![item[@"showCodeBtn"] boolValue];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *result = [textField.text stringByAppendingString:string];
    // 可供输入的字符的长度
    if (self.item[@"valueLength"]) { // 如果设置了这个值
        NSInteger maxLength = [self.item[@"valueLength"] integerValue];
        if (result.length > maxLength) {
            return false;
        }
    }
    return true;
}

@end
