//
//  FKBaseResult.h
//  HHShopping
//
//  Created by frank on 2018/8/13.
//  Copyright © 2018年 嘉瑞科技有限公司 - 凯叔叔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FKBaseResult : NSObject

@property(nonatomic, copy) NSString *code;
@property(nonatomic, copy) NSString *msg;
@property(nonatomic, strong) id data;

@property (nonatomic, assign, getter=isSuccess) BOOL success;

@end
