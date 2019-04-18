//
//  FKCityPicker.h
//  HappyTest
//
//  Created by Macbook Pro on 2019/1/11.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FKCityPicker : UIView

@property (nonatomic, copy) void(^selectedCityBlock) (NSDictionary *dict);
- (void)show;
- (void)showWithSuperView:(UIView *)view;

@end
