//
//  FKImageTool.m
//  FKLibraryExample
//
//  Created by frank on 2018/9/7.
//  Copyright © 2018年 zmosa. All rights reserved.
//

#import "FKImageTool.h"
#import <TZImagePickerController.h>


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
        
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if ((authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)) {
            NSDictionary *infoDict = [TZCommonTools tz_getInfoDictionary];
            // 无权限 做一个友好的提示
            NSString *appName = [infoDict valueForKey:@"CFBundleDisplayName"];
            if (!appName) appName = [infoDict valueForKey:@"CFBundleName"];
            
            NSString *message = [NSString stringWithFormat:[NSBundle tz_localizedStringForKey:@"Please allow %@ to access your camera in \"Settings -> Privacy -> Camera\""],appName];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSBundle tz_localizedStringForKey:@"Can not use camera"] message:message delegate:self cancelButtonTitle:[NSBundle tz_localizedStringForKey:@"Cancel"] otherButtonTitles:[NSBundle tz_localizedStringForKey:@"Setting"], nil];
            [alert show];
        } else if (authStatus == AVAuthorizationStatusNotDetermined) {
            // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // 已经开启授权，可继续
                        UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
                        imagePC.sourceType = UIImagePickerControllerSourceTypeCamera;
                        imagePC.allowsEditing = YES;
                        imagePC.delegate = self;
                        UIWindow *window = [UIApplication sharedApplication].delegate.window;
                        [window.rootViewController presentViewController:imagePC animated:YES completion:nil];
                    });
                }
            }];
        } else {
            // 已经开启授权，可继续
            UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
            imagePC.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePC.allowsEditing = YES;
            imagePC.delegate = self;
            UIWindow *window = [UIApplication sharedApplication].delegate.window;
            [window.rootViewController presentViewController:imagePC animated:YES completion:nil];
        }
        
        //        // 已经开启授权，可继续
        //        UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
        //        imagePC.sourceType = UIImagePickerControllerSourceTypeCamera;
        //        imagePC.allowsEditing = YES;
        //        imagePC.delegate = self;
        //        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        //        [window.rootViewController presentViewController:imagePC animated:YES completion:nil];
        
    } else {
        [SVProgressHUD showErrorWithStatus:@"无法调用相机"];
    }
}



// 图片库中查找图片
- (void)openPhotosBy
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
        imagePickerVc.allowCrop = true;
        CGFloat Y = (fkScreenH - fkScreenW) * 0.5;
        imagePickerVc.cropRect = CGRectMake(0, Y, fkScreenW, fkScreenW);
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            if (photos.count > 0) {
                if (self.getImageBlock) {
                    self.getImageBlock(photos.firstObject);
                }
            }
        }];
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        [window.rootViewController presentViewController:imagePickerVc animated:YES completion:nil];
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

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}


@end
