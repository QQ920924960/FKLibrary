//
//  FKLocationTool.h
//  BaiYeMallShop
//
//  Created by frank on 2018/12/1.
//  Copyright © 2018 凯叔叔. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FKLocationTool : NSObject

FKSingletonH
@property (nonatomic, copy) void(^didUpdateLocations) (CLPlacemark *placemark);
- (void)beginUpdatingLocation;

@end

NS_ASSUME_NONNULL_END
