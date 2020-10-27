//
//  SHMLargeImgScroll+ScrollView.m
//  owl
//
//  Created by teason23 on 2020/7/7.
//  Copyright © 2020 shimo.im. All rights reserved.
//

#import "SHMLargeImgScroll+ScrollView.h"
#import "SHMLargeImgScroll+Util.h"

@implementation SHMLargeImgScroll (ScrollView)

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    CGRect zoomRect;
    zoomRect.size.height = self.container.frame.size.height / scale;
    zoomRect.size.width  = self.container.frame.size.width  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    return zoomRect;
}

#pragma mark - scrollview delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.container;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    XT_IN_MAINQUEUE(
    [self doBeforeTheProgress];
                     )
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    if (self.isOnReseting) {
        return;
    }
    
    self.isOnZooming = YES;

    [self doBeforeTheProgress];

    [self setupContainerFrame:self.container.frame];

    if (self.displayMode == SHMLargeImgScrollDisplayModeLarge && self.container.largeImageView.hidden) self.container.largeImageView.hidden = NO;

}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view {
    
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {
    SHM_LOG_DEBUG(@"🇩🇪zoom signal, scale: %f",scale);
    self.isOnZooming = scale > 1.0f || scrollView.isZooming ;
    
    [self.zoomSignal sendNext:@1];
    
    if (self.displayMode == SHMLargeImgScrollDisplayModeSmall) { // thumb
        self.container.imageView.alpha = 1.0f;
    } else { // large
        if (self.zoomScale == 1.0f) { // origin
            self.container.imageView.alpha = 1.0f;
            self.container.largeImageView.hidden = YES;
        } else {
            // [self.container.largeImageView setNeedsDisplay]; // fix:闪一下
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    SHM_LOG_DEBUG(@"🇯🇵zoom signal");
    if (!decelerate) [self.zoomSignal sendNext:@2];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    SHM_LOG_DEBUG(@"🇯🇵zoom signal");
    [self.zoomSignal sendNext:@3];
}

- (void)doBeforeTheProgress {
//    if (self.displayMode == SHMLargeImgScrollDisplayModeLarge) {
//        self.container.imageView.alpha = .9f; // 仅供测试看效果
//    }
}

- (void)doAfterTheProgress {
    if (self.displayMode == SHMLargeImgScrollDisplayModeSmall) { // thumb
        self.container.imageView.alpha = 1.0f;
    } else { // large
        if ( self.container.largeImageView.hidden ) self.container.largeImageView.hidden = NO;
    }
    SHM_LOG_DEBUG(@"⚽️当前状态:%ld,largeImgView.hidden=%d,ImgView.image=%d,largeImgView.image=%d",self.displayMode,self.container.largeImageView.hidden,self.container.imageView.image!=nil,self.container.largeImageView.image!=nil);
}

@end
