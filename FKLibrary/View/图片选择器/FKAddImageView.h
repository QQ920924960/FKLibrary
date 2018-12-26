//
//  FKAddImageView.h
//  FKLibraryExample
//
//  Created by frank on 2018/9/7.
//  Copyright © 2018年 zmosa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FKAddImageView : UIView

@property(nonatomic, strong) id data;
/** 添加按钮的背景图片，可不填 */
@property(nonatomic, strong) UIImage *addBtnBgImg;

@property(nonatomic, copy) void(^addBlock) (void);

@end
