//
//  FKWebViewVC.m
//  FKLibraryExample
//
//  Created by frank on 2018/9/6.
//  Copyright © 2018年 zmosa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FKWebViewVC : UIViewController

@property (nonatomic, strong) NSURL *path;
@property (nonatomic, strong) NSDictionary *param;

+ (instancetype)webVCWithPath:(NSURL *)path title:(NSString *)title;

+ (instancetype)webVCWithPath:(NSURL *)path title:(NSString *)title param:(NSDictionary *)param;

@end
