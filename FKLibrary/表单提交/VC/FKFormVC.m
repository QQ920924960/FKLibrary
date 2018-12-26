//
//  FKFormVC.m
//  BaiYeMallShop
//
//  Created by frank on 2018/11/27.
//  Copyright © 2018 凯叔叔. All rights reserved.
//

#import "FKFormVC.h"
#import "FKBaseFormCell.h"
#import "FKFormSectionView.h"

@interface FKFormVC ()

@end

@implementation FKFormVC

- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:style];
}

- (NSArray *)datas
{
    if (!_datas) {
        _datas = [NSArray array];
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag | UIScrollViewKeyboardDismissModeInteractive;
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fkScreenW, 0.01)];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fkScreenW, 140)];
    UIButton *confirmBtn = [UIButton fk_btnWithTarget:self action:@selector(confirmBtnClicked:) font:fk_adjustFont(14) normalTitle:@"确定" normalTitleColor:[UIColor whiteColor] selectedTitle:nil selectedTitleColor:nil normalImg:nil selectedImg:nil bgImg:[UIImage fk_imageWithColor:fkMainColor] selectedBgImg:nil];
    [footerView addSubview:confirmBtn];
    confirmBtn.frame = CGRectMake(20, 40, fkScreenW - 40, 46);
    [confirmBtn fk_viewCornerRadius:23 borderWidth:0 borderColor:nil];
    self.tableView.tableFooterView = footerView;
}

- (void)confirmBtnClicked:(UIButton *)btn
{
    [self.view endEditing:true];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableDictionary *group = self.datas[section];
    NSArray *items = group[@"items"];
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *group = self.datas[indexPath.section];
    NSArray *items = group[@"items"];
    NSMutableDictionary *item = items[indexPath.row];
    FKBaseFormCell *cell = [FKBaseFormCell cellWith:tableView className:item[@"cellName"]];
    cell.item = item;
//    cell.delegate = self;
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSMutableDictionary *group = self.datas[section];
//    return group[@"header"] ? : @"";
//    //    return @" ";
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
//{
//    return @" ";
//}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *group = self.datas[indexPath.section];
    NSMutableDictionary *item = group[@"items"][indexPath.row];
    return [item[@"cellH"] floatValue];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:true];
//    NSMutableDictionary *group = self.datas[indexPath.section];
//    NSMutableDictionary *item = group[@"items"][indexPath.row];
//    if (item.itemOperation) {
//        item.itemOperation();
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSMutableDictionary *group = self.datas[section];
    CGFloat headerH = [group[@"headerH"] floatValue];
    return headerH == 0 ? 10 : headerH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSMutableDictionary *group = self.datas[section];
    CGFloat footerH = [group[@"footerH"] floatValue];
    return footerH == 0 ? 0.01 : footerH;
//    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    FKFormSectionView *header = [FKFormSectionView sectionView:tableView];
    header.group = self.datas[section];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    FKFormSectionView *footer = [FKFormSectionView sectionView:tableView];
    footer.group = self.datas[section];
    return footer;
}


@end
