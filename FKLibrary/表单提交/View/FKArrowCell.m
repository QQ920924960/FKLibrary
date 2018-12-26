//
//  FKArrowCell.m
//  BaiYeMallShop
//
//  Created by frank on 2018/11/27.
//  Copyright © 2018 凯叔叔. All rights reserved.
//

#import "FKArrowCell.h"

@interface FKArrowCell ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UITextField *valueField;

@end

@implementation FKArrowCell

- (void)setupSubviews
{
    [super setupSubviews];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleGray;
    
    UILabel *titleLabel = [UILabel fk_labelWithFont:fkFont14 textColor:fkColor333333];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UITextField *valueField = [[UITextField alloc] init];
    [self.contentView addSubview:valueField];
    self.valueField = valueField;
    valueField.textAlignment = NSTextAlignmentRight;
    valueField.font = fk_adjustFont(14);
    valueField.enabled = false;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.centerY.equalTo(self);
    }];
    [valueField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-32);
        make.centerY.equalTo(self);
        make.left.mas_greaterThanOrEqualTo(titleLabel.mas_right).offset(10);
    }];
}

- (void)setItem:(NSMutableDictionary *)item
{
    [super setItem:item];
    
    self.titleLabel.text = item[@"title"];
    self.valueField.text = item[@"value"];
    self.valueField.placeholder = item[@"placeholder"];
}

@end
