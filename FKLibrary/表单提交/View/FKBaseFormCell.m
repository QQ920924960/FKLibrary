//
//  FKBaseFormCell.m
//  BaiYeMallShop
//
//  Created by frank on 2018/11/27.
//  Copyright © 2018 凯叔叔. All rights reserved.
//

#import "FKBaseFormCell.h"

@implementation FKBaseFormCell

- (void)setupSubviews
{
    [super setupSubviews];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
//    UIView *separator = [[UIView alloc] init];
//    [self.contentView addSubview:separator];
//    _separator = separator;
//    separator.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    separator.hidden = true;
//
//    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.bottom.right.equalTo(self);
//        make.height.mas_equalTo(0.8);
//    }];
}

@end
