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

#ifdef DEBUG // 调试状态, 打开LOG功能
#define FKLog(...) NSLog(__VA_ARGS__)
#else // 发布状态, 关闭LOG功能
#define FKLog(...)
#endif


/** RGBA颜色 */
#define FKRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// RGB颜色
#define FKRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define FKRandomColor FKRGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

// 当前系统版本号
#define FKSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]

// 屏幕宽度
#define FKScreenW [UIScreen mainScreen].bounds.size.width
// 屏幕高度
#define FKScreenH [UIScreen mainScreen].bounds.size.height

/** 沙盒路径 */
#define FKFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

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
