//
//  FKAPIClient.h
//  FKLibraryExample
//
//  Created by frank on 2018/8/13.
//  Copyright © 2018年 zmosa - frank. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface FKAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
