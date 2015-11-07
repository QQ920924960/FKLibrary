//
//  NSData+FKCategory.h
//  FKLibraryExample
//
//  Created by frank on 15/11/7.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (FKCategory)

/**
 *  Returns a string representation of the receiver Base64 encoded.
 *
 *  @return 一个Base64的编码字符串
 */
- (NSString *)FKDataBase64Encoded;

/**
 *  返回包含`base64String`解码的data
 *
 *  @param base64String 需要进行Base64编码的字符串
 *
 *  @return 包含`base64String`解码的data
 */
+ (NSData *)FKDataWithBase64String:(NSString *)base64String;

@end
