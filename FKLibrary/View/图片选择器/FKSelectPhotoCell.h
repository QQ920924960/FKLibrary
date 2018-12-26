//
//  FKSelectPhotoCell.h
//  FKLibraryExample
//
//  Created by frank on 2018/9/7.
//  Copyright © 2018年 zmosa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FKSelectPhotoCell : UICollectionViewCell

/** 用于接收数据：可能是UIImage，也可能是url */
@property(nonatomic, strong) id data;
/** 添加按钮的背景图片，可不填 */
@property(nonatomic, strong) UIImage *addBtnBgImg;

@property(nonatomic, copy) void(^deleteBlock) (id data);

@end
