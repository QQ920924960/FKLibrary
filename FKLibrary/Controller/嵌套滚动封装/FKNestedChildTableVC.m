//
//  FKNestedChildTableVC.m
//  HappyTest
//
//  Created by Macbook Pro on 2019/2/15.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

#import "FKNestedChildTableVC.h"

@interface FKNestedChildTableVC ()

@property (nonatomic, assign) BOOL canScroll;

@end

@implementation FKNestedChildTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.autoresizingMask = UIViewAutoresizingNone;
    //子控制器视图到达顶部的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"goTop" object:nil];
    //子控制器视图离开顶部的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"leaveTop" object:nil];
    //返回顶部的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"SegementVCBackToTop" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private Methods
- (void)acceptMsg:(NSNotification *)notification
{
    NSString *notificationName = notification.name;
    if ([notificationName isEqualToString:@"goTop"]) {
        NSDictionary *userInfo = notification.userInfo;
        NSString *canScroll = userInfo[@"canScroll"];
        if ([canScroll isEqualToString:@"1"]) {
            self.canScroll = YES;
            self.tableView.showsVerticalScrollIndicator = YES;
        } else {
            self.canScroll = NO;
            self.tableView.showsVerticalScrollIndicator = NO;
        }
    } else if ([notificationName isEqualToString:@"leaveTop"]){
        self.canScroll = NO;
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.contentOffset = CGPointZero;
    } else if ([notificationName isEqualToString:@"SegementVCBackToTop"]) {
        [self.tableView setContentOffset:CGPointZero];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.canScroll) {
        [scrollView setContentOffset:CGPointZero];
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY <= 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil userInfo:@{@"canScroll" : @"1"}];
    }
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


@end
