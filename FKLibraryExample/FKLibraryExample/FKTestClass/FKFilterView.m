//
//  FKFilterView.m
//  FKLibraryExample
//
//  Created by frank on 15/11/8.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "FKFilterView.h"

@implementation FKFilterView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        self.contentMode = UIViewContentModeScaleAspectFit;
//        self.image = self.picture;
    }
    return self;
}

- (void)setPicture:(UIImage *)picture
{
    _picture = picture;
    self.image = picture;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [self.picture drawInRect:rect];
}

@end
