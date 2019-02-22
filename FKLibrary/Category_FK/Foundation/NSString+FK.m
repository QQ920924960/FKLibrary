//
//  NSString+FK.m
//  FKLibraryExample
//
//  Created by frank on 15/11/2.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "NSString+FK.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

#define EmojiCodeToSymbol(c) ((((0x808080F0 | (c & 0x3F000) >> 4) | (c & 0xFC0) << 10) | (c & 0x1C0000) << 18) | (c & 0x3F) << 24)


@implementation NSString (FK)

- (NSString *)fk_stringMD5
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    return [self fk_stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)fk_stringSHA1
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(string, length, bytes);
    return [self fk_stringFromBytes:bytes length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)fk_stringSHA256
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(string, length, bytes);
    return [self fk_stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)fk_stringSHA512
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(string, length, bytes);
    return [self fk_stringFromBytes:bytes length:CC_SHA512_DIGEST_LENGTH];
}

- (NSString *)fk_stringCCHmacSHA1WithKey:(NSString *)key
{
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutableData = [NSMutableData dataWithLength:CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
    return [self fk_stringFromBytes:(unsigned char *)mutableData.bytes length:mutableData.length];
}

- (NSString *)fk_stringCCHmacSHA256WithKey:(NSString *)key
{
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutableData = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
    return [self fk_stringFromBytes:(unsigned char *)mutableData.bytes length:mutableData.length];
}

- (NSString *)fk_stringCCHmacSHA512WithKey:(NSString *)key
{
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutableData = [NSMutableData dataWithLength:CC_SHA512_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA512, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
    return [self fk_stringFromBytes:(unsigned char *)mutableData.bytes length:mutableData.length];
}

- (NSString *)fk_stringMD5Salt:(NSString *)text salt:(NSString *)salt
{
    // 撒盐：随机地往明文中插入任意字符串
    NSString *saltStr = [text stringByAppendingString:salt];
    return [saltStr fk_stringMD5];
}

- (NSString *)fk_stringDoubleMD5:(NSString *)text
{
    return [[text fk_stringMD5] fk_stringMD5];
}

- (NSString *)fk_stringMD5Reorder:(NSString *)text
{
    NSString *pwd = [text fk_stringMD5];
    
    // 加密后pwd == 3f853778a951fd2cdf34dfd16504c5d8
    NSString *prefix = [pwd substringFromIndex:2];
    NSString *subfix = [pwd substringToIndex:2];
    
    // 乱序后 result == 853778a951fd2cdf34dfd16504c5d83f
    NSString *result = [prefix stringByAppendingString:subfix];
    
//    NSLog(@"\ntext=%@\npwd=%@\nresult=%@", text, pwd, result);
    
    return result;
}

#pragma mark - tools

- (NSString *)fk_stringFromBytes:(unsigned char *)bytes length:(NSInteger)length
{
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < length; i++)
        [mutableString appendFormat:@"%02x", bytes[i]];
    return [NSString stringWithString:mutableString];
}

#pragma mark - about emoji
+ (NSString *)fk_emojiWithIntCode:(int)intCode {
    int symbol = EmojiCodeToSymbol(intCode);
    NSString *string = [[NSString alloc] initWithBytes:&symbol length:sizeof(symbol) encoding:NSUTF8StringEncoding];
    if (string == nil) { // 新版Emoji
        string = [NSString stringWithFormat:@"%C", (unichar)intCode];
    }
    return string;
}

+ (NSString *)fk_emojiWithStringCode:(NSString *)stringCode
{
    char *charCode = (char *)stringCode.UTF8String;
    int intCode = (int)strtol(charCode, NULL, 16);
    return [self fk_emojiWithIntCode:intCode];
}

// 判断是否是 emoji表情
- (BOOL)fk_isEmoji
{
    BOOL returnValue = NO;
    
    const unichar hs = [self characterAtIndex:0];
    // surrogate pair
    if (0xd800 <= hs && hs <= 0xdbff) {
        if (self.length > 1) {
            const unichar ls = [self characterAtIndex:1];
            const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
            if (0x1d000 <= uc && uc <= 0x1f77f) {
                returnValue = YES;
            }
        }
    } else if (self.length > 1) {
        const unichar ls = [self characterAtIndex:1];
        if (ls == 0x20e3) {
            returnValue = YES;
        }
    } else {
        // non surrogate
        if (0x2100 <= hs && hs <= 0x27ff) {
            returnValue = YES;
        } else if (0x2B05 <= hs && hs <= 0x2b07) {
            returnValue = YES;
        } else if (0x2934 <= hs && hs <= 0x2935) {
            returnValue = YES;
        } else if (0x3297 <= hs && hs <= 0x3299) {
            returnValue = YES;
        } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
            returnValue = YES;
        }
    }
    
    return returnValue;
}

