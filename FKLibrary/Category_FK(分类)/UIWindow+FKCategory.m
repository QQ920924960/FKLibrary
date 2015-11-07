//
//  UIWindow+FKCategory.m
//  FKLibraryExample
//
//  Created by frank on 15/11/7.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "UIWindow+FKCategory.h"

@implementation UIWindow (FKCategory)

static UIWindow *window;

+ (instancetype)FKSharedWindow
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        window = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.backgroundColor = [UIColor whiteColor];
    });
    return window;
}

- (instancetype)FKSharedWindow{
    if (!window) {
        window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return window;
}

+ (instancetype)FKBaseWindow {
    return [[[self class] alloc] FKSharedWindow];
}

+ (void)FKDismissWindow {
    [UIView animateWithDuration:0.3f animations:^{
        window.alpha = 0.0f;
    } completion:^(BOOL finished) {
        window.hidden = YES;
        if (window) {
            window = nil;
        }
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [[self class] FKDismissWindow];
}


@end
