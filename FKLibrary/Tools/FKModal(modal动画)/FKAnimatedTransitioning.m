//
//  FKAnimatedTransitioning.m
//  FKLibraryExample
//
//  Created by frank on 15/11/7.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "FKAnimatedTransitioning.h"


static CGFloat const duration = 1.0;

@implementation FKAnimatedTransitioning


#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    if (self.presented) {
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        [self changeViewX:toView value:toView.frame.size.width];
        // 为了使代码没有耦合性,就不采用下面的写法了【需要导入UIView的分类】
//        toView.frame.origin.x = toView.frame.size.width;
        [UIView animateWithDuration:duration animations:^{
            [self changeViewX:toView value:0];
//            toView.layer.transform = CATransform3DIdentity;
            // 为了使代码没有耦合性,就不采用下面的写法了【需要导入UIView的分类】
//            toView.frame.origin.x = 0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        [UIView animateWithDuration:duration animations:^{
            UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
            [self changeViewX:fromView value:fromView.frame.size.width];
            // 为了使代码没有耦合性,就不采用下面的写法了【需要导入UIView的分类】
//            fromView.frame.origin.x = fromView.frame.size.width;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}

- (void)changeViewX:(UIView *)view value:(CGFloat)value
{
    CGRect tempFrame = view.frame;
    tempFrame.origin.x = value;
    view.frame = tempFrame;
}

@end
