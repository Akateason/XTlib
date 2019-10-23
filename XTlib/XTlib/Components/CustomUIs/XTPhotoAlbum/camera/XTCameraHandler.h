//
//  XTCameraHandler.h
//  XTlib
//
//  Created by teason23 on 2019/2/27.
//  Copyright © 2019 teason23. All rights reserved.
//
// ** RETAIN this instance. **

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <XTBase/XTBase.h>
#import "XTImageItem.h"

typedef void (^BlkGetCameraPhoto)(XTImageItem *_Nullable imageResult);

NS_ASSUME_NONNULL_BEGIN


@interface XTCameraHandler : NSObject
- (void)openCameraFromController:(UIViewController *)controller takePhoto:(BlkGetCameraPhoto)blk;
@end

NS_ASSUME_NONNULL_END
