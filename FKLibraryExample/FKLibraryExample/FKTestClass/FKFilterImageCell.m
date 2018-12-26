//
//  FKFilterImageCell.m
//  FKLibraryExample
//
//  Created by frank on 15/11/9.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "FKFilterImageCell.h"
#import "FKMacro.h"
/** 图片的边距 */
static CGFloat const imageBoreder = 2;
/** 一屏展示图片的数量 */
static CGFloat const showImageCount = 7;

@interface FKFilterImageCell ()
@property (nonatomic, weak) UIButton *imageBtn;
@end

@implementation FKFilterImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *imageBtn = [[UIButton alloc] init];
        CGFloat imageBTnW = (fkScreenW - (showImageCount + 1) * imageBoreder) / showImageCount;
        imageBtn.backgroundColor = fkRandomColor;
        imageBtn.frame = CGRectMake(0, 0, imageBTnW, imageBTnW);
        [self.contentView addSubview:imageBtn];
        self.imageBtn = imageBtn;
    }
    return self;
}

@end
