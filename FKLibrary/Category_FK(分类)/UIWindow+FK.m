//
//  UIWindow+FK.m
//  FKLibraryExample
//
//  Created by frank on 15/11/7.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "UIWindow+FK.h"

@implementation UIWindow (FK)

static UIWindow *window;

+ (instancetype)fk_sharedWindow
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        window = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.backgroundColor = [UIColor whiteColor];
    });
    return window;
}

- (instancetype)fk_sharedWindow{
    if (!window) {
        window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return window;
}

+ (instancetype)fk_baseWindow {
    return [[[self class] alloc] fk_sharedWindow];
}

+ (void)fk_dismissWindow {
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
    [[self class] fk_dismissWindow];
}


@end
