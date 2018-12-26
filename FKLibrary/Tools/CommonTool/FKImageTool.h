//
//  FKImageTool.h
//  FKLibraryExample
//
//  Created by frank on 2018/9/7.
//  Copyright © 2018年 zmosa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FKSingleton.h"

@interface FKImageTool : NSObject <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

FKSingletonH

@property(nonatomic, copy) void(^getImageBlock) (UIImage *image);

- (void)fk_showImageActionSheet;

@end
