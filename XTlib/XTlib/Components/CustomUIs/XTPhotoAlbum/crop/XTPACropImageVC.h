//
//  XTPACropImageVC.h
//  XTlib
//
//  Created by teason23 on 2019/2/26.
//  Copyright © 2019 teason23. All rights reserved.
//

#import <XTBase/XTBase.h>
#import <RSKImageCropper/RSKImageCropper.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^BlkImageDidCropFinish)(UIImage *image);


@interface XTPACropImageVC : RSKImageCropViewController

+ (void)showFromCtrller:(UIViewController *)fromCtrller
            imageOrigin:(UIImage *)image
   croppedImageCallback:(BlkImageDidCropFinish)blk;

@end

NS_ASSUME_NONNULL_END
