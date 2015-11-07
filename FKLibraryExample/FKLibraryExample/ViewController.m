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
    
    
    UIButton *testButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 300, 600)];
    testButton.backgroundColor = [UIColor whiteColor];
    
    
//    UIImage *testImage = [UIImage FKImageClipToCircle:@"profil_bg" borderWidth:3 borderColor:[UIColor redColor]];
//    UIImage *testImage = [UIImage FKImageClipToCircle:[UIImage imageNamed:@"profil_bg"] inset:5];
//    UIImage *testImage = [UIImage FKImageWithColor:[UIColor redColor] size:CGSizeMake(150, 150)];
//    UIImage *testImage = [UIImage FKImageWithColor:[UIColor blueColor] view:testButton];
    UIImage *testImage = [UIImage FKImageGenerateQRCode:@"kaishushu" width:200 height:200];
    [testButton setImage:testImage forState:UIControlStateNormal];
    
    [testButton FKViewCornerRadius:0 borderWidth:10 borderColor:[UIColor blueColor]];
    [testButton FKButtonSetTitle:nil titleColor:nil font:nil forState:UIControlStateNormal];
//    [testButton setTitle:@"dfssadffs" forState:UIControlStateNormal];
//    [testButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    testButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:testButton];
    
    // 获取iOS系统自带的滤镜名称并写入文件
//    [self imageFilterWriteToFile];
    
    
    
    
}

/**
 *  获取iOS系统自带的滤镜名称并写入文件
 */
- (void)imageFilterWriteToFile
{
    NSString *filterNameFilePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"filterName.xml"];
    // 用于存放滤镜名字的数组
    NSMutableArray *filterNames = [NSMutableArray array];
    // 获取所有滤镜的名称
    NSArray *array =[CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    // 遍历所有滤镜名称
    [array enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL *stop) {
        NSString *newStr = [NSString stringWithFormat:@"%ld-%@\n", idx, str];
        [filterNames addObject:newStr];
    }];
    // 将滤镜名称写入文件中
    [filterNames writeToFile:filterNameFilePath atomically:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"--didReceiveMemoryWarning--");
}

@end
