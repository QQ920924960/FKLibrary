//
//  FKHttpTool.h
//  FKLibraryExample
//
//  Created by frank on 2018/8/13.
//  Copyright © 2018年 zmosa - frank. All rights reserved.
//

#import "FKBaseResult.h"

@interface FKHttpTool : NSObject

/** 比较通用的调用方法 */
+ (void)postWithSuffix:(NSString *)suffix param:(id)param success:(void (^)(FKBaseResult *result))success failure:(void (^)(NSError *error))failure;


+ (void)getWithSuffix:(NSString *)suffix param:(id)param success:(void (^)(FKBaseResult *result))success failure:(void (^)(NSError *error))failure;



///** 比较通用的上传图片的方法 */
//+ (void)uploadWithPackNo:(NSString *)packno param:(id)data images:(NSArray<UIImage *> *)images progress:(void (^)(NSProgress *progress))progress success:(void (^)(FKBaseResult *result))success failure:(void (^)(NSError *error))failure;

/** 上传图片 */
+ (void)uploadFile:(NSString *)suffix param:(id)param files:(NSDictionary *)files progress:(void (^)(NSProgress *progress))progress success:(void (^)(FKBaseResult *result))success failure:(void (^)(NSError *error))failure;


/** 加载并缓存用户信息 */
+ (void)loadUserInfo:(void (^)(void))success;

@end
