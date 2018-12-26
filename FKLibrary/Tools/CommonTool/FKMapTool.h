//
//  FKMapTool.h
//  HHShopping
//
//  Created by frank on 2018/10/24.
//  Copyright © 2018年 嘉瑞科技有限公司 - 凯叔叔. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FKMapTool : NSObject

+ (void)showWith:(UIViewController *)superVC endPoint:(CLLocationCoordinate2D)endPoint;

@end

NS_ASSUME_NONNULL_END
