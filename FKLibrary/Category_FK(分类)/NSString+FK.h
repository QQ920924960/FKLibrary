//
//  NSString+FK.h
//  FKLibraryExample
//
//  Created by frank on 15/11/2.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FK)

/**
 *  获得经过md5签名后的字符串【直接调用getter方法】
 */
@property (readonly) NSString *fk_stringMD5;

/**
 *  获得经过sha1加密后的字符串【直接调用getter方法】
 */
@property (readonly) NSString *fk_stringSHA1;

/**
 *  获得经过sha256加密后的字符串【直接调用getter方法】
 */
@property (readonly) NSString *fk_stringSHA256;

/**
 *  获得经过sha512加密后的字符串【直接调用getter方法】
 */
@property (readonly) NSString *fk_stringSHA512;

/**
 HMAC是密钥相关的哈希运算消息认证码（Hash-based Message Authentication Code）,
 HMAC运算利用哈希算法,
 以一个密钥和一个消息为输入,
 生成一个消息摘要作为输出。
 */
- (NSString *)fk_stringCCHmacSHA1WithKey:(NSString *)key;
- (NSString *)fk_stringCCHmacSHA256WithKey:(NSString *)key;
- (NSString *)fk_stringCCHmacSHA512WithKey:(NSString *)key;

/**
 *  MD5加盐($pass.$salt)
 *
 *  @param text 明文
 *  @param salt 盐
 *
 *  @return 加密后的密文
 */
- (NSString *)fk_stringMD5Salt:(NSString *)text salt:(NSString *)salt;

/**
 *  两次MD5(MD5($pass))
 *
 *  @param text 明文
 *
 *  @return 加密后的密文
 */
- (NSString *)fk_stringDoubleMD5:(NSString *)text;

/**
 *  先加密，后乱序
 *
 *  @param text 明文
 *
 *  @return 加密后的密文
 */
- (NSString *)fk_stringMD5Reorder:(NSString *)text;

/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)fk_emojiWithIntCode:(int)intCode;

/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)fk_emojiWithStringCode:(NSString *)stringCode;

/**
 *  是否为emoji字符
 */
- (BOOL)fk_isEmoji;



@end
