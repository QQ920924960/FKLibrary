//
//  FKGradientNav.h
//  HappyTest
//
//  Created by Macbook Pro on 2019/2/15.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FKGradientNav : UIView

/** 渐变比例0-1 */
@property (nonatomic, assign) CGFloat ratio;

@property (nonatomic, copy) NSString *leftBeginImg;
@property (nonatomic, copy) NSString *leftEndImg;
@property (nonatomic, copy) NSString *rightBeginImg;
@property (nonatomic, copy) NSString *rightEndImg;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIColor *beginColor;
@property (nonatomic, strong) UIColor *endColor;

//- (void)fk_addLeftBeginImg:(NSString *)leftBeginImg leftEndImg:(NSString *)leftEndImg rightBeginImg:(NSString *)rightBeginImg rightEndImg:(NSString *)rightEndImg;
- (void)fk_leftItemAddTarget:(nullable id)target action:(SEL)action;
- (void)fk_rightItemAddTarget:(nullable id)target action:(SEL)action;


@end

NS_ASSUME_NONNULL_END
