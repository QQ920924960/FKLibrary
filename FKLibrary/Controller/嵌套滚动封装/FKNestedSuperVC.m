//
//  FKNestedSuperVC.m
//  HappyTest
//
//  Created by Macbook Pro on 2019/2/15.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

#import "FKNestedSuperVC.h"
#import "FKPenetrateTouchTableView.h"

@interface FKNestedSuperVC ()<UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) BOOL canScroll; //mainTableView是否可以滚动

@end

@implementation FKNestedSuperVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FKPenetrateTouchTableView *tableView = [[FKPenetrateTouchTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    //注册允许外层tableView滚动通知-解决和分页视图的上下滑动冲突问题
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"leaveTop" object:nil];
}

#pragma mark - private
- (void)acceptMsg:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    
    if ([notification.name isEqualToString:@"leaveTop"]) {
        NSString *canScroll = userInfo[@"canScroll"];
        if ([canScroll isEqualToString:@"1"]) {
            self.canScroll = YES;
            self.tableView.showsVerticalScrollIndicator = YES;
        }
    }
}

- (void)fk_scrollViewDidScroll:(UIScrollView *)scrollView
{
//    [self scrollViewDidScroll:scrollView];
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 处理嵌套滚动
    if (offsetY >= self.criticalPointOffsetY) { // 吸顶状态
        scrollView.contentOffset = CGPointMake(0, self.criticalPointOffsetY);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"goTop" object:nil userInfo:@{@"canScroll":@"1"}];
        self.canScroll = NO;
        self.tableView.showsVerticalScrollIndicator = NO;
    } else {
        if (!self.canScroll) {
            //维持吸顶状态
            scrollView.contentOffset = CGPointMake(0, self.criticalPointOffsetY);
        } else {
            
        }
    }
}

//#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat offsetY = scrollView.contentOffset.y;
//    
//    // 处理嵌套滚动
//    if (offsetY >= self.criticalPointOffsetY) { // 吸顶状态
//        scrollView.contentOffset = CGPointMake(0, self.criticalPointOffsetY);
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"goTop" object:nil userInfo:@{@"canScroll":@"1"}];
//        self.canScroll = NO;
//        self.tableView.showsVerticalScrollIndicator = NO;
//    } else {
//        if (!self.canScroll) {
//            //维持吸顶状态
//            scrollView.contentOffset = CGPointMake(0, self.criticalPointOffsetY);
//        } else {
//            
//        }
//    }
//}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:[viewController isKindOfClass:[self class]] animated:YES];
}

- (void)dealloc {
    self.navigationController.delegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}



@end
