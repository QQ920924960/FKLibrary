//
//  FKPicturePopView.m
//  TimesCloud
//
//  Created by frank on 2018/11/13.
//  Copyright © 2018年 mfwlzlg. All rights reserved.
//

#import "FKPicturePopView.h"

@interface FKPicturePopView ()

@property (nonatomic, weak) UIView *container;
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation FKPicturePopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    self.backgroundColor = [UIColor clearColor];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)]];
    
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(fkScreenW * 0.5, fkScreenH * 0.5, 0, 0)];
    [self addSubview:container];
    self.container = container;
    container.backgroundColor = [UIColor whiteColor];
    [container fk_viewCornerRadius:10 borderWidth:0 borderColor:nil];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [container addSubview:imageView];
    self.imageView = imageView;
    CGFloat imageX = 30;
    CGFloat imageW = fkScreenW - 70 * 2;
    imageView.frame = CGRectMake(imageX, imageX, imageW, imageW);
}

- (void)showWithImagae:(UIImage *)image
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:self];
    self.frame = window.bounds;
    
    self.imageView.image = image;
//    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = fkColorAlpha(0, 0, 0, 0.5);
        CGFloat margin = 40;
        CGFloat containerW = fkScreenW - margin * 2;
        self.container.frame = CGRectMake(margin, (fkScreenH - containerW) * 0.5, containerW, containerW);
//    }];
}

- (void)close
{
//    [UIView animateWithDuration:0.25 animations:^{
        self.container.frame = CGRectMake(fkScreenW * 0.5, fkScreenH * 0.5, 0, 0);
        [self removeFromSuperview];
//    } completion:^(BOOL finished) {
//    }];
}

@end
