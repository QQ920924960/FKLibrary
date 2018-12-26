//
//  FKAddImageView.m
//  FKLibraryExample
//
//  Created by frank on 2018/9/7.
//  Copyright © 2018年 zmosa. All rights reserved.
//

#import "FKAddImageView.h"

@interface FKAddImageView()

@property(nonatomic, weak) UIImageView *iconView;
@property(nonatomic, weak) UIImageView *pictureView;

@end

@implementation FKAddImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
//    self.backgroundColor = [UIColor whiteColor];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImageDidTap:)]];
    
    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"add_bgview_icon"]];
    [self addSubview:iconView];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    self.iconView = iconView;
    
    UIImageView *pictureView = [[UIImageView alloc] init];
    [self addSubview:pictureView];
    self.pictureView = pictureView;
    [pictureView fk_viewCornerRadius:0 borderWidth:0.8 borderColor:[UIColor groupTableViewBackgroundColor]];
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)addImageDidTap:(UITapGestureRecognizer *)gesture
{
    if (self.addBlock) {
        self.addBlock();
    }
}

- (void)setData:(id)data
{
    _data = data;
    
    if ([data isKindOfClass:[UIImage class]]) {
        self.pictureView.image = (UIImage *)data;
    } else if ([data isKindOfClass:[NSString class]]) {
        if ([data isEqualToString:@""]) { // 不是加号按钮
            self.pictureView.image = nil;
        } else {
            [self.pictureView sd_setImageWithURL:[NSURL URLWithString:(NSString *)data] placeholderImage:nil];
        }
    } else {
        self.pictureView.image = nil;
    }
}

- (void)setAddBtnBgImg:(UIImage *)addBtnBgImg
{
    _addBtnBgImg = addBtnBgImg;
    
    self.iconView.image = addBtnBgImg;
}

@end