+ (NSString *)fk_stringWithUUID
{
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)string;
}


#pragma mark - 【2018-12-26追加】
- (NSMutableAttributedString *)fk_addAttr:(UIColor*)color font:(UIFont*)font
{
    if ([self isKindOfClass:[NSString class]]) {
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self];
        NSDictionary *attr = @{NSForegroundColorAttributeName : color,
                               NSFontAttributeName : font};
        [attrStr addAttributes:attr range:NSMakeRange(0, self.length)];
        return attrStr;
    }
    return nil;
}

- (NSMutableAttributedString *)fk_addAttributeStyle:(NSString*)subText color:(UIColor*)color font:(UIFont*)font
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    if (!subText) return attributedString;
    NSRange range = [self rangeOfString:subText];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
    if (font) [attributedString addAttribute:NSFontAttributeName value:font range:range];
    return attributedString;
}


- (NSMutableAttributedString *)fk_setNumberAttribute:(UIColor*)numberColor numberFont:(UIFont*)numberFont
{
    NSArray *number = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9" ,@"-",@".",@"~", @"%"];
    NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:self];
    NSDictionary *attrs = @{NSForegroundColorAttributeName : numberColor,
                            NSFontAttributeName : numberFont,
                            NSUnderlineStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleNone]};
    for (int i = 0; i < self.length; i ++) {
        //这里的小技巧，每次只截取一个字符的范围
        NSString *a = [self substringWithRange:NSMakeRange(i, 1)];
        //判断装有0-9的字符串的数字数组是否包含截取字符串出来的单个字符，从而筛选出符合要求的数字字符的范围NSMakeRange
        if ([number containsObject:a]) {
            [attributeString setAttributes:attrs range:NSMakeRange(i, 1)];
        }
    }
    return attributeString;
}

//- (BOOL)fk_isNumberAndLetter
//{
//    NSString *reg = @"(^[a-zA-Z][_a-zA-Z0-9]{5,15}$)";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
//    return [predicate evaluateWithObject:self];
//}


- (BOOL)fk_isRightInputFormat
{
    NSString *reg = @"(^[_a-zA-Z0-9]*$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    return [predicate evaluateWithObject:self];
}

/**
 【字母开头】6-16位字母、数字或者下划线组成
 */
- (BOOL)fk_isRightUserName
{
    NSString *reg = @"(^[a-zA-Z][_a-zA-Z0-9]{5,15}$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    return [predicate evaluateWithObject:self];
}

/**
 匹配正确的密码格式：6-16位数字英文组合
 */
- (BOOL)fk_isRightPwdFormat
{
    NSString *reg = @"(^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    return [predicate evaluateWithObject:self];
}

- (BOOL)fk_isRightBankCard
{
    NSString *reg = @"(^(\\d{16}|\\d{19})$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    return [predicate evaluateWithObject:self];
}

- (BOOL)fk_isRightPrice
{
    if ([self fk_isFloat]) {
        NSArray *array = [self componentsSeparatedByString:@"."];
        if (array.count == 2) {
            // 小数点后面的位数
            NSString *last = array.lastObject;
            return (last.length < 3);
        }
        return true;
    } else {
        return false;
    }
}

- (BOOL)fk_isPureInt
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)fk_isFloat
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

- (BOOL)fk_isPureFloat
{
    return [self fk_isFloat] && ![self fk_isPureInt];
}

- (BOOL)fk_isPureLetter
{
    NSString *reg = @"(^[a-zA-Z]*$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    return [predicate evaluateWithObject:self];
}

- (NSAttributedString *)fk_setLineSpace:(CGFloat)lineSpace
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [paragraphStyle setLineBreakMode:NSLineBreakByCharWrapping];
    
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    return attrStr;
}


/**
 清除不符合【0-9 换行 空格 : | ； ，】的字符
 
 @return <#return value description#>
 */
