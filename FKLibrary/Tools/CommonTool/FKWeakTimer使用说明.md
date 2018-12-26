```
#import "FKWeakTimer.h"
```

```
{
    NSTimer *timer;
}
```

```
- (void)dealloc
{
[self removeTimer];
}
```

```
#pragma mark - private
- (void)startTimer
{
[self removeTimer];
timer = [FKWeakTimer fk_scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:true];
[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
[timer fire];
}

- (void)updateTime
{
//    NSLog(@"----定时器开启----");
[kNotiCenter postNotificationName:RefreshOrderTime object:nil];
}

- (void)removeTimer
{
if (timer) [timer invalidate];
timer = nil;
}
```
