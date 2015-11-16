//
//  FKPopView.h
//  FKLibraryExample
//
//  Created by frank on 15/11/11.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FKPopView;
@protocol FKPopViewDelegate <NSObject>
@optional
- (void)popViewDismissed:(FKPopView *)popView;
- (void)coverBtnDelegate:(FKPopView *)popView button:(UIButton *)button;
- (void)firstBtnDelegate:(FKPopView *)popView button:(UIButton *)button;
- (void)secondBtnDelegate:(FKPopView *)popView button:(UIButton *)button;
@end

@interface FKPopView : UIView
@property (nonatomic, weak) id<FKPopViewDelegate> delegate;


/**
 *  在这里设置内部图标和title
 *
 *  @param images 按钮的图片
 *  @param titles 按钮的title
 */
- (void)setImages:(NSArray<NSString *> *)images titles:(NSArray<NSString *> *)titles;
+ (instancetype)popView;
/**
 *  显示popView
 */
- (void)showWithPoint:(CGPoint)point;
- (void)dismiss;

@end
