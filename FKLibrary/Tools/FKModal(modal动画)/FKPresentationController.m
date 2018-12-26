//
//  FKPresentationController.m
//  FKLibraryExample
//
//  Created by frank on 15/11/7.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "FKPresentationController.h"

@implementation FKPresentationController

- (void)presentationTransitionWillBegin
{
    //    NSLog(@"presentationTransitionWillBegin");
    
    self.presentedView.frame = self.containerView.bounds;
    [self.containerView addSubview:self.presentedView];
    
}

- (void)presentationTransitionDidEnd:(BOOL)completed
{
    //    NSLog(@"presentationTransitionDidEnd");
}

- (void)dismissalTransitionWillBegin
{
    //    NSLog(@"dismissalTransitionWillBegin");
}

- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    //    NSLog(@"dismissalTransitionDidEnd");
    [self.presentedView removeFromSuperview];
}

@end
