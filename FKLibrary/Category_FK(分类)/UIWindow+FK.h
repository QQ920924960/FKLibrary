//
//  UIWindow+FK.h
//  FKLibraryExample
//
//  Created by frank on 15/11/7.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (FK)

+ (instancetype)fk_sharedWindow;
- (instancetype)fk_sharedWindow;



+ (instancetype)fk_baseWindow;

+ (void)fk_dismissWindow;

@end
