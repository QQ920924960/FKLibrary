//
//  UIViewController+FK.h
//  FKLibraryExample
//
//  Created by frank on 2018/9/15.
//  Copyright © 2018年 zmosa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface UIViewController (FK)

-(void)fk_alertWithTitle:(NSString *)title confirm:(void(^)(void))confirm;

-(void)fk_alertWithTitle:(NSString *)title message:(NSString *)message confirm:(void(^)(void))confirm;

-(void)fk_alertWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirm:(void(^)(void))confirm;

-(void)fk_alertWithItems:(NSArray *)items confirm:(void (^)(NSString *title))confirm;

- (void)fk_removeBeforeVC;

/** 弹出地图选择窗口 */
- (void)fk_showMapAlertWithEndPoint:(CLLocationCoordinate2D)endPoint;

@end
