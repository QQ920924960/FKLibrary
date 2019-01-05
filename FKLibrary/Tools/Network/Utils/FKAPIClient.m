//
//  FKAPIClient.m
//  FKLibraryExample
//
//  Created by frank on 2018/8/13.
//  Copyright © 2018年 zmosa - frank. All rights reserved.
//

#import "FKAPIClient.h"

@implementation FKAPIClient

+ (instancetype)sharedClient
{
    static FKAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[FKAPIClient alloc] initWithBaseURL:nil];
        
        // 添加安全策略
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
//        // 设置请求类型
//        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
//        // 设置回复类型
//        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        // 设置超时时间
        [_sharedClient.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _sharedClient.requestSerializer.timeoutInterval = 10.0;
        [_sharedClient.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        // 去除NSNull
        AFJSONResponseSerializer *response = [[AFJSONResponseSerializer alloc] init];
        response.removesKeysWithNullValues = true;
        _sharedClient.responseSerializer = response;
    });
    
    return _sharedClient;
}

@end
