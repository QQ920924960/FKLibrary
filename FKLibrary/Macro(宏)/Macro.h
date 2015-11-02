//
//  Macro.h
//  05-屏幕截图
//
//  Created by frank on 15-11-1.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#ifndef _5______Macro_h
#define _5______Macro_h

#ifdef DEBUG // 调试状态, 打开LOG功能
#define FKLog(...) NSLog(__VA_ARGS__)
#else // 发布状态, 关闭LOG功能
#define FKLog(...)
#endif


/** RGBA颜色 */
#define FKRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// 颜色
#define FKRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define FKRandomColor FKRGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

// 当前系统版本号
#define FKSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]

#endif
