//
//  FKCacheTool.m
//  FKLibraryExample
//
//  Created by frank on 2018/8/13.
//  Copyright © 2018年 zmosa - frank. All rights reserved.
//

#import "FKCacheTool.h"
#define kUserDefaults [NSUserDefaults standardUserDefaults]
static NSString *const LoginInfo = @"loginInfo";
NSString *const FKPath(NSString *path) {
    return  [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:path];
}

@implementation FKCacheTool

+ (NSDictionary *)loginInfo
{
    return [kUserDefaults objectForKey:LoginInfo];
}

+ (void)saveLoginInfo:(NSDictionary *)loginInfo
{
    [kUserDefaults setObject:loginInfo forKey:LoginInfo];
    [kUserDefaults synchronize];
}

+ (BOOL)isLogin
{
    NSDictionary *user = [kUserDefaults objectForKey:LoginInfo];
    return user ? user[@"login_credentials"] : false;
}

+ (void)saveUserInfo:(NSDictionary *)userInfo
{
    [kUserDefaults setObject:userInfo forKey:@"userInfo"];
    [kUserDefaults synchronize];
}

+ (NSDictionary *)userInfo
{
    return [kUserDefaults objectForKey:@"userInfo"];
}

+ (BOOL)isHasPayPwd
{
    NSDictionary *userInfo = [kUserDefaults objectForKey:@"userInfo"];
    return [userInfo[@"zf_password"] boolValue];
}

+ (void)savePayPwd:(NSString *)payPwd
{
    NSDictionary *userInfo = [kUserDefaults objectForKey:@"userInfo"];
    if (!userInfo) return;
    NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithDictionary:userInfo];
    temp[@"zf_password"] = payPwd;
    [kUserDefaults setObject:temp forKey:@"userInfo"];
    [kUserDefaults synchronize];
}




#pragma mark - 文件缓存
+ (void)fk_setObject:(id)object forPath:(NSString *)path
{
    if (!object) {
        
        FKLog(@"SB，请不要传入空值好吗!");
        return;
    }
    
    if (![path isAbsolutePath]) {
        FKLog(@"---存储路径无效---");
        return;
    }
    
    NSData *cacheData = nil;
    if ([object isKindOfClass:[NSArray class]]) { // 如果传入的是模型数组
        NSArray *array = (NSArray *)object;
        if (array.count == 0) {
            FKLog(@"传入的数组元素个数为0");
            //            return;
            cacheData = [[NSData alloc] init];
        } else {
            id firstObj = array.firstObject;
            NSArray *keyValuesArray = [[firstObj class] mj_keyValuesArrayWithObjectArray:object];
            cacheData = [keyValuesArray mj_JSONData];
        }
    } else { // 如果传入的是模型对象或者dict
        cacheData = [object mj_JSONData];
    }
    
    BOOL successful = [cacheData writeToFile:path atomically:true];
    
    if (successful) {
        FKLog(@"--save success--");
    } else {
        FKLog(@"--save failure--");
    }
}

+ (void)fk_removeObjectForPath:(NSString *)path
{
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]) {
        BOOL removeSuccessful = [manager removeItemAtPath:path error:nil];
        if (removeSuccessful) {
            FKLog(@"---删除成功---");
        } else {
            FKLog(@"----删除失败----");
        }
    } else {
        FKLog(@"----文件不存在----");
    }
}

+ (id)fk_objectForPath:(NSString *)path
{
    NSData *cacheData = [NSData dataWithContentsOfFile:path];
    return [cacheData mj_JSONObject];
}

@end
