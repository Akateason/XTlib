//
//  XTCameraHandler.m
//  XTlib
//
//  Created by teason23 on 2019/2/27.
//  Copyright © 2019 teason23. All rights reserved.
//

#import "XTCameraHandler.h"


@interface XTCameraHandler () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (copy, nonatomic) BlkGetCameraPhoto blkPhoto;
@end


@implementation XTCameraHandler

- (void)openCameraFromController:(UIViewController *)controller takePhoto:(BlkGetCameraPhoto)blk {
    self.blkPhoto = blk;
    // here, check the device is available  or not
    BOOL bFail = ![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] || !controller;
    if (bFail) return;

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType               = UIImagePickerControllerSourceTypeCamera;
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    picker.allowsEditing = NO;
    picker.delegate      = self;
    [controller presentViewController:picker animated:YES completion:nil];
}

- (void)dealloc {
    NSLog(@"!!!!! handler dealloc !!!!!!");
}

#pragma mark - imagePickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (image.imageOrientation != UIImageOrientationUp) {
        UIGraphicsBeginImageContext(image.size);
        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    XTImageItem *item = [[XTImageItem alloc] initWithImage:image info:info];
    self.blkPhoto(item);
    [picker dismissViewControllerAnimated:YES completion:nil];
    picker.delegate = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    self.blkPhoto(nil);
    [picker dismissViewControllerAnimated:YES completion:nil];
    picker.delegate = nil;
}


@end
