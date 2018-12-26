//
//  FKImageTool.m
//  FKLibraryExample
//
//  Created by frank on 2018/9/7.
//  Copyright © 2018年 zmosa. All rights reserved.
//

#import "FKImageTool.h"


@implementation FKImageTool

FKSingletonM

//弹出选项的方法
- (void)fk_showImageActionSheet
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *photos = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCameraBy];
    }];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openPhotosBy];
    }];
    
    [cancel setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [photos setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [camera setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    
    [alert addAction:photos];
    [alert addAction:camera];
    [alert addAction:cancel];
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window.rootViewController presentViewController:alert animated:YES completion:nil];
}

// 相机中选择
- (void)openCameraBy
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // 已经开启授权，可继续
        UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
        imagePC.sourceType = UIImagePickerControllerSourceTypeCamera;
        //            imagePC.allowsEditing = YES;
        imagePC.delegate = self;
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        [window.rootViewController presentViewController:imagePC animated:YES completion:nil];
    } else {
        [SVProgressHUD showErrorWithStatus:@"无法调用相机"];
    }
}

// 图片库中查找图片
- (void)openPhotosBy
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
        imagePC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePC.delegate = self;
        imagePC.allowsEditing = YES;
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        [window.rootViewController presentViewController:imagePC animated:YES completion:nil];
    } else {
        [SVProgressHUD showErrorWithStatus:@"暂无相册资源"];
    }
}



#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    if (self.getImageBlock) {
        self.getImageBlock(image);
    }
}


@end
