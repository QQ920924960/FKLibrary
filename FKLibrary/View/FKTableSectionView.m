//
//  FKTableSectionView.m
//  FKLibraryExample
//
//  Created by frank on 2018/9/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FKTableSectionView.h"
static NSString *const ID = @"FKTableSectionView";

@interface FKTableSectionView()

@end

@implementation FKTableSectionView

+ (instancetype)sectionView:(UITableView *)tableView
{
    FKTableSectionView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(self)];
    if (!view) {
        view = [[self alloc] initWithReuseIdentifier:NSStringFromClass(self)];
    }
    return view;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    
}

@end
