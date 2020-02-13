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
    
    BOOL isHEIF = [XTImageItem imageIsHeicType:info];
    if (isHEIF) {
        if (@available(iOS 11.0, *)) {
            PHAsset *asset = [info objectForKey:UIImagePickerControllerPHAsset] ;                        
            [asset requestContentEditingInputWithOptions:nil completionHandler:^(PHContentEditingInput * _Nullable contentEditingInput, NSDictionary * _Nonnull info) {
                if (contentEditingInput.fullSizeImageURL) {
                    // heic to jpeg
                    CIImage *ciImage = [CIImage imageWithContentsOfURL:contentEditingInput.fullSizeImageURL];
                    CIContext *context = [CIContext context];
                    NSData *jpgData = [context JPEGRepresentationOfImage:ciImage colorSpace:ciImage.colorSpace options:@{}];
                    XTImageItem *item = [[XTImageItem alloc] initWithData:jpgData info:info] ;
                    item.image = [UIImage imageWithData:jpgData] ;
                    item.imgType = XTImageItem_type_jpeg ; // heic to jpeg
                    self.blkPhoto(item);
                    [picker dismissViewControllerAnimated:YES completion:nil];
                    picker.delegate = nil;
                    return;
                }
            }];
        } else {
            // Fallback on earlier versions
        }
    }
    else {
        // Fallback on earlier versions
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (image.imageOrientation != UIImageOrientationUp) {
            UIGraphicsBeginImageContext(image.size);
            [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        XTImageItem *item = [[XTImageItem alloc] initWithImage:image info:info];
        item.data = UIImageJPEGRepresentation(image, 1.0);
        self.blkPhoto(item);
        [picker dismissViewControllerAnimated:YES completion:nil];
        picker.delegate = nil;
    }
    
    
    
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    self.blkPhoto(nil);
    [picker dismissViewControllerAnimated:YES completion:nil];
    picker.delegate = nil;
}


@end
