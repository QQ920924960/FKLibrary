//
//  UIImageView+FK.m
//  FKLibraryExample
//
//  Created by frank on 15/11/11.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "UIImageView+FK.h"

@implementation UIImageView (FK)

- (void)setSharpCornerChatWithPoint:(CGPoint)point
{
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.frame.size);
    // 取得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 等有时间了再完善
}

@end
