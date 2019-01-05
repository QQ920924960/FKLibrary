//
//  FKHttpTool.m
//  FKLibraryExample
//
//  Created by frank on 2018/8/13.
//  Copyright © 2018年 zmosa - frank. All rights reserved.
//

#import "FKHttpTool.h"
#import "FKAPIClient.h"
#import <MJExtension.h>

@implementation FKHttpTool

+ (void)postWithSuffix:(NSString *)suffix param:(id)param success:(void (^)(FKBaseResult *))success failure:(void (^)(NSError *))failure
{
    // 将参数模型转成字典
//    NSMutableDictionary *params = param ? [param mj_keyValues] : [NSMutableDictionary dictionary];
    NSMutableDictionary *params = param ? [NSMutableDictionary dictionaryWithDictionary:param] : [NSMutableDictionary dictionary];
    
    FKAPIClient *manager = [FKAPIClient sharedClient];
    
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@/%@", HostURL, suffix];
    [manager POST:requestUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            // 将请求回来的字典根据传入的resultClass转成对应的模型
            FKBaseResult *result = [FKBaseResult mj_objectWithKeyValues:responseObject];
            
            if (result.isSuccess) {
                
            } else {
                [SVProgressHUD showErrorWithStatus:result.msg];
            }
            
            success(result);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"网络异常!"];
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)getWithSuffix:(NSString *)suffix param:(id)param success:(void (^)(FKBaseResult *result))success failure:(void (^)(NSError *error))failure
{
    // 将参数模型转成字典
//    NSMutableDictionary *params = param ? [param mj_keyValues] : [NSMutableDictionary dictionary];
    NSMutableDictionary *params = param ? [NSMutableDictionary dictionaryWithDictionary:param] : [NSMutableDictionary dictionary];
//    NSString *type = [FKCacheTool userType];
    FKAPIClient *manager = [FKAPIClient sharedClient];
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@/%@", HostURL, suffix];
    [manager GET:requestUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            // 将请求回来的字典根据传入的resultClass转成对应的模型
            FKBaseResult *result = [FKBaseResult mj_objectWithKeyValues:responseObject];
            success(result);
            
            if (!result.isSuccess) {
                [SVProgressHUD showErrorWithStatus:result.msg];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"网络异常!"];
        if (failure) {
            failure(error);
        }
    }];
    
}

//+ (void)uploadWithPackNo:(NSString *)packno param:(id)data images:(NSArray<UIImage *> *)images progress:(void (^)(NSProgress *))progress success:(void (^)(FKBaseResult *))success failure:(void (^)(NSError *))failure
//{
//    FKBaseParam *param = [FKBaseParam param];
//    if (data) param.data = data;
//    param.pack_no = packno;
//    
//    FKAPIClient *manager = [FKAPIClient sharedClient];
//    // 将参数模型转成字典
//    NSMutableDictionary *params = [param mj_keyValues];
//    NSDictionary *postData = @{@"requestData" : [params fk_JSONString]};
//    
//    [manager POST:RequestURL parameters:postData constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSData *data = UIImageJPEGRepresentation(image, 0.8);
//            NSString *name = [NSString stringWithFormat:@"%zd", idx];
//            NSString *fileName = [name stringByAppendingString:@".png"];
//            [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"image/jpeg"];
//        }];
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        if (progress) {
//            progress(uploadProgress);
//        }
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if (responseObject) {
//            FKBaseResult *result = [FKBaseResult mj_objectWithKeyValues:responseObject];
//            success(result);
//            
//            if (!result.isSuccess) {
//                kShowError;
//            }
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        kNetError;
//        if (failure) {
//            failure(error);
//        }
//    }];
//}
//

+ (void)uploadFile:(NSString *)suffix param:(id)param files:(NSDictionary *)files progress:(void (^)(NSProgress *))progress success:(void (^)(FKBaseResult *))success failure:(void (^)(NSError *))failure
{
    // 将参数模型转成字典
//    NSMutableDictionary *params = param ? [param mj_keyValues] : [NSMutableDictionary dictionary];
    NSMutableDictionary *params = param ? [NSMutableDictionary dictionaryWithDictionary:param] : [NSMutableDictionary dictionary];
    FKAPIClient *manager = [FKAPIClient sharedClient];
    
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@/%@", HostURL, suffix];
    [manager POST:requestUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [files enumerateKeysAndObjectsUsingBlock:^(NSString *key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSData *data = UIImageJPEGRepresentation(obj, 0.8);
            NSString *fileName = [NSString stringWithFormat:@"%@.png", key];
            [formData appendPartWithFileData:data name:key fileName:fileName mimeType:@"image/png"];
        }];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            FKBaseResult *result = [FKBaseResult mj_objectWithKeyValues:responseObject];
            success(result);
            
            if (!result.isSuccess) {
                [SVProgressHUD showErrorWithStatus:result.msg];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"网络异常!"];
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)loadUserInfo:(void (^)(void))success
{
    [FKHttpTool getWithSuffix:@"Users/getInfo?type=user" param:nil success:^(FKBaseResult *result) {
        if (result.isSuccess) {
            [SVProgressHUD dismiss];
            [FKCacheTool saveUserInfo:result.data];
            if (success) success();
        }
    } failure:nil];
}


@end
