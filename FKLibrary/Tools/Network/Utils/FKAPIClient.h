//
//  FKAPIClient.h
//  HHShopping
//
//  Created by frank on 2018/8/13.
//  Copyright © 2018年 嘉瑞科技有限公司 - 凯叔叔. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface FKAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
