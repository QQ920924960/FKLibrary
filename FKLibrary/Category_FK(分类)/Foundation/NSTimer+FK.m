//
//  NSTimer+FK.m
//  FKLibraryExample
//
//  Created by frank on 15/11/10.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "NSTimer+FK.h"

@implementation NSTimer (FK)

+ (void)fk_ExecBlock:(NSTimer *)timer {
    if ([timer userInfo]) {
        void (^block)(NSTimer *timer) = (void (^)(NSTimer *timer))[timer userInfo];
        block(timer);
    }
}

+ (NSTimer *)fk_scheduledTimerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats {
    return [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(fk_ExecBlock:) userInfo:[block copy] repeats:repeats];
}

+ (NSTimer *)fk_timerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats {
    return [NSTimer timerWithTimeInterval:seconds target:self selector:@selector(fk_ExecBlock:) userInfo:[block copy] repeats:repeats];
}


@end
