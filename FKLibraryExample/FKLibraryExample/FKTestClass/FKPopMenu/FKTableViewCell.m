//
//  FKTableViewCell.m
//  FKLibraryExample
//
//  Created by frank on 15/11/11.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "FKTableViewCell.h"

@interface FKTableViewCell ()
@property (nonatomic, weak) UIButton *button;
@end

@implementation FKTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"myCell";
    FKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[FKTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

/**
 *  重写初始化方法
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 创建按钮
        UIButton *button = [[UIButton alloc] init];
        button.backgroundColor = [UIColor redColor];
        button.frame = CGRectMake(200, 0, 50, 50);
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        self.button = button;
    }
    return self;
}

- (void)buttonClicked:(UIButton *)button
{
//    if ([self.delegate respondsToSelector:@selector(buttonDelegate:button:)]) {
//        [self.delegate buttonDelegate:self button:button];
//    }
    if ([self.delegate respondsToSelector:@selector(buttonDelegate:button:)]) {
        [self.delegate buttonDelegate:self button:button];
    }
}

@end
