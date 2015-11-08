//
//  FKImageFilterVC.m
//  FKLibraryExample
//
//  Created by frank on 15/11/7.
//  Copyright © 2015年 zmosa. All rights reserved.
//  图片滤镜控制器

#import "FKImageFilterVC.h"
#import "FKLibrary.h"
#import "FKFilterView.h"

@interface FKImageFilterVC ()
@property (nonatomic, weak) FKFilterView *filterView;
@property (nonatomic, weak) UISlider *slider;
@property (nonatomic, strong) UIImage *image;
@end

@implementation FKImageFilterVC

- (UIImage *)image
{
    if (!_image) {
        _image = [UIImage imageNamed:@"profil_bg"];
    }
    return _image;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    FKFilterView *filterView = [[FKFilterView alloc] init];
    filterView.frame = CGRectMake(20, 20, FKScreenW - 40, 400);
    filterView.image = self.image;
    [self.view addSubview:filterView];
    self.filterView = filterView;
    
    UISlider *slider = [[UISlider alloc] init];
    [slider setMinimumValue:0];
    [slider setMaximumValue:100];
    slider.userInteractionEnabled = YES;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    slider.frame = CGRectMake(20, CGRectGetMaxY(self.filterView.frame) + 20, FKScreenW - 40, 20);

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
    self.filterView.image = [self.image fk_imageGaussianBlurWithBias:(NSInteger)self.slider.value * 300];
    
    NSData *imageData = UIImagePNGRepresentation(self.filterView.image);
    
    if ((NSInteger)self.slider.value >= 90) {
        NSString *imageFilePath = FKFilePath;
        [imageData writeToFile:imageFilePath atomically:YES];
        NSLog(@"--writeToFile--");
    }
    
    
//    NSLog(@"--self.slider.value-%f--",self.slider.value);
//    NSLog(@"--%@--", self.filterView.image);
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
