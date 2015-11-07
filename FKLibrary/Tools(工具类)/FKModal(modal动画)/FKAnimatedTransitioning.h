//
//  FKAnimatedTransitioning.h
//  FKLibraryExample
//
//  Created by frank on 15/11/7.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FKAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) BOOL presented;
@end
