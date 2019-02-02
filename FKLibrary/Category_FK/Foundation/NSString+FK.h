//
//  NSString+FK.h
//  FKLibraryExample
//
//  Created by frank on 15/11/2.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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


+ (NSString *)fk_stringWithUUID;



- (NSMutableAttributedString *)fk_addAttr:(UIColor*)color font:(UIFont*)font;

- (NSMutableAttributedString *)fk_addAttributeStyle:(NSString*)subText color:(UIColor*)color font:(UIFont*)font;

- (NSMutableAttributedString *)fk_setNumberAttribute:(UIColor*)numberColor numberFont:(UIFont*)numberFont;

/** 可以输入的正确格式 **/
- (BOOL)fk_isRightInputFormat;
/**  【字母开头】6-16位字母、数字或者下划线组成 **/
- (BOOL)fk_isRightUserName;

- (BOOL)fk_isRightPwdFormat;

/** 是否是正确的银行卡号 **/
- (BOOL)fk_isRightBankCard;

/** 判断某个字符串是不是整型数值 */
- (BOOL)fk_isPureInt;
/** 是不是浮点数 */
- (BOOL)fk_isFloat;
/** 判断某个字符串是不是纯浮点型数值 */
- (BOOL)fk_isPureFloat;
/** 是不是纯字母 **/
- (BOOL)fk_isPureLetter;

/** 给文字添加行间距 */
- (NSAttributedString *)fk_setLineSpace:(CGFloat)lineSpace;

/** 清除不符合【0-9 换行 空格 : | ； ，】的字符 **/
- (NSString *)fk_cleanDontNeed;

/** 将字符串中包含@[@"\n",@" ",@":",@"|",@";"]中任一元素匹配的字符转成逗号 **/
- (NSString *)fk_replaceToComma;

/** 将字符串中包含@[@"\n",@":",@";"]中任一元素匹配的字符转成逗号 **/
- (NSString *)fk_replaceToCommaExceptSpaceAndLine;

/** 将字符串中包含@[@"|"]中任一元素匹配的字符转成空格 **/
- (NSString *)fk_replaceToSpaceWithLine;

/** 将倒计时的秒数转换成 hour:minute:second的格式 **/
+ (NSString *)fk_timeStrWithSeconds:(NSInteger)countSeconds;

/** 将汉字转为拼音 **/
- (NSString *)fk_converToPinYin;

/** 是否是纯汉字 **/
- (BOOL)fk_isChinese;

/** 是否包含汉字 **/
- (BOOL)fk_hasChinese;

/** 是否包含中文汉字 **/
- (BOOL)fk_includeChinese;

/** 获取某个字符串或者汉字的拼音 */
- (NSString *)fk_pinYin;

/** 获取某个字符串或者汉字的首字母. */
- (NSString *)fk_firstCharactor;

/** 时间戳转时间字符串 */
- (NSString *)fk_time;

- (NSString *)fk_timeWithFormat:(NSString *)format;

/** MD5加密 */
-(NSString *)fk_md5String;

/** html反转义 */
- (NSString *)fk_htmlToString;

@end
