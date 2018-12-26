//
//  FKFormSectionView.m
//  BaiYeMallShop
//
//  Created by frank on 2018/11/29.
//  Copyright © 2018 凯叔叔. All rights reserved.
//

#import "FKFormSectionView.h"

@interface FKFormSectionView ()

@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation FKFormSectionView

- (void)setupSubviews
{
    [super setupSubviews];
    
    UILabel *titleLabel = [UILabel fk_labelWithFont:fk_adjustFont(14) textColor:fkColor333333];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.centerY.equalTo(self);
    }];
}

- (void)setGroup:(NSMutableDictionary *)group
{
    _group = group;
    
    if (group[@"headerTitle"]) {
        self.titleLabel.text = group[@"headerTitle"];
    }
    if (group[@"footerTitle"]) {
        self.titleLabel.text = group[@"footerTitle"];
    }
}

@end
