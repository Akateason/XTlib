//
//  XTPACropImageVC.m
//  XTlib
//
//  Created by teason23 on 2019/2/26.
//  Copyright © 2019 teason23. All rights reserved.
//

#import "XTPACropImageVC.h"


@interface XTPACropImageVC () <RSKImageCropViewControllerDelegate, RSKImageCropViewControllerDataSource>
@property (copy, nonatomic) BlkImageDidCropFinish blkDidCrop;
@end


@implementation XTPACropImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)dealloc {
    NSLog(@"XTPACropImageVC dealloc");
}

+ (void)showFromCtrller:(UIViewController *)fromCtrller
            imageOrigin:(UIImage *)image
   croppedImageCallback:(BlkImageDidCropFinish)blk {
    XTPACropImageVC *imageCropVC       = [[XTPACropImageVC alloc] initWithImage:image cropMode:(RSKImageCropModeCustom)];
    imageCropVC.moveAndScaleLabel.text = @"裁剪图片";
    [imageCropVC.cancelButton setTitle:@"取消" forState:0];
    [imageCropVC.chooseButton setTitle:@"选择" forState:0];
    imageCropVC.blkDidCrop = blk;

    imageCropVC.dataSource = imageCropVC;
    imageCropVC.delegate   = imageCropVC;
    [fromCtrller.navigationController pushViewController:imageCropVC animated:YES];
}


#pragma mark - RSKImageCropViewControllerDelegate

// Crop image has been canceled.
- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller {
    [self.navigationController popViewControllerAnimated:YES];
}

// The original image has been cropped. Additionally provides a rotation angle used to produce image.
- (void)imageCropViewController:(RSKImageCropViewController *)controller
                   didCropImage:(UIImage *)croppedImage
                  usingCropRect:(CGRect)cropRect
                  rotationAngle:(CGFloat)rotationAngle {
    [SVProgressHUD dismiss];
    //    self.imageView.image = croppedImage;
    self.blkDidCrop(croppedImage);

    [self.navigationController popViewControllerAnimated:YES];
}

// The original image will be cropped.
- (void)imageCropViewController:(RSKImageCropViewController *)controller
                  willCropImage:(UIImage *)originalImage {
    // Use when `applyMaskToCroppedImage` set to YES.
    [SVProgressHUD show];
}

#pragma mark - RSKImageCropViewControllerDataSource

// Returns a custom rect for the mask.
- (CGRect)imageCropViewControllerCustomMaskRect:(RSKImageCropViewController *)controller {
    CGSize aspectRatio = CGSizeMake(16.0f, 9.0f);

    CGFloat viewWidth  = CGRectGetWidth(controller.view.frame);
    CGFloat viewHeight = CGRectGetHeight(controller.view.frame);

    CGFloat maskWidth;
    if ([controller isPortraitInterfaceOrientation]) {
        maskWidth = viewWidth;
    }
    else {
        maskWidth = viewHeight;
    }

    CGFloat maskHeight;
    do {
        maskHeight = maskWidth * aspectRatio.height / aspectRatio.width;
        maskWidth -= 1.0f;
    } while (maskHeight != floor(maskHeight));

    maskWidth += 1.0f;

    CGSize maskSize = CGSizeMake(maskWidth, maskHeight);

    CGRect maskRect = CGRectMake((viewWidth - maskSize.width) * 0.5f,
                                 (viewHeight - maskSize.height) * 0.5f,
                                 maskSize.width,
                                 maskSize.height);

    return maskRect;
}

// Returns a custom path for the mask.
- (UIBezierPath *)imageCropViewControllerCustomMaskPath:(RSKImageCropViewController *)controller {
    CGRect rect    = controller.maskRect;
    CGPoint point1 = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGPoint point2 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGPoint point3 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGPoint point4 = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));

    UIBezierPath *rectangle = [UIBezierPath bezierPath];
    [rectangle moveToPoint:point1];
    [rectangle addLineToPoint:point2];
    [rectangle addLineToPoint:point3];
    [rectangle addLineToPoint:point4];
    [rectangle closePath];

    return rectangle;
}

// Returns a custom rect in which the image can be moved.
- (CGRect)imageCropViewControllerCustomMovementRect:(RSKImageCropViewController *)controller {
    if (controller.rotationAngle == 0) {
        return controller.maskRect;
    }
    else {
        CGRect maskRect       = controller.maskRect;
        CGFloat rotationAngle = controller.rotationAngle;

        CGRect movementRect = CGRectZero;

        movementRect.size.width  = CGRectGetWidth(maskRect) * fabs(cos(rotationAngle)) + CGRectGetHeight(maskRect) * fabs(sin(rotationAngle));
        movementRect.size.height = CGRectGetHeight(maskRect) * fabs(cos(rotationAngle)) + CGRectGetWidth(maskRect) * fabs(sin(rotationAngle));

        movementRect.origin.x = CGRectGetMinX(maskRect) + (CGRectGetWidth(maskRect) - CGRectGetWidth(movementRect)) * 0.5f;
        movementRect.origin.y = CGRectGetMinY(maskRect) + (CGRectGetHeight(maskRect) - CGRectGetHeight(movementRect)) * 0.5f;

        movementRect.origin.x = floor(CGRectGetMinX(movementRect));
        movementRect.origin.y = floor(CGRectGetMinY(movementRect));
        movementRect          = CGRectIntegral(movementRect);

        return movementRect;
    }
}


@end
