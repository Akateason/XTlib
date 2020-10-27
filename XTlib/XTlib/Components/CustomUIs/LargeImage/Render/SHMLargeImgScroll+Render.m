//
//  SHMLargeImgScroll+Render.m
//  owl
//
//  Created by teason23 on 2020/7/7.
//  Copyright © 2020 shimo.im. All rights reserved.
//

#import "SHMLargeImgScroll+Render.h"
#import "UIImage+SHMExtension.h"
#import "SHMLargeImgScroll+Util.h"
#import "UIImageView+SHMThumbnail.h"

@implementation SHMLargeImgScroll (Render)

#pragma mark - Render

- (void)renderGallaryPhoto:(void(^)(void))complete {
    SHM_LOG_DEBUG(@"mark");
    
    XT_IN_MAINQUEUE(
    switch (self.myPhoto.status) {
        case SHMGalleryImageStatusLoading: [self renderLoadingState];       break;
        case SHMGalleryImageStatusDone:    [self renderDoneState:complete]; break;
        case SHMGalleryImageStatusError:   [self renderErrorState];         break;
        default: break;
    }
                     )
}

- (void)renderLoadingState {
    SHM_LOG_DEBUG(@"mark");
    
    [self turnOnActivityIndicator:YES];
    [self showErrorViews:NO];
}

// 下载完成后,判断是否大图, 保存在本地. // 如果是大图,去生成缩略图.
- (void)renderDoneState:(void(^)(void))complete {
    SHM_LOG_DEBUG(@"mark");
    
    [self showErrorViews:NO];
            
    if (self.myPhoto.sizeMode == SHMGalleryImageSizeUnknown) { // 已下载, 未处理
        WEAK_SELF
        [self.myPhoto checkIsLargePhoto:^{
            STRONG_SELF
            XT_IN_MAINQUEUE(
                             [self renderPhoto:complete];
                             )
        }];
    } else { // 已下载, 已处理
        XT_IN_MAINQUEUE(
                         [self renderPhoto:complete];
                         )
    }
}

- (void)renderErrorState {
    [self turnOnActivityIndicator:NO];
        
    SHM_LOG_DEBUG(@"❌rn图片报错,%ld",(long)self.myPhoto.idxOnView);
    if (self.callback && [self.callback respondsToSelector:@selector(largeImageDownloadFailed)]) [self.callback largeImageDownloadFailed];
    
    [self.container clearAll];
    [self showErrorViews:YES];
}

- (void)renderPhoto:(void(^)(void))complete {
    NSInteger format = self.myPhoto.sdFormat;
    SHMGalleryPhoto *tmpPhoto = self.myPhoto;
    
    if (self.displayMode == SHMLargeImgScrollDisplayModeSmall) {        
        [self turnOnActivityIndicator:YES];
        
        SHM_LOG_DEBUG(@"小图准备: %ld",(long)self.myPhoto.idxOnView);
        // render thumbnail
        switch (format) {
           case SDImageFormatJPEG:
           case SDImageFormatPNG: {
               WEAK_SELF
               [self.container.imageView shm_imageViewDownSizePhoto:self.myPhoto completion:^(BOOL success, UIImage *imageResult, BOOL isDownsize) {
                   STRONG_SELF
                   if (!isDownsize) {
                       [self setupSDRender:imageResult setImage:YES finished:complete] ;
                   } else {
                       [self setupSDRender:imageResult setImage:NO finished:complete] ;
                   }
               }];
           }
               break;
           case SDImageFormatGIF: {
               [self setupGifDataFinished:complete];
           }
               break;
           case SDImageFormatTIFF:
           case SDImageFormatWebP:
           case SDImageFormatHEIC:
           case SDImageFormatUndefined: {
               WEAK_SELF
               [self.myPhoto fetchImage:^(UIImage *image, SHMGalleryPhoto *photo) {
                   STRONG_SELF
                   if (![tmpPhoto.keyPath isEqualToString:photo.keyPath]) return;
                   
                   [self setupSDRender:image setImage:YES finished:complete] ;
               }];
           }
               break;
           default:
               break;
        }
    } else {
        SHM_LOG_DEBUG(@"大图准备: %ld",(long)self.myPhoto.idxOnView);
        // render large
        switch (format) {
           case SDImageFormatJPEG:
           case SDImageFormatPNG: {
               WEAK_SELF
               [self.myPhoto fetchImage:^(UIImage *image, SHMGalleryPhoto *photo) {
                   STRONG_SELF
                   if (![tmpPhoto.keyPath isEqualToString:photo.keyPath]) return;
                   
                   [self setupLargeImage:image finished:complete];
               }];
           }
               break;
           case SDImageFormatGIF: {
               complete();
           }
               break;
           case SDImageFormatTIFF:
           case SDImageFormatWebP:
           case SDImageFormatHEIC:
           case SDImageFormatUndefined: {
               complete();
           }
               break;
           default:
               break;
        }
    }
}

- (void)showErrorViews:(BOOL)isOn {
    if (isOn) {
        [self resetScrollToOrigin];
        [self addSubview:self.failedTipImage];
        [self.failedTipImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        [self addSubview:self.failedTipLabel];
        [self.failedTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.failedTipImage.mas_bottom).offset(8);
            make.centerX.equalTo(self);
        }];
    } else {
        if (self.failedTipImage.superview) [self.failedTipImage removeFromSuperview];
        if (self.failedTipLabel.superview) [self.failedTipLabel removeFromSuperview];
    }
}

@end
