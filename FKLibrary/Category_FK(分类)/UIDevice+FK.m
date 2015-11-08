//
//  UIDevice+FK.m
//  FKLibraryExample
//
//  Created by frank on 15/11/7.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "UIDevice+FK.h"

@implementation UIDevice (FK)

+ (instancetype)device {
    /*
     //飞飞的iPhone4
     2015-05-06 16:32:54.676 NewWHWY2[635:60b] 手机序列号: 1FEFC44B-A5D9-446E-B3B1-7F43C7FE6842
     2015-05-06 16:32:54.773 NewWHWY2[635:60b] 手机别名: mingxuan的 iPhone
     2015-05-06 16:32:54.777 NewWHWY2[635:60b] 设备名称: iPhone OS
     2015-05-06 16:32:54.779 NewWHWY2[635:60b] 手机系统版本: 7.1.2
     2015-05-06 16:32:54.781 NewWHWY2[635:60b] 手机型号: iPhone
     2015-05-06 16:32:54.783 NewWHWY2[635:60b] 国际化区域名称: iPhone
     2015-05-06 16:32:54.785 NewWHWY2[635:60b] 当前应用名称：维护无忧
     2015-05-06 16:32:54.787 NewWHWY2[635:60b] 当前应用软件版本:2.0.1
     2015-05-06 16:32:54.789 NewWHWY2[635:60b] 当前应用版本号码：1
     2015-05-06 16:32:54.794 NewWHWY2[635:60b]  -----------------------------
     2015-05-06 16:32:54.796 NewWHWY2[635:60b]  --- iPhone 4 (A1332)
     */
    
    /*
     //刘工的iPhone6
     2015-05-06 11:29:13.883 NewWHWY2[2078:1291201] 型号 --- iPhone
     2015-05-06 11:29:13.884 NewWHWY2[2078:1291201] 名字 --- kevin
     2015-05-06 11:29:13.884 NewWHWY2[2078:1291201] 本地化版本的型号 --- iPhone
     2015-05-06 11:29:13.885 NewWHWY2[2078:1291201] 系统名称 --- iPhone OS
     2015-05-06 11:29:13.885 NewWHWY2[2078:1291201] 系统版本 --- 8.1.3
     */
    /*
     杨总的iPhone6
     2015-05-06 16:24:11.817 NewWHWY2[6154:3887051] 手机序列号: A9546F7B-7A2C-49E2-A886-8C22BD0E71EA
     2015-05-06 16:24:11.820 NewWHWY2[6154:3887051] 手机别名: liang的 iPhone
     2015-05-06 16:24:11.821 NewWHWY2[6154:3887051] 设备名称: iPhone OS
     2015-05-06 16:24:11.821 NewWHWY2[6154:3887051] 手机系统版本: 8.2
     2015-05-06 16:24:11.821 NewWHWY2[6154:3887051] 手机型号: iPhone
     2015-05-06 16:24:11.821 NewWHWY2[6154:3887051] 国际化区域名称: iPhone
     2015-05-06 16:24:11.822 NewWHWY2[6154:3887051] 当前应用名称：维护无忧
     2015-05-06 16:24:11.822 NewWHWY2[6154:3887051] 当前应用软件版本:2.0.1
     2015-05-06 16:24:11.822 NewWHWY2[6154:3887051] 当前应用版本号码：1
     2015-05-06 16:24:11.822 NewWHWY2[6154:3887051] -----------------------------
     2015-05-06 16:24:11.822 NewWHWY2[6154:3887051]  --- iPhone 6 (A1549/A1586)
     */
    /*
     iPhone5s
     2015-05-06 16:25:59.935 NewWHWY2[2053:676051] 手机序列号: 7DF3F56F-093C-472B-8413-EB9DCD829F96
     2015-05-06 16:25:59.937 NewWHWY2[2053:676051] 手机别名: “LIFEIHENG”的 iPhone
     2015-05-06 16:25:59.938 NewWHWY2[2053:676051] 设备名称: iPhone OS
     2015-05-06 16:25:59.938 NewWHWY2[2053:676051] 手机系统版本: 8.1.3
     2015-05-06 16:25:59.938 NewWHWY2[2053:676051] 手机型号: iPhone
     2015-05-06 16:25:59.938 NewWHWY2[2053:676051] 国际化区域名称: iPhone
     2015-05-06 16:25:59.938 NewWHWY2[2053:676051] 当前应用名称：维护无忧
     2015-05-06 16:25:59.939 NewWHWY2[2053:676051] 当前应用软件版本:2.0.1
     2015-05-06 16:25:59.939 NewWHWY2[2053:676051] 当前应用版本号码：1
     2015-05-06 16:25:59.939 NewWHWY2[2053:676051]  -----------------------------
     2015-05-06 16:25:59.939 NewWHWY2[2053:676051]  --- iPhone 5s (A1457/A1518/A1528/A1530)
     */
    static UIDevice *device;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        device = [UIDevice currentDevice];
        
        //手机序列号
        device.uuidString = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        NSLog(@"手机序列号: %@",device.uuidString);
        //手机别名： 用户定义的名称
        device.userPhoneName = [[UIDevice currentDevice] name];
        NSLog(@"手机别名: %@", device.userPhoneName);
        //设备名称
        device.deviceName = [[UIDevice currentDevice] systemName];
        NSLog(@"设备名称: %@",device.deviceName );
        //手机系统版本
        device.phoneVersion = [[UIDevice currentDevice] systemVersion];
        NSLog(@"手机系统版本: %@", device.phoneVersion);
        //手机型号
        device.phoneModel = [[UIDevice currentDevice] model];
        NSLog(@"手机型号: %@",device.phoneModel);
        //地方型号  （国际化区域名称）
        device.localPhoneModel = [[UIDevice currentDevice] localizedModel];
        NSLog(@"国际化区域名称: %@",device.localPhoneModel);
        
        device.infoDictionary = [[NSBundle mainBundle] infoDictionary];
        // 当前应用名称
        device.appCurName = [device.infoDictionary objectForKey:@"CFBundleDisplayName"];
        NSLog(@"当前应用名称：%@",device.appCurName);
        // 当前应用软件版本  比如：1.0.1
        device.appCurVersion = [device.infoDictionary objectForKey:@"CFBundleShortVersionString"];
        NSLog(@"当前应用软件版本:%@",device.appCurVersion);
        // 当前应用版本号码   int类型
        device.appCurVersionNum = [device.infoDictionary objectForKey:@"CFBundleVersion"];
        NSLog(@"当前应用版本号码：%@",device.appCurVersionNum);
    });
    return device;
}

