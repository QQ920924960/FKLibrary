//
//  NSBundle+FK.m
//  FKLibraryExample
//
//  Created by frank on 15/11/10.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "NSBundle+FK.h"
#import <UIKit/UIKit.h>

@implementation NSBundle (FK)

+ (NSArray *)fk_preferredScales {
    static NSArray *scales;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat screenScale = [UIScreen mainScreen].scale;
        if (screenScale <= 1) {
            scales = @[@1,@2,@3];
        } else if (screenScale <= 2) {
            scales = @[@2,@3,@1];
        } else {
            scales = @[@3,@2,@1];
        }
    });
    return scales;
}

+ (NSString *)fk_pathForScaledResource:(NSString *)name ofType:(NSString *)ext inDirectory:(NSString *)bundlePath {
    if (name.length == 0) return nil;
    if ([name hasSuffix:@"/"]) return [self pathForResource:name ofType:ext inDirectory:bundlePath];
    
    NSString *path = nil;
    NSArray *scales = [self fk_preferredScales];
    for (int s = 0; s < scales.count; s++) {
        CGFloat scale = ((NSNumber *)scales[s]).floatValue;
        NSString *scaledName = ext.length ? [self fk_stringByAppendingNameScale:scale string:name]
        : [self fk_stringByAppendingNameScale:scale string:name];
        path = [self pathForResource:scaledName ofType:ext inDirectory:bundlePath];
        if (path) break;
    }
    
    return path;
}

- (NSString *)fk_pathForScaledResource:(NSString *)name ofType:(NSString *)ext {
    if (name.length == 0) return nil;
    if ([name hasSuffix:@"/"]) return [self pathForResource:name ofType:ext];
    
    NSString *path = nil;
    NSArray *scales = [NSBundle fk_preferredScales];
    for (int s = 0; s < scales.count; s++) {
        CGFloat scale = ((NSNumber *)scales[s]).floatValue;
        NSString *scaledName = ext.length ? [self fk_stringByAppendingNameScale:scale string:name]
        : [self fk_stringByAppendingNameScale:scale string:name];
        path = [self pathForResource:scaledName ofType:ext];
        if (path) break;
    }
    
    return path;
}

- (NSString *)fk_pathForScaledResource:(NSString *)name ofType:(NSString *)ext inDirectory:(NSString *)subpath {
    if (name.length == 0) return nil;
    if ([name hasSuffix:@"/"]) return [self pathForResource:name ofType:ext];
    
    NSString *path = nil;
    NSArray *scales = [NSBundle fk_preferredScales];
    for (int s = 0; s < scales.count; s++) {
        CGFloat scale = ((NSNumber *)scales[s]).floatValue;
        NSString *scaledName = ext.length ? [self fk_stringByAppendingNameScale:scale string:name]
        : [self fk_stringByAppendingNameScale:scale string:name];
        path = [self pathForResource:scaledName ofType:ext inDirectory:subpath];
        if (path) break;
    }
    
    return path;
}

#pragma mark -private 【为了不与其他分类产生耦合,把string分类里面的方法重新写了一遍】
- (NSString *)fk_stringByAppendingNameScale:(CGFloat)scale string:(NSString *)string {
    if (fabs(scale - 1) <= __FLT_EPSILON__ || string.length == 0 || [string hasSuffix:@"/"]) return self.copy;
    return [string stringByAppendingFormat:@"@%@x", @(scale)];
}

+ (NSString *)fk_stringByAppendingNameScale:(CGFloat)scale string:(NSString *)string {
    if (fabs(scale - 1) <= __FLT_EPSILON__ || string.length == 0 || [string hasSuffix:@"/"]) return self.copy;
    return [string stringByAppendingFormat:@"@%@x", @(scale)];
}


@end
