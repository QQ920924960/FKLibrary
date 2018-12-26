//
//  FKTabBarVC.m
//  TextOCR
//
//  Created by frank on 2018/12/22.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

#import "FKTabBarVC.h"
#import "FKNavVC.h"

@interface FKTabBarVC ()

@end

@implementation FKTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupViewControllers];
}

- (void)setupViewControllers
{
    [self addChildViewController:[[UIViewController alloc] init] title:@"工具箱" imageName:@"tool_box"];
    
    [self addChildViewController:[[UIViewController alloc] init] title:@"识别记录" imageName:@"scan_record"];
}

/**
 添加子控制器
 
 @param childVC 子控制器
 @param title 标题
 @param imageName 默认状态图片名称
 */
- (void)addChildViewController:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName
{
    childVC.title = title;
    
    // 设置子控制器的图片
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    NSString *selectedName = [NSString stringWithFormat:@"%@_selected", imageName];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = MiddleGray;
    //    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    //    selectTextAttrs[NSForegroundColorAttributeName] = MainColor;
    [childVC.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    //    [childVC.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    FKNavVC *nav = [[FKNavVC alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
}


@end
