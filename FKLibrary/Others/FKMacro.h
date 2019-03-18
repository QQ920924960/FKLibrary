//
//  FKConst.m
//  FKLibraryExample
//
//  Created by frank on 15/11/6.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#ifndef _5______Macro_h
#define _5______Macro_h

/***************** begin *****************/


// 是否是刘海屏
#define fkIsFringe ([UIApplication sharedApplication].statusBarFrame.size.height == 44)
#define fkScreenW  [UIScreen mainScreen].bounds.size.width
#define fkScreenH  [UIScreen mainScreen].bounds.size.height
#define fkOffsetTop (fkIsFringe ? 24.f : 0.f)
#define fkOffsetBottom (fkIsFringe ? 34.f : 0.f)
// 状态栏高度
#define fkStatusBarH [UIApplication sharedApplication].statusBarFrame.size.height
// 导航栏高度
#define fkNavBarH 44
// 状态栏和导航栏高度
#define fkStatusAndNaBarH (fkStatusBarH + fkNavBarH)
// tabbar高度
#define fkTabBarH 49
#define fkPushNav(x) [self.navigationController pushViewController:(x) animated:YES]
#define fkPopVC [self.navigationController popViewControllerAnimated:YES]


/** RGBA颜色 */
#define fkColorAlpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
// RGB颜色
#define fkColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 随机色
#define fkRandomColor fkColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define fkBgColor fkColor(245, 245, 245)
#define fkColor333333 fkColor(51, 51, 51)
#define fkColor666666 fkColor(102, 102, 102)
#define fkColor999999 fkColor(153, 153, 153)
#define fkColorCCCCCC fkColor(204, 204, 204)
#define fkColorB2B2B2 fkColor(178, 178, 178)
#define fkColorD2D2D2 fkColor(210, 210, 210)
#define fkColorAEAEAE fkColor(174, 174, 174)
#define fkColorEEEEEE fkColor(238, 238, 238)
#define fkColor808080 fkColor(128, 128, 128)
#define fkMainColor fkColor(74, 76, 91) // 主题色【蓝黑色】
#define fkPriceRed fkColor(251, 117, 110) // 价格的颜色

#define fkFont9 [UIFont systemFontOfSize:9.f]
#define fkFont10 [UIFont systemFontOfSize:10.f]
#define fkFont11 [UIFont systemFontOfSize:11.f]
#define fkFont12 [UIFont systemFontOfSize:12.f]
#define fkFont13 [UIFont systemFontOfSize:13.f]
#define fkFont14 [UIFont systemFontOfSize:14.f]
#define fkFont15 [UIFont systemFontOfSize:15.f]
#define fkFont16 [UIFont systemFontOfSize:16.f]
#define fkFont17 [UIFont systemFontOfSize:17.f]
#define fkFont18 [UIFont systemFontOfSize:18.f]
#define fkFont19 [UIFont systemFontOfSize:19.f]
#define fkFont20 [UIFont systemFontOfSize:20.f]
#define fkFont22 [UIFont systemFontOfSize:22.f]

#define fkBold12 [UIFont boldSystemFontOfSize:12]
#define fkBold13 [UIFont boldSystemFontOfSize:13]
#define fkBold14 [UIFont boldSystemFontOfSize:14]
#define fkBold15 [UIFont boldSystemFontOfSize:15]
#define fkBold16 [UIFont boldSystemFontOfSize:16]
#define fkBold17 [UIFont boldSystemFontOfSize:17]
#define fkBold18 [UIFont boldSystemFontOfSize:18]
#define fkBold20 [UIFont boldSystemFontOfSize:20]
#define fkBold24 [UIFont boldSystemFontOfSize:24]

#define kPlaceholder_1x1 [UIImage imageNamed:@"placeholder_1x1"]
#define kPlaceholder_2x1 [UIImage imageNamed:@"placeholder_2x1"]
#define kPlaceholder_3x1 [UIImage imageNamed:@"placeholder_3x1"]
#define kPlaceholder_5x2 [UIImage imageNamed:@"placeholder_5x2"]
#define kPlaceholder_15x4 [UIImage imageNamed:@"placeholder_15x4"]
#define kDefaultAvatar [UIImage imageNamed:@"default_avatar"]

/** 字体适配 */
static inline UIFont * fk_adjustFont(CGFloat fontSize) {
    if (fkScreenW == 320) {
        return [UIFont systemFontOfSize:fontSize - 2];
    } else if (fkScreenW == 375) {
        return [UIFont systemFontOfSize:fontSize];
    } else {
        return [UIFont systemFontOfSize:fontSize + 1];
    }
}
static inline UIFont * fk_adjustBoldFont(CGFloat fontSize) {
    if (fkScreenW == 320) {
        return [UIFont boldSystemFontOfSize:fontSize - 2];
    } else if (fkScreenW == 375) {
        return [UIFont boldSystemFontOfSize:fontSize];
    } else {
        return [UIFont boldSystemFontOfSize:fontSize + 1];
    }
}
static inline CGFloat fk_adjustW(CGFloat w) {
    return w * ([UIScreen mainScreen].bounds.size.width / 375.0);
}
//打电话
static inline void fk_call(NSString *number) {
    if (@available(ios 10.0,*)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", number ? : @""]] options:@{} completionHandler:nil];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", number ? : @""]]];
#pragma clang diagnostic pop
    }
}

// 字符串初始化
#define fkFORMAT(f, ...) [NSString stringWithFormat:f, ## __VA_ARGS__]

#ifdef DEBUG
# define FKLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define FKLog(...);
#endif

//#ifdef DEBUG // 调试状态, 打开LOG功能
//#define FKLog(...) NSLog(__VA_ARGS__)
//#else // 发布状态, 关闭LOG功能
//#define FKLog(...)
//#endif

#define fkWeakSelf(type)  __weak typeof(type) weak##type = type;

// 当前系统版本号
#define fkSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]

/** 沙盒路径 */
#define fkFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

/** 过期提醒
 *  @param instead 需要给用户提醒的话
 */
#define fkDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)


/**
 Add this macro before each category implementation, so we don't have to use
 -all_load or -force_load to load object files from static libraries that only
 contain categories and no classes.
 【添加这个宏在每个类别的实现,所以我们不需要使用-all_load或-force_load加载对象文件,只有从静态库
 包含类别和没有类。】
 More info: http://developer.apple.com/library/mac/#qa/qa2006/qa1490.html .
 *******************************************************************************
 Example:
 FKSYNTH_DUMMY_CLASS(NSString_FK)
 */
#ifndef FKSYNTH_DUMMY_CLASS
#define FKSYNTH_DUMMY_CLASS(_name_) \
@interface FKSYNTH_DUMMY_CLASS_ ## _name_ : NSObject @end \
@implementation FKSYNTH_DUMMY_CLASS_ ## _name_ @end
#endif


/***************** end *****************/

#endif
