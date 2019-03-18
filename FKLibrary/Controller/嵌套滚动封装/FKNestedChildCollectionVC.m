//
//  FKNestedChildCollectionVC.m
//  HappyTest
//
//  Created by Macbook Pro on 2019/2/16.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

#import "FKNestedChildCollectionVC.h"

@interface FKNestedChildCollectionVC ()

@property (nonatomic, assign) BOOL canScroll;

@end

@implementation FKNestedChildCollectionVC

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.layout = layout;
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.autoresizingMask = UIViewAutoresizingNone;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
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
            self.collectionView.showsVerticalScrollIndicator = YES;
        } else {
            self.canScroll = NO;
            self.collectionView.showsVerticalScrollIndicator = NO;
        }
    } else if ([notificationName isEqualToString:@"leaveTop"]){
        self.canScroll = NO;
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.contentOffset = CGPointZero;
    } else if ([notificationName isEqualToString:@"SegementVCBackToTop"]) {
        [self.collectionView setContentOffset:CGPointZero];
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

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}


@end
