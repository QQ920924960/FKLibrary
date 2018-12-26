//
//  FKSelectPhotoView.h
//  FKLibraryExample
//
//  Created by frank on 2018/9/7.
//  Copyright © 2018年 zmosa. All rights reserved.
//


/**
 思路：
 1、删除网络图片：代理通知控制器处理，然后控制器刷新cell的高度
 2、删除本地图片：直接在当前view处理，然后通知控制器刷新cell的高度
 */

#import <UIKit/UIKit.h>
@class FKSelectPhotoView;

@protocol FKSelectPhotoViewDelegate <NSObject>
@required
/** 自身的frame改变了 */
- (void)selectPhotoViewAdjustFrame:(FKSelectPhotoView *)view;
@optional
/** 删除网络图片 */
- (void)selectPhotoView:(FKSelectPhotoView *)view deleteUrl:(id)data;
@end

@interface FKSelectPhotoView : UIView

@property(nonatomic, assign) NSInteger maxCount;
@property(nonatomic, weak) UIViewController *superVC;
/** 网络图片数据 */
@property(nonatomic, strong) NSArray *urls;
/** 本地图片 */
@property(nonatomic, strong) NSArray *images;
/** 本地图片信息标识 */
@property(nonatomic, strong) NSArray *selectedAssets;
/** 图片列数：一行显示几个 */
@property(nonatomic, assign) NSInteger column;
/** 添加按钮的背景图片，可不填 */
@property(nonatomic, strong) UIImage *addBtnBgImg;

@property(nonatomic, assign) CGFloat itemH;
@property(nonatomic, weak) id<FKSelectPhotoViewDelegate> delegate;



@end
