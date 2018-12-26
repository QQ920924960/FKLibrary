//
//  FKMapTool.m
//  HHShopping
//
//  Created by frank on 2018/10/24.
//  Copyright © 2018年 嘉瑞科技有限公司 - 凯叔叔. All rights reserved.
//

#import "FKMapTool.h"

@implementation FKMapTool

+ (void)showWith:(UIViewController *)superVC endPoint:(CLLocationCoordinate2D)endPoint
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
    
    
    [superVC fk_alertWithItems:maps confirm:^(NSString *title) {
        
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
