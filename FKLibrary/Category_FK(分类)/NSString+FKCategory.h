//
//  NSString+FKCategory.h
//  FKLibraryExample
//
//  Created by frank on 15/11/2.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FKCategory)

/**
 *  获得经过md5签名后的字符串【直接调用getter方法】
 */
@property (readonly) NSString *FKStringMD5;

/**
 *  获得经过sha1加密后的字符串【直接调用getter方法】
 */
@property (readonly) NSString *FKStringSHA1;

/**
 *  获得经过sha256加密后的字符串【直接调用getter方法】
 */
@property (readonly) NSString *FKStringSHA256;

/**
 *  获得经过sha512加密后的字符串【直接调用getter方法】
 */
@property (readonly) NSString *FKStringSHA512;

/**
 HMAC是密钥相关的哈希运算消息认证码（Hash-based Message Authentication Code）,
 HMAC运算利用哈希算法,
 以一个密钥和一个消息为输入,
 生成一个消息摘要作为输出。
 */
- (NSString *)FKStringCCHmacSHA1WithKey:(NSString *)key;
- (NSString *)FKStringCCHmacSHA256WithKey:(NSString *)key;
- (NSString *)FKStringCCHmacSHA512WithKey:(NSString *)key;

/**
 *  MD5加盐($pass.$salt)
 *
 *  @param text 明文
 *  @param salt 盐
 *
 *  @return 加密后的密文
 */
- (NSString *)FKStringMD5Salt:(NSString *)text salt:(NSString *)salt;

/**
 *  两次MD5(MD5($pass))
 *
 *  @param text 明文
 *
 *  @return 加密后的密文
 */
- (NSString *)FKStringDoubleMD5:(NSString *)text;

/**
 *  先加密，后乱序
 *
 *  @param text 明文
 *
 *  @return 加密后的密文
 */
- (NSString *)FKStringMD5Reorder:(NSString *)text;

/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)FKEmojiWithIntCode:(int)intCode;

/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)FKEmojiWithStringCode:(NSString *)stringCode;

/**
 *  是否为emoji字符
 */
- (BOOL)FKIsEmoji;



@end
