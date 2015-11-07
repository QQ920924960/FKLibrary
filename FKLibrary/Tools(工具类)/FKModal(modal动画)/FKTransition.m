//
//  FKTransition.m
//  FKLibraryExample
//
//  Created by frank on 15/11/7.
//  Copyright © 2015年 zmosa. All rights reserved.
//  使用的时候只要导入这个类的头文件

#import "FKTransition.h"
#import "FKAnimatedTransitioning.h"
#import "FKPresentationController.h"

@implementation FKTransition

#pragma mark - UIViewControllerTransitioningDelegate
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return [[FKPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    FKAnimatedTransitioning *anim = [[FKAnimatedTransitioning alloc] init];
    anim.presented = YES;
    return anim;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    FKAnimatedTransitioning *anim = [[FKAnimatedTransitioning alloc] init];
    anim.presented = NO;
    return anim;
}

@end
