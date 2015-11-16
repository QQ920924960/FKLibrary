//
//  FKTableViewVC.m
//  FKLibraryExample
//
//  Created by frank on 15/11/11.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "FKTableViewVC.h"
#import "FKTableViewCell.h"
#import "UIView+FK.h"
#import "FKPopView.h"

@interface FKTableViewVC() <FKTableViewCellDelegate, FKPopViewDelegate>

@end

@implementation FKTableViewVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor blueColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FKTableViewCell *cell = [FKTableViewCell cellWithTableView:tableView];
    cell.delegate = self;
    cell.textLabel.text = [NSString stringWithFormat:@"--%ld--", (long)indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark - FKTableViewCellDelegate

- (void)buttonDelegate:(FKTableViewCell *)fkTableViewCell button:(UIButton *)button
{
    NSLog(@"--buttonDelegate--");
//    CGRect buttonFrame = [button convertRect:button.frame toView:self.view];
//    CGPoint buttonPoint = [button convertPoint:button.frame.origin toView:self.view];
    CGRect buttonFrame = [fkTableViewCell fk_convertRect:button.frame toViewOrWindow:[[UIApplication sharedApplication].windows firstObject]];
    CGPoint buttonPoint = [fkTableViewCell fk_convertPoint:button.frame.origin toViewOrWindow:[[UIApplication sharedApplication].windows firstObject]];
    
    NSLog(@"--%f--%f--", buttonPoint.x, buttonPoint.y);
    NSLog(@"--%f--%f--%f--%f", buttonFrame.origin.x, buttonFrame.origin.y, buttonFrame.size.width, buttonFrame.size.height);
    
//    UIView *popView = [[UIView alloc] init];
//    popView.frame = (CGRect){buttonPoint, {50, 50}};
//    popView.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:popView];
    
    FKPopView *popView = [FKPopView popView];
    NSArray *images = @[@"share_more_pop_up_box_report", @"share_more_pop_up_box_report"];
    NSArray *titles = @[@"举报", @"取消关注"];
    [popView setImages:images titles:titles];
//    popView.firstBtnImage = [UIImage imageNamed:@"share_more_pop_up_box_report"];
    popView.delegate = self;
    [popView showWithPoint:buttonPoint];
    
}

#pragma mark - FKPopViewDelegate
- (void)coverBtnDelegate:(FKPopView *)popView button:(UIButton *)button
{
    [popView dismiss];
}

@end
