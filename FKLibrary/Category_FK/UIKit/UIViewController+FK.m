//
//  UIViewController+FK.m
//  FKLibraryExample
//
//  Created by frank on 2018/9/15.
//  Copyright © 2018年 zmosa. All rights reserved.
//

#import "UIViewController+FK.h"

@implementation UIViewController (FK)

-(void)fk_alertWithTitle:(NSString *)title confirm:(void(^)(void))confirm
{
    [self fk_alertWithTitle:title message:nil confirmTitle:@"确定" confirm:confirm];
}

#pragma mark -Alert弹窗
-(void)fk_alertWithTitle:(NSString *)title message:(NSString *)message confirm:(void(^)(void))confirm
{
    [self fk_alertWithTitle:title message:message confirmTitle:@"确定" confirm:confirm];
}

-(void)fk_alertWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirm:(void(^)(void))confirm
{
    UIAlertController *alert = [UIAlertController  alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction=[UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            confirm();
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:cancelAction];
    [alert addAction:confirmAction];
    
    [cancelAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [confirmAction setValue:fkMainColor forKey:@"titleTextColor"];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)fk_alertWithItems:(NSArray *)items confirm:(void (^)(NSString *title))confirm
{
    UIAlertController *alert = [UIAlertController  alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSString *item in items) {
        UIAlertAction *itemAction = [UIAlertAction actionWithTitle:item style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (confirm) {
                confirm(action.title);
            }
        }];
        [alert addAction:itemAction];
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    alert.view.tintColor = fkColor333333;
    
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)fk_removeBeforeVC
{
    if (!self.navigationController) return;
    
    NSMutableArray *vcs = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    NSInteger count = vcs.count;
    if (count > 2) {
        UIViewController *beforeVC = vcs[count - 2];
        [vcs removeObject:beforeVC];
    }
    self.navigationController.viewControllers = vcs;
}

- (void)fk_showMapAlertWithEndPoint:(CLLocationCoordinate2D)endPoint
{
    NSArray *array = @[@{@"title" : @"用iPhone自带地图打开", @"url" : @"http://maps.apple.com/"},
                       @{@"title" : @"用高德地图打开", @"url" : @"iosamap://"},
                       @{@"title" : @"用百度地图打开", @"url" : @"baidumap://"},
                       @{@"title" : @"用腾讯地图打开", @"url" : @"qqmap://"}
                       //                       @{@"title" : @"用谷歌地图打开", @"url" : @"comgooglemaps://"}
                       ];
    NSMutableArray *maps = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:dict[@"url"]]]) {
            [maps addObject:dict[@"title"]];
        }
    }
    
    
    [self fk_alertWithItems:maps confirm:^(NSString *title) {
        
        NSString *externNaviURL;
        
        if ([title containsString:@"自带地图"]) {
            externNaviURL = [[NSString stringWithFormat:@"http://maps.apple.com/?daddr=%f,%f",endPoint.latitude, endPoint.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        } else if ([title containsString:@"高德"]) {
            externNaviURL = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&sid=BGVIS1&did=BGVIS2&dlat=%lf&dlon=%lf&dev=0&m=0&t=%@",@"--",endPoint.latitude,endPoint.longitude, @"car"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        } else if ([title containsString:@"百度"]) {
            externNaviURL = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=%@&coord_type=gcj02",endPoint.latitude, endPoint.longitude,@"driving"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        } else if ([title containsString:@"腾讯"]) {
            externNaviURL = [[NSString stringWithFormat:@"qqmap://map/routeplan?type=drive&from=我的位置&tocoord=%f,%f&referer=应用名称&coord_type=2&policy=0",endPoint.latitude,endPoint.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        
        // 跳转
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:externNaviURL]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:externNaviURL]];
        }
    }];
}

@end
