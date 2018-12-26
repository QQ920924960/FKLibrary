//
//  FKPayMethodCell.m
//  FKLibraryExample
//
//  Created by frank on 2018/10/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FKPayMethodCell.h"

@interface FKPayMethodCell ()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *checkView;

@end

@implementation FKPayMethodCell

- (void)setupSubviews
{
    [super setupSubviews];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconView];
    self.iconView = iconView;
    
    UILabel *titleLabel = [UILabel fk_labelWithFont:fk_adjustFont(14) textColor:fkColor333333];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIImageView *checkView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flowers_pay_check_normal"]];
    checkView.highlightedImage = [UIImage imageNamed:@"flowers_pay_check_selected"];
    [self.contentView addSubview:checkView];
    self.checkView = checkView;
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.mas_equalTo(15.0);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(iconView.mas_right).offset(10);
    }];
    [checkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.mas_equalTo(-15.0);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.checkView.highlighted = selected;
}

- (void)setModel:(id)model
{
    if ([model isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = model;
        self.iconView.image = [UIImage imageNamed:dict[@"icon"]];
        self.titleLabel.text = dict[@"title"];
    }
}

@end
