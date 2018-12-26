//
//  FKPayTypeRowCell.m
//  TimesCloud
//
//  Created by frank on 2018/11/23.
//  Copyright © 2018 mfwlzlg. All rights reserved.
//

#import "FKPayTypeRowCell.h"
static NSString *const ID = @"FKPayTypeRowCell";

@interface FKPayTypeRowCell ()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *titleLable;

@end

@implementation FKPayTypeRowCell

+ (instancetype)cellWith:(UITableView *)tableView
{
    FKPayTypeRowCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.offset(0);
        }];
        
        UILabel *titleLable = [UILabel fk_labelWithFont:fk_adjustFont(16) textColor:fkColor333333];
        [self.contentView addSubview:titleLable];
        self.titleLable = titleLable;
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconView.mas_right).offset(10);
            make.centerY.offset(0);
        }];
    }
    return self;
}

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    
    self.iconView.image = [UIImage imageNamed:dict[@"icon"]];
    self.titleLable.text = dict[@"title"];
}

@end
