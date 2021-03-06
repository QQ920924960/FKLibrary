//
//  FKPayMethodView.h
//  FKLibraryExample
//
//  Created by frank on 2018/10/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FKPayMethodView : UIView

@property (nonatomic, copy) NSString *amount;

//@property (nonatomic, copy) void(^selectePayMethodBlock)(NSString *payMethodName);
@property (nonatomic, copy) void(^selectePayMethodBlock)(NSString *payType);
@property (nonatomic, copy) void(^closeBlock) (void);
- (void)show;

@end

NS_ASSUME_NONNULL_END