+ (NSString *)deviceModel {
    
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib,2,NULL,&len,NULL,0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    
    free(machine);
    NSLog(@"当前设备型号 --- %@",platform);
    if ([platform isEqualToString:@"iPhone1,1"]) return iPhone2G;
    if ([platform isEqualToString:@"iPhone1,2"]) return iPhone3G;
    if ([platform isEqualToString:@"iPhone2,1"]) return iPhone3GS;
    if ([platform isEqualToString:@"iPhone3,1"]) return iPhone4;
    if ([platform isEqualToString:@"iPhone3,2"]) return iPhone4;
    if ([platform isEqualToString:@"iPhone3,3"]) return iPhone4;
    if ([platform isEqualToString:@"iPhone4,1"]) return iPhone4S;
    if ([platform isEqualToString:@"iPhone5,1"]) return iPhone5;
    if ([platform isEqualToString:@"iPhone5,2"]) return iPhone5;
    if ([platform isEqualToString:@"iPhone5,3"]) return iPhone5c;
    if ([platform isEqualToString:@"iPhone5,4"]) return iPhone5c;
    if ([platform isEqualToString:@"iPhone6,1"]) return iPhone5s;
    if ([platform isEqualToString:@"iPhone6,2"]) return iPhone5s;
    if ([platform isEqualToString:@"iPhone7,1"]) return iPhone6Plus;
    if ([platform isEqualToString:@"iPhone7,2"]) return iPhone6;
    
    if ([platform isEqualToString:@"iPod1,1"])   return iPodTouch1G;
    if ([platform isEqualToString:@"iPod2,1"])   return iPodTouch2G;
    if ([platform isEqualToString:@"iPod3,1"])   return iPodTouch3G;
    if ([platform isEqualToString:@"iPod4,1"])   return iPodTouch4G;
    if ([platform isEqualToString:@"iPod5,1"])   return iPodTouch5G;
    
    if ([platform isEqualToString:@"iPad1,1"])   return iPad1G;
    if ([platform isEqualToString:@"iPad2,1"])   return iPad2;
    if ([platform isEqualToString:@"iPad2,2"])   return iPad2;
    if ([platform isEqualToString:@"iPad2,3"])   return iPad2;
    if ([platform isEqualToString:@"iPad2,4"])   return iPad2Chip;
    if ([platform isEqualToString:@"iPad2,5"])   return iPadMini1G;
    if ([platform isEqualToString:@"iPad2,6"])   return iPadMini1G;
    if ([platform isEqualToString:@"iPad2,7"])   return iPadMini1G;
    
    if ([platform isEqualToString:@"iPad3,1"])   return iPad3;
    if ([platform isEqualToString:@"iPad3,2"])   return iPad3;
    if ([platform isEqualToString:@"iPad3,3"])   return iPad3;
    if ([platform isEqualToString:@"iPad3,4"])   return iPad4;
    if ([platform isEqualToString:@"iPad3,5"])   return iPad4;
    if ([platform isEqualToString:@"iPad3,6"])   return iPad4;
    
    if ([platform isEqualToString:@"iPad4,1"])   return iPadAir;
    if ([platform isEqualToString:@"iPad4,2"])   return iPadAir;
    if ([platform isEqualToString:@"iPad4,3"])   return iPadAir;
    if ([platform isEqualToString:@"iPad4,4"])   return iPadMini2G;
    if ([platform isEqualToString:@"iPad4,5"])   return iPadMini2G;
    if ([platform isEqualToString:@"iPad4,6"])   return iPadMini2G;
    
    if ([platform isEqualToString:@"i386"])      return iPhoneSimulator;
    if ([platform isEqualToString:@"x86_64"])    return iPhoneSimulator;
    
    
    
    
    return platform;
}


@end
