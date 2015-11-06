//
//  ViewController.m
//  FKLibraryExample
//
//  Created by frank on 15/11/2.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "ViewController.h"
#import "FKLibrary.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *textButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 300, 600)];
    textButton.backgroundColor = [UIColor blackColor];
    
    
//    UIImage *circleImage = [UIImage FKImageClipToCircle:@"profil_bg" borderWidth:3 borderColor:[UIColor redColor]];
    UIImage *circleImage = [UIImage FKImageClipToCircle:[UIImage imageNamed:@"profil_bg"] inset:5];
    [textButton setImage:circleImage forState:UIControlStateNormal];
    
    [self.view addSubview:textButton];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"--didReceiveMemoryWarning--");
}

@end
