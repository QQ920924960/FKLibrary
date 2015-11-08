//
//  FKFilterView.m
//  FKLibraryExample
//
//  Created by frank on 15/11/8.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "FKFilterView.h"

@implementation FKFilterView

- (void)setImage:(UIImage *)image
{
    _image = image;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [self.image drawInRect:rect];
}

@end
