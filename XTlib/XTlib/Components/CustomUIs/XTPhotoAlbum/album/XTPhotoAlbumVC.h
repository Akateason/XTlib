//
//  XTPhotoAlbumVC.h
//  XTlib
//
//  Created by teason23 on 2019/2/26.
//  Copyright © 2019 teason23. All rights reserved.
//

#import <XTBase/XTBase.h>
#import <Photos/Photos.h>
#import "XTPAConfig.h"

NS_ASSUME_NONNULL_BEGIN

@class XTPhotoAlbumVC;

typedef void (^albumPickerGetImageListBlock)(NSArray<UIImage *> *imageList, NSArray<PHAsset *> *assetList, XTPhotoAlbumVC *albumVC);


@interface XTPhotoAlbumVC : RootCtrl


/**
 open album default
 *** this ctrller present into a navigationCtrller . ***
 */
+ (instancetype)openAlbumWithConfig:(XTPAConfig *)configuration
                        fromCtrller:(UIViewController *)fromVC
                          getResult:(albumPickerGetImageListBlock)resultBlk;


/**
 open album with pop Animation
 *** this ctrller present into a navigationCtrller . ***
 */
+ (instancetype)openAlbumWithConfig:(XTPAConfig *)configuration
                        fromCtrller:(UIViewController *)fromVC
                        willDismiss:(BOOL)willDismiss
                          getResult:(albumPickerGetImageListBlock)resultBlk;

@end

NS_ASSUME_NONNULL_END
