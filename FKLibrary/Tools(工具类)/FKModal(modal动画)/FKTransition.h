//
//  FKTransition.h
//  FKLibraryExample
//
//  Created by frank on 15/11/7.
//  Copyright © 2015年 zmosa. All rights reserved.
//  使用的时候只要导入这个类的头文件

#import <UIKit/UIKit.h>


@interface FKTransition : NSObject <UIViewControllerTransitioningDelegate>

/**
 *  单例对象
 */
+ (instancetype)sharedTransition;

@end
