//
//  FKImageFilterVC.m
//  FKLibraryExample
//
//  Created by frank on 15/11/7.
//  Copyright © 2015年 zmosa. All rights reserved.
//  图片滤镜控制器

#import "FKImageFilterVC.h"
#import "FKLibrary.h"

@interface FKImageFilterVC ()
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UISlider *slider;
@property (nonatomic, strong) UIImage *image;
@end

@implementation FKImageFilterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *image = [UIImage imageNamed:@"profil_bg"];
    self.image = image;
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(20, 20, FKScreenW - 40, 400);
    imageView.backgroundColor = [UIColor yellowColor];
    imageView.image = self.image;
    [self.view addSubview:imageView];
    self.imageView = imageView;
    [self.imageView setNeedsDisplay];
    
    UISlider *slider = [[UISlider alloc] init];
    [slider setMinimumValue:0];
    [slider setMaximumValue:100];
    slider.userInteractionEnabled = YES;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    slider.frame = CGRectMake(20, CGRectGetMaxY(self.imageView.frame) + 20, FKScreenW - 40, 20);

    [self.view addSubview:slider];
    self.slider = slider;
}


- (void)sliderValueChanged:(UISlider *)slider
{
    if (self.slider.value < 100) {
        self.slider.value += 1;
    } else {
        self.slider.value -= 1;
    }
    NSLog(@"--%f--", self.slider.value);
    UIImage *newImage = [self.image fk_imageGaussianBlurWithBias:self.slider.value];
    self.imageView.image = newImage;
    NSLog(@"--%@--", self.imageView.image);
    NSLog(@"--sliderValueChanged--");
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self.slider beginTrackingWithTouch:touches withEvent:event];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"--didReceiveMemoryWarning--");
}



@end
