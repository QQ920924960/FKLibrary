//
//  UIControl+FK.m
//  FKLibraryExample
//
//  Created by frank on 15/11/10.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "UIControl+FK.h"
#import <objc/runtime.h>


static const int block_key;

@interface FKUIControlBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);
@property (nonatomic, assign) UIControlEvents events;

- (id)initWithBlock:(void (^)(id sender))block events:(UIControlEvents)events;
- (void)invoke:(id)sender;

@end

@implementation FKUIControlBlockTarget

- (id)initWithBlock:(void (^)(id sender))block events:(UIControlEvents)events {
    self = [super init];
    if (self) {
        _block = [block copy];
        _events = events;
    }
    return self;
}

- (void)invoke:(id)sender {
    if (_block) _block(sender);
}

@end

@implementation UIControl (FK)

- (void)fk_removeAllTargets {
    [[self allTargets] enumerateObjectsUsingBlock: ^(id object, BOOL *stop) {
        [self   removeTarget:object
                      action:NULL
            forControlEvents:UIControlEventAllEvents];
    }];
}

- (void)fk_setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    NSSet *targets = [self allTargets];
    for (id currentTarget in targets) {
        NSArray *actions = [self actionsForTarget:currentTarget forControlEvent:controlEvents];
        for (NSString *currentAction in actions) {
            [self   removeTarget:currentTarget action:NSSelectorFromString(currentAction)
                forControlEvents:controlEvents];
        }
    }
    [self addTarget:target action:action forControlEvents:controlEvents];
}

- (void)fk_addBlockForControlEvents:(UIControlEvents)controlEvents
                           block:(void (^)(id sender))block {
    FKUIControlBlockTarget *target = [[FKUIControlBlockTarget alloc]
                                       initWithBlock:block events:controlEvents];
    [self addTarget:target action:@selector(invoke:) forControlEvents:controlEvents];
    NSMutableArray *targets = [self fk_allUIControlBlockTargets];
    [targets addObject:target];
}

- (void)fk_setBlockForControlEvents:(UIControlEvents)controlEvents
                           block:(void (^)(id sender))block {
    [self fk_removeAllBlocksForControlEvents:controlEvents];
    [self fk_addBlockForControlEvents:controlEvents block:block];
}

- (void)fk_removeAllBlocksForControlEvents:(UIControlEvents)controlEvents {
    NSMutableArray *targets = [self fk_allUIControlBlockTargets];
    NSMutableArray *removes = [NSMutableArray array];
    [targets enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        FKUIControlBlockTarget *target = (FKUIControlBlockTarget *)obj;
        if (target.events == controlEvents) {
            [removes addObject:target];
            [self   removeTarget:target
                          action:@selector(invoke:)
                forControlEvents:controlEvents];
        }
    }];
    [targets removeObjectsInArray:removes];
}

- (NSMutableArray *)fk_allUIControlBlockTargets {
    NSMutableArray *targets = objc_getAssociatedObject(self, &block_key);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(self, &block_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}


@end
