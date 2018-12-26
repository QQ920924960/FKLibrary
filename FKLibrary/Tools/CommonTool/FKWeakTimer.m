//
//  FKWeakTimer.m
//  HHShopping
//
//  Created by frank on 2018/9/20.
//  Copyright © 2018年 嘉瑞科技有限公司 - 凯叔叔. All rights reserved.
//

#import "FKWeakTimer.h"

@implementation FKWeakTimer

+ (NSTimer *)fk_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                     target:(id)aTarget
                                   selector:(SEL)aSelector
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)repeats{
    FKWeakTimer *timer = [[FKWeakTimer alloc] init];
    timer.target = aTarget;
    timer.selector = aSelector;
    // 此处的target已经被换掉了不是原来的VIewController而是TimerWeakTarget类的对象timer
    timer.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:timer selector:@selector(fire:) userInfo:userInfo repeats:repeats];
    return timer.timer;
}

- (void)fire:(NSTimer *)timer
{
    if (self.target) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.selector withObject:timer.userInfo];
#pragma clang diagnostic pop
    } else {
        [self.timer invalidate];
    }
}

@end
