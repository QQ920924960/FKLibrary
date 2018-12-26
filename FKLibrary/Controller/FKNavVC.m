//
//  FKNavVC.m
//  TextOCR
//
//  Created by frank on 2018/12/22.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

#import "FKNavVC.h"

@interface FKNavVC ()

@end

@implementation FKNavVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 解决右滑手势失效的问题
    __weak typeof(self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = (id)weakSelf;
        self.delegate = (id)weakSelf;
    }
}

+ (void)initialize
{
    // 设置NavigationBar的主题
    [self setupNavigationBarTheme];
    
    //设置UIBarButtonItem的主题
    [self setupBarButtonItemTheme];
}

/** 设置NavigationBar的主题 */
+ (void)setupNavigationBarTheme
{
    UINavigationBar * navigationBar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    
    //设计值导航条背景
    navigationBar.barTintColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    navigationBar.translucent=NO;
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_white"] forBarMetrics:UIBarMetricsDefault];
    
    //设置文字属性
    NSMutableDictionary * textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [navigationBar setTitleTextAttributes:textAttrs];
}

/** 设置UIBarButtonItem的主题 */
+ (void)setupBarButtonItemTheme
{
    //设置整个项目所有item的主题格式
    UIBarButtonItem * item = [UIBarButtonItem appearance];
    
    // 设置普通状态
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    //    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置不可用状态
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    //    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
    disableTextAttrs[NSFontAttributeName] = textAttrs[NSFontAttributeName];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}

/**
 重写这个方法的目的：能够拦截所有push进来的控制器
 
 @param viewController 即将push进来的控制器
 @param animated 是否需要动画
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 这时push进来的控制器，不是第一个子控制器（不是根控制器）
        // 自动显示和隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        // 设置左边的返回按钮
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"back_arrow"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        backBtn.frame = CGRectMake(0, 0, 44, 44);
        backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    }
    [super pushViewController:viewController animated:animated];
    
//    // 解决iPhone X下push导致tabbar上移的情况
//    if (iPhoneX) {
//        // 修改tabBra的frame
//        CGRect frame = self.tabBarController.tabBar.frame;
//        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
//        self.tabBarController.tabBar.frame = frame;
//    }
}

/**
 点击左边返回按钮
 */
- (void)back
{
    [self popViewControllerAnimated:YES];
}


@end
