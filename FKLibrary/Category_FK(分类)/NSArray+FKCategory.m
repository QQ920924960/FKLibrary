//
//  NSArray+FKCategory.m
//  FKLibraryExample
//
//  Created by frank on 15/11/7.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "NSArray+FKCategory.h"

@implementation NSArray (FKCategory)

+ (NSArray *)FKArrayWithString:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"[" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"]" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSArray *array = [NSArray arrayWithArray:[string componentsSeparatedByString:@","]];
    return array;
}

@end
