//
//  FKSelectPhotoCell.m
//  FKLibraryExample
//
//  Created by frank on 2018/9/7.
//  Copyright © 2018年 zmosa. All rights reserved.
//

#import "FKSelectPhotoCell.h"
#import "FKAddImageView.h"

@interface FKSelectPhotoCell()

@property(nonatomic, weak) FKAddImageView *addView;
@property(nonatomic, weak) UIButton *deleteBtn;
@property(nonatomic, weak) UIImageView *deleteView;

@end

@implementation FKSelectPhotoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    FKAddImageView *addView = [[FKAddImageView alloc] init];
    [self.contentView addSubview:addView];
    self.addView = addView;
    addView.userInteractionEnabled = false;
    [addView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    // 添加一个透明的点击区域，作为删除按钮
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:deleteBtn];
    self.deleteBtn = deleteBtn;
    deleteBtn.hidden = true;
//    deleteBtn.backgroundColor = [UIColor blueColor];
    [deleteBtn addTarget:self action:@selector(deleteBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.top.equalTo(self);
        make.right.equalTo(self);
    }];
    
    UIImageView *deleteView = [[UIImageView alloc] init];
    [self.contentView addSubview:deleteView];
    deleteView.image = [UIImage imageNamed:@"delete_picture"];
    deleteView.hidden = true;
    self.deleteView = deleteView;
    [deleteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.top.equalTo(self).offset(-5);
        make.right.equalTo(self).offset(5);
    }];
}

- (void)deleteBtnClicked
{
    if (self.deleteBlock) {
        self.deleteBlock(self.data);
    }
}

- (void)setData:(id)data
{
    _data = data;
    
    self.deleteBtn.hidden = [data isKindOfClass:[NSString class]] && [data isEqualToString:@""];
    self.deleteView.hidden = [data isKindOfClass:[NSString class]] && [data isEqualToString:@""];
    self.addView.data = data;
}


- (void)setAddBtnBgImg:(UIImage *)addBtnBgImg
{
    _addBtnBgImg = addBtnBgImg;
    
    self.addView.addBtnBgImg = addBtnBgImg;
}

@end
