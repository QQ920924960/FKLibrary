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

- (id)fk_performSelectorWithArgs:(SEL)sel, ...;

- (void)fk_performSelectorWithArgs:(SEL)sel afterDelay:(NSTimeInterval)delay, ...;

- (id)fk_performSelectorWithArgsOnMainThread:(SEL)sel waitUntilDone:(BOOL)wait, ...;

- (id)fk_performSelectorWithArgs:(SEL)sel onThread:(NSThread *)thread waitUntilDone:(BOOL)wait, ...;

- (void)fk_performSelectorWithArgsInBackground:(SEL)sel, ...;

- (void)fk_performSelector:(SEL)sel afterDelay:(NSTimeInterval)delay;


#pragma mark - Swap method (Swizzling)

+ (BOOL)fk_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;

+ (BOOL)fk_swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;


#pragma mark - Associate value

- (void)fk_setAssociateValue:(id)value withKey:(void *)key;

- (void)fk_setAssociateWeakValue:(id)value withKey:(void *)key;

- (id)fk_getAssociatedValueForKey:(void *)key;

- (void)fk_removeAssociatedValues;


#pragma mark - Others

+ (NSString *)fk_className;

- (NSString *)fk_className;

- (id)fk_deepCopy;

- (id)fk_deepCopyWithArchiver:(Class)archiver unarchiver:(Class)unarchiver;


@end
