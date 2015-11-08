//
//  NSObject+FK.h
//  FKLibraryExample
//
//  Created by QQ920924960 on 15-11-8.
//  Copyright (c) 2015年 zmosa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FK)

#pragma mark - Sending messages with variable parameters

- (id)performSelectorWithArgs:(SEL)sel, ...;

- (void)performSelectorWithArgs:(SEL)sel afterDelay:(NSTimeInterval)delay, ...;

- (id)performSelectorWithArgsOnMainThread:(SEL)sel waitUntilDone:(BOOL)wait, ...;

- (id)performSelectorWithArgs:(SEL)sel onThread:(NSThread *)thread waitUntilDone:(BOOL)wait, ...;

- (void)performSelectorWithArgsInBackground:(SEL)sel, ...;

- (void)performSelector:(SEL)sel afterDelay:(NSTimeInterval)delay;


#pragma mark - Swap method (Swizzling)

+ (BOOL)swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;

+ (BOOL)swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;


#pragma mark - Associate value

- (void)setAssociateValue:(id)value withKey:(void *)key;

- (void)setAssociateWeakValue:(id)value withKey:(void *)key;

- (id)getAssociatedValueForKey:(void *)key;

- (void)removeAssociatedValues;


#pragma mark - Others

+ (NSString *)className;

- (NSString *)className;

- (id)deepCopy;

- (id)deepCopyWithArchiver:(Class)archiver unarchiver:(Class)unarchiver;


@end
