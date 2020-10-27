//
//  SHMLargeImgScroll+Util.m
//  owl
//
//  Created by teason23 on 2020/7/7.
//  Copyright © 2020 shimo.im. All rights reserved.
//

#import "SHMLargeImgScroll+Util.h"

@implementation SHMLargeImgScroll (Util)


#pragma mark - util

- (void)turnOnActivityIndicator:(BOOL)on {
    XT_IN_MAINQUEUE(
    if (on) {
        self.activityIndicator.hidden = NO;
        if (!self.activityIndicator.isAnimating) [self.activityIndicator startAnimating];
    } else {
        if (self.activityIndicator.isAnimating) [self.activityIndicator stopAnimating];
        self.activityIndicator.hidden = YES;
    }
                     )
    //SHM_LOG_DEBUG(@"❀ : %d", on);
}

- (void)resetScrollToOrigin {    
    [self resetScrollToOriginAnimated:NO];
    self.isOnZooming = NO;
}

- (void)resetScrollToOriginAnimated:(BOOL)animated {
    self.isOnReseting = YES;
    [self setZoomScale:1 animated:animated];
    [self setContentOffset:CGPointZero animated:animated];
    
    if (CGRectIsNull(self.originRect) || CGRectEqualToRect(self.originRect, CGRectZero)) {
        [self setupContainerFrame:self.container.frame];
    } else {
        self.container.frame = self.originRect;
        self.container.largeImageView.contentScaleFactor = 1.0;
    }
    
    self.isOnReseting = NO;
    SHM_LOG_DEBUG(@"\n\n%ld 🦆backto原始container: %@\n是否一致 %d\n",(long)self.myPhoto.idxOnView,NSStringFromCGRect(self.container.frame),CGRectEqualToRect(self.container.frame, self.originRect));
}

- (void)setupContainerFrame:(CGRect)frameToCenter {
    // setContainer frame
    CGSize boundsSize = [SHMDevice currentDevice].windowSize;
    if (CGSizeEqualToSize(CGSizeZero, boundsSize) || CGRectEqualToRect(CGRectZero, frameToCenter)) {
        return;
    }
    
    // center horizontally
    if (frameToCenter.size.width < boundsSize.width)
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2.0f;
    else frameToCenter.origin.x = 0.0f;
    // center vertically
    if (frameToCenter.size.height < boundsSize.height)
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2.0f;
    else frameToCenter.origin.y = 0.0f;
    
    
    self.container.frame = frameToCenter;
    SHM_LOG_DEBUG(@"%ld 🌞frameToCenter设置: %@",(long)self.myPhoto.idxOnView, NSStringFromCGRect(self.container.frame));
    self.container.largeImageView.contentScaleFactor = 1.0;
    // to handle the interaction between CATiledLayer and high resolution screens, we need to manually set the
    // tiling view's contentScaleFactor to 1.0. (If we omitted this, it would be 2.0 on high resolution screens,
    // which would cause the CATiledLayer to ask us for tiles of the wrong scales.)
}

/// getInfoFromImage Then SetContainerFrame
/// 1. 根据图片实际尺寸 和 屏幕尺寸 计算图片视图尺寸
/// @return tuple @[@(imageScale), @(imageRect)]
/// 2. 然后针对图片去setFrame
- (RACTuple *)getInfoFromImageThenSetContainerFrame:(UIImage *)img {
    if (img == nil || img.size.width == 0 || img.size.height == 0) {
        return nil;
    }
    
    CGRect imageRect = CGRectMake(0.0f,0.0f,img.size.width,img.size.height);
    CGFloat scaleW = [SHMDevice currentDevice].windowWidth / imageRect.size.width ;
    CGFloat scaleH = [SHMDevice currentDevice].windowHeight / imageRect.size.height ;
    CGFloat imageScale = MIN(scaleH, scaleW) ;
    imageRect.size = CGSizeMake(imageRect.size.width * imageScale, imageRect.size.height * imageScale) ;
    SHM_LOG_DEBUG(@"%ld 🐋getInfoFromImage: %@, %@",(long)self.myPhoto.idxOnView,@(imageScale),NSStringFromCGRect(imageRect));
    return RACTuplePack(@(imageScale),@(imageRect));
}

- (void)setupContainerFrameWithImage:(UIImage *)img {
    id res = [self getInfoFromImageThenSetContainerFrame:img];
    if (res != nil) {
        RACTupleUnpack(NSNumber *scaleNum, NSValue *rectVal) = res ;
        [self setupContainerFrame:rectVal.CGRectValue];
        if (CGRectEqualToRect(CGRectZero, self.originRect) || CGRectIsNull(self.originRect)) {
            self.originRect = self.container.frame;
        }
    }
}

- (BOOL)isRenderPhotoOnScreenCenter {
    if (self.callback) {
        SHMPhotoBrowser *browser = [self.callback fromBrowser];
        NSIndexPath *indexPath = [browser fetchCurrentIndexPath];
        if (self.myPhoto.idxOnView != indexPath.row) return NO;
    }
    return YES;
}

//[UIImage shm_spinImage:image rotation:orientation complete:complete];
/// get orientation
+ (UIImageOrientation)getUIImageOrientation:(NSInteger)spinRate {
    UIImageOrientation orientation = UIImageOrientationUp;
    switch (spinRate) {
        case 0: orientation = UIImageOrientationUp; break;
        case 1: orientation = UIImageOrientationRight; break;
        case 2: orientation = UIImageOrientationDown; break;
        case 3: orientation = UIImageOrientationLeft; break;
        default: break;
    }
    SHM_LOG_DEBUG(@"spinRate: %ld",(long)spinRate);
    return orientation;
}



@end
