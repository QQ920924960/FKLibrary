//
//  FKFieldCell.m
//  BaiYeMallShop
//
//  Created by frank on 2018/11/27.
//  Copyright © 2018 凯叔叔. All rights reserved.
//

#import "FKFieldCell.h"

@interface FKFieldCell ()

@property (nonatomic, weak) UITextField *field;

@end

@implementation FKFieldCell

- (void)setupSubviews
{
    [super setupSubviews];
    
    UITextField *field = [[UITextField alloc] init];
    [self.contentView addSubview:field];
    self.field = field;
    field.font = fk_adjustFont(14);
    field.textColor = fkColor333333;
    [field addTarget:self action:@selector(valueFieldEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    [field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.right.equalTo(self).offset(-12);
        make.top.bottom.equalTo(self);
    }];
}

- (void)valueFieldEndEditing:(UITextField *)field
{
    self.item[@"value"] = field.text;
}

- (void)setItem:(NSMutableDictionary *)item
{
    [super setItem:item];
    
    self.field.text = item[@"value"];
    self.field.placeholder = item[@"placeholder"];
}

@end
