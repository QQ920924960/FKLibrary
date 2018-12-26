//
//  FKSinglePhotoCell.m
//  BaiYeMallShop
//
//  Created by frank on 2018/11/27.
//  Copyright © 2018 凯叔叔. All rights reserved.
//

#import "FKSinglePhotoCell.h"
#import "FKImageTool.h"

@interface FKSinglePhotoCell ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *photoView;

@end

@implementation FKSinglePhotoCell

- (void)setupSubviews
{
    [super setupSubviews];
    
    UILabel *titleLabel = [UILabel fk_labelWithFont:fk_adjustFont(14) textColor:fkColor333333];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIImageView *photoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qudai_shengqing"]];
    [self.contentView addSubview:photoView];
    self.photoView = photoView;
    photoView.userInteractionEnabled = true;
    [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoViewDidTap:)]];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.right.equalTo(self).offset(-12);
        make.top.equalTo(self);
        make.height.mas_equalTo(36);
    }];
    [photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel);
        make.top.equalTo(titleLabel.mas_bottom);
        make.width.height.mas_equalTo(80);
    }];
}

- (void)photoViewDidTap:(UITapGestureRecognizer *)gesture
{
    [self endEditing:true];
    
    __block UIImageView *imageView = (UIImageView *)gesture.view;
    FKImageTool *tool = [FKImageTool sharedInstance];
    [tool fk_showImageActionSheet];
    fkWeakSelf(self);
    tool.getImageBlock = ^(UIImage *image) {
        imageView.image = image;
        weakself.item[@"image"] = image;
    };
}

- (void)setItem:(NSMutableDictionary *)item
{
    [super setItem:item];
    
    self.titleLabel.text = item[@"title"];
    if (item[@"url"]) {
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:item[@"url"]]];
    }
}

@end
