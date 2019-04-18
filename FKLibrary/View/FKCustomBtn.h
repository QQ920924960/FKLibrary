//
//  FKCustomBtn.h
//  FKLibraryExample
//
//  Created by Macbook Pro on 2019/1/3.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,FKImagePosition){
    FKImagePositionLeft = 0,
    FKImagePositionRight,
    FKImagePositionUp,
    FKImagePositionDown
};

@interface FKCustomBtn : UIButton

/** 图片的位置 */
@property (nonatomic, assign) FKImagePosition imagePosition;

/** 图片与文字的间距，默认为5 */
@property (nonatomic, assign) CGFloat space;
/** badge显示的数字 */
@property(nonatomic, copy) NSString *number;

@end
