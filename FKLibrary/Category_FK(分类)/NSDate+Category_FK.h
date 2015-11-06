//
//  NSDate+Category_FK.h
//  FKLibraryExample
//
//  Created by frank on 15/11/2.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Category_FK)

/**
 *  是否为今天
 */
- (BOOL)FKIsToday;
/**
 *  是否为昨天
 */
- (BOOL)FKIsYesterday;
/**
 *  是否为今年
 */
- (BOOL)FKIsThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)FKDateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)FKDeltaWithNow;


/** 格式化时间 */
+ (NSString *)FKDateFormatWithNumber:(NSNumber *)number;

@end