- (NSString *)fk_cleanDontNeed
{
    // 匹配除了【0-9 换行 空格 : | ； ，】之外的所有字符
    NSString *regExpStr = @"[^0-9\n :;|,]";
    NSString *replacement = @"";
    // 创建 NSRegularExpression 对象,匹配 正则表达式
    NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:regExpStr options:NSRegularExpressionCaseInsensitive error:nil];
    // 开始剔除
    return [regExp stringByReplacingMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length) withTemplate:replacement];
}

- (NSString *)fk_replaceToComma
{
    NSString *temp = self;
    NSArray *symbols = @[@"\n",@" ",@":",@"|",@";"];
    for (NSString *symbol in symbols) {
        temp = [temp stringByReplacingOccurrencesOfString:symbol withString:@","];
    }
    return temp;
}

- (NSString *)fk_replaceToCommaExceptSpaceAndLine
{
    NSString *temp = self;
    NSArray *symbols = @[@"\n", @":", @";"];
    for (NSString *symbol in symbols) {
        temp = [temp stringByReplacingOccurrencesOfString:symbol withString:@","];
    }
    return temp;
}

- (NSString *)fk_replaceToSpaceWithLine
{
    NSString *temp = self;
    NSArray *symbols = @[@"|"];
    for (NSString *symbol in symbols) {
        temp = [temp stringByReplacingOccurrencesOfString:symbol withString:@" "];
    }
    return temp;
}

+ (NSString *)fk_timeStrWithSeconds:(NSInteger)countSeconds
{
    NSInteger seconds = countSeconds % 60;
    NSInteger minutes = (countSeconds / 60) % 60;
    NSInteger hours = countSeconds / 3600;
    NSString *timeText = [NSString stringWithFormat:@"%02ld:%02ld", minutes, seconds];
    if (hours > 0) {
        timeText = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", hours, minutes, seconds];
    }
    return timeText;
}

- (NSString *)fk_converToPinYin
{
    NSMutableString *pinyin = [self mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    return [pinyin stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (BOOL)fk_isChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)fk_hasChinese
{
    if (!self) return NO;
    
    for(int i=0; i< self.length; i++) {
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)fk_includeChinese
{
    for(int i=0; i< [self length];i++) {
        int a =[self characterAtIndex:i];
        if( a >0x4e00 && a <0x9fff) {
            return YES;
        }
    }
    return NO;
}

/** 16进制转换为NSData **/
- (NSData *)fk_convertHexStrToData
{
    if (!self || [self length] ==0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc]initWithCapacity:[self length]*2];
    NSRange range;
    if ([self length] %2==0) {
        range = NSMakeRange(0,2);
    } else {
        range = NSMakeRange(0,1);
    }
    for (NSInteger i = range.location; i < [self length]; i +=2) {
        unsigned int anInt;
        NSString *hexCharStr = [self substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc]initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc]initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location+= range.length;
        range.length=2;
    }
    
    return hexData;
}

- (NSString *)fk_pinYin
{
    if (!self || self.length == 0) return nil;
    NSMutableString *str = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    return [str capitalizedString];
}

//获取某个字符串或者汉字的首字母.
- (NSString *)fk_firstCharactor
{
    //    NSMutableString *str = [NSMutableString stringWithString:self];
    //    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    //    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pinYin = [self fk_pinYin];
    return [pinYin substringToIndex:1];
}

- (NSString *)fk_time
{
    return [self fk_timeWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString *)fk_timeWithFormat:(NSString *)format
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[self integerValue]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:format];
    NSString *string=[dateFormat stringFromDate:confromTimesp];
    return string;
}

#pragma mark 获取token MD5 加密
-(NSString *)fk_md5String
{
    //转换成UTF8
    const char * Cstr = [self UTF8String];
    //开辟一个16字节的空间
    unsigned char buff[16];
    
    CC_MD5(Cstr, (CC_LONG)strlen(Cstr), buff);
    
    //把Cstr字符串转化成32位16进制数列，（这个过程不可逆）把他存储到result这个空间里
    NSMutableString * result = [[NSMutableString alloc] init];
    
    for (int i = 0; i<16 ; i++) {
        [result appendFormat:@"%02x",buff[i]];
    }
    return result ;
}

// html反转义
- (NSString *)fk_htmlToString
{
    if (!self) {
        return nil;
    }
    
    // NSUTF8StringEncoding、NSUnicodeStringEncoding
    return [[NSAttributedString alloc] initWithData:[self dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil].string;
}


@end
