//
//  ImageScrollView.h
//  owl
//
//  Created by teason23 on 2020/2/28.
//  Copyright © 2020 shimo.im. All rights reserved.
//
//  imgScroll

#import <UIKit/UIKit.h>
#import <SDWebImage.h>
#import "SHMTiledLargeImageView.h"
#import "SHMTiledContainerView.h"
#import <ReactiveObjC/ReactiveObjC.h>

@class SHMPhotoBrowser;

typedef NS_ENUM(NSUInteger, SHMLargeImgScrollDisplayMode) {
    SHMLargeImgScrollDisplayModeSmall, // 缩略图模式
    SHMLargeImgScrollDisplayModeLarge, // 大图模式
};

@protocol SHMLargeImgScrollCallback <NSObject>
@required
- (void)largeImageDownloadFailed;
- (void)currentPhotoIsGif;
- (void)tapped:(SHMGalleryPhoto *)photo;
- (void)retry;
- (void)isOnZooming:(BOOL)isOnZoom;
- (NSInteger)currentPhotoIndex;
- (void)imageIsOnLoading:(BOOL)isLoading photo:(SHMGalleryPhoto *)photo;
- (SHMPhotoBrowser *)fromBrowser;
@end


@interface SHMLargeImgScroll : UIScrollView
@property (strong, nonatomic) SHMTiledContainerView         *container;
@property (nonatomic)         SHMLargeImgScrollDisplayMode  displayMode;
@property (strong, nonatomic) SHMGalleryPhoto               *myPhoto;
@property (strong, nonatomic) UIActivityIndicatorView       *activityIndicator;
@property (strong, nonatomic) UIImageView                   *failedTipImage;
@property (strong, nonatomic) UILabel                       *failedTipLabel;
@property (strong, nonatomic) RACSubject                    *zoomSignal;      // 此signal代表用户手势操作过程中
@property (strong, nonatomic) RACSubject                    *renderingSignal; // 大图渲染中.
@property (strong, nonatomic) RACSubject                    *browserScrollSignal; // 外面相册滑动后
@property (nonatomic)         BOOL                          isOnZooming;
@property (nonatomic)         CGRect                        originRect;
@property (nonatomic)         BOOL                          isOnReseting;

@property (weak, nonatomic)      id<SHMLargeImgScrollCallback>  callback; // delegate命名和scrollViewDelegate冲突
- (void)setupPhoto:(SHMGalleryPhoto *)photo;
- (void)renderThumbnail:(void(^)(void))complete;
- (void)changeLargePhoto:(void(^)(void))complete;

- (void)setupLargeImage:(UIImage *)img
               finished:(void(^)(void))finished;
- (void)setupSDRender:(UIImage *)img
             setImage:(BOOL)setImage
             finished:(void(^)(void))finished;
- (void)setupGifDataFinished:(void(^)(void))finished;

@end


