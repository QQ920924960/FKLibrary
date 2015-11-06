//
//  UIBarButtonItem+Category_FK.h
//  FKLibraryExample
//
//  Created by frank on 15/11/2.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Category_FK)

/**
 *  通过传入图片名设置按钮来自定义UIBarButtonItem
 *
 *  @param imageName     普通状态图片名
 *  @param highImageName 高亮状态图片名
 *  @param target        接受点击事件的目标
 *  @param action        点击事件
 *
 *  @return 自定义的UIBarButtonItem
 */
+ (UIBarButtonItem *)FKItemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;

@end
