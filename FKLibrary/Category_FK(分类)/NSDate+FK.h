//
//  NSDate+FK.h
//  FKLibraryExample
//
//  Created by frank on 15/11/2.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (FK)

/**
 *  是否为今天
 */
- (BOOL)fk_isToday;
/**
 *  是否为昨天
 */
- (BOOL)fk_isYesterday;
/**
 *  是否为今年
 */
- (BOOL)fk_isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)fk_dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)fk_deltaWithNow;


/** 格式化时间 */
+ (NSString *)fk_dateFormatWithNumber:(NSNumber *)number;

@end
