//
//  FKPenetrateTouchTableView.m
//  HappyTest
//
//  Created by Macbook Pro on 2019/1/17.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

#import "FKPenetrateTouchTableView.h"

@implementation FKPenetrateTouchTableView

/**
 同时识别多个手势
 
 @param gestureRecognizer gestureRecognizer description
 @param otherGestureRecognizer otherGestureRecognizer description
 @return return value description
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

@end
