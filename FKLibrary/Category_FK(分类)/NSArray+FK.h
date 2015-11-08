//
//  NSArray+FK.h
//  FKLibraryExample
//
//  Created by frank on 15/11/7.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (FK)

/**
 *  提取字符串中的数组，例如：将"[1,3,45,45]"变成[1,3,45,45]【因为我们的傻逼后台返回过这样的数据，所以得自己处理，你们应该用不着】
 */
+ (NSArray *)fk_arrayWithString:(NSString *)string;


@end
