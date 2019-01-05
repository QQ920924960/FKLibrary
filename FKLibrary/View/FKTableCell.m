//
//  FKTableCell.m
//  FKLibraryExample
//
//  Created by frank on 2018/8/21.
//  Copyright © 2018年 zmosa - frank. All rights reserved.
//

#import "FKTableCell.h"

@implementation FKTableCell


+ (instancetype)cellWith:(UITableView *)tableView
{
    FKTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    if (!cell) {
        // xib最终会变成nib文件
        BOOL isNibExist = [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@.nib",[[NSBundle mainBundle]resourcePath], NSStringFromClass(self)]];
        if (isNibExist) { // 如果有xib，优先从xib创建cell
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil];
            cell = array.firstObject;
        } else {
            cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self)];
        }
    }
    return cell;
}

+ (instancetype)cellWith:(UITableView *)tableView className:(NSString *)className
{
    NSAssert(className, @"className不能为nil");
    FKTableCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    if (!cell) {
        BOOL isNibExist = [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@.nib",[[NSBundle mainBundle]resourcePath], className]];
        if (isNibExist) {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:className owner:self options:nil];
            cell = array.firstObject;
        } else {
            cell = [[NSClassFromString(className) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
        }
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    
}

@end
