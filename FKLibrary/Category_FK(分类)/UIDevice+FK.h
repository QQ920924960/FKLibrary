//
//  UIDevice+FK.h
//  FKLibraryExample
//
//  Created by frank on 15/11/7.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sys/sysctl.h>

static NSString *const iPhone2G        = @"iPhone 2G (A1203)";
static NSString *const iPhone3G        = @"iPhone 3G (A1241/A1324)";
static NSString *const iPhone3GS       = @"iPhone 3GS (A1303/A1325)";
static NSString *const iPhone4         = @"iPhone 4 (A1332)";
static NSString *const iPhone4S        = @"iPhone 4S (A1387/A1431)";
static NSString *const iPhone5         = @"iPhone 5 (A1428)";
static NSString *const iPhone5c        = @"iPhone 5c (A1456/A1532)";
static NSString *const iPhone5s        = @"iPhone 5s (A1453/A1533)";
static NSString *const iPhone6         = @"iPhone 6 (A1549/A1586)";
static NSString *const iPhone6Plus     = @"iPhone7,1";
static NSString *const iPodTouch1G     = @"iPod Touch 1G (A1213)";
static NSString *const iPodTouch2G     = @"iPod Touch 2G (A1288)";
static NSString *const iPodTouch3G     = @"iPod Touch 3G (A1318)";
static NSString *const iPodTouch4G     = @"iPod Touch 4G (A1367)";
static NSString *const iPodTouch5G     = @"iPod Touch 5G (A1421/A1509)";
static NSString *const iPad1G          = @"iPad 1G (A1219/A1337)";
static NSString *const iPad2           = @"iPad 2 (A1395/A1396/A1397)";
static NSString *const iPad2Chip       = @"iPad 2 (A1395+New Chip)";
static NSString *const iPadMini1G      = @"iPad Mini 1G (A1432/A1454/A1455)";
static NSString *const iPadMini2G      = @"iPad Mini 2G (A1489/A1490/A1491)";
static NSString *const iPad3           = @"iPad 3 (A1416/A1403/A1430)";
static NSString *const iPad4           = @"iPad 4 (A1458/A1459/A1460)";
static NSString *const iPadAir         = @"iPad Air (A1474/A1475/A1476)";
static NSString *const iPhoneSimulator = @"iPhone 模拟器";

@interface UIDevice (FK)

@property (copy, nonatomic) NSString* uuidString;//手机序列号

@property (copy, nonatomic) NSString *userPhoneName;

@property (copy, nonatomic) NSString *deviceName;//手机别名： 用户定义的名称

@property (copy, nonatomic) NSString *phoneVersion;//设备名称

@property (copy, nonatomic) NSString *phoneModel;//手机系统版本

@property (copy, nonatomic) NSString *localPhoneModel;//手机型号

@property (strong, nonatomic) NSDictionary *infoDictionary;

@property (copy, nonatomic) NSString *appCurName;// 当前应用名称

@property (copy, nonatomic) NSString *appCurVersion;// 当前应用软件版本  比如：1.0.1

@property (copy, nonatomic) NSString *appCurVersionNum;// 当前应用版本号码   int类型



/**
 *  获取当前设备信息
 */
+ (instancetype)device;

/**
 *  获取当前设备型号
 */
+ (NSString *)deviceModel;


@end
