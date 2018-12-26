//
//  NSData+FK.h
//  FKLibraryExample
//
//  Created by frank on 15/11/7.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (FK)

/**
 *  Returns a string representation of the receiver Base64 encoded.
 *
 *  @return 一个Base64的编码字符串
 */
- (NSString *)fk_dataBase64Encoded;

/**
 *  返回包含`base64String`解码的data
 *
 *  @param base64String 需要进行Base64编码的字符串
 *
 *  @return 包含`base64String`解码的data
 */
+ (NSData *)fk_dataWithBase64String:(NSString *)base64String;

@end
