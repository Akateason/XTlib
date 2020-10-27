//
//  TiledImageView.h
//  owl
//
//  Created by teason23 on 2020/2/28.
//  Copyright © 2020 shimo.im. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImageManager+largeImage.h"
#import <UIImageView+WebCache.h>
#import <NSData+ImageContentType.h>
@class SHMGalleryPhoto;

@protocol SHMTiledLargeImageViewDelegate <NSObject>
@required
- (void)tiledLargeImageIsRendering:(SHMGalleryPhoto *)photo;
@end

@interface SHMTiledLargeImageView : UIView
@property (weak, nonatomic)     id<SHMTiledLargeImageViewDelegate>  delegate;
@property (strong, nonatomic)   UIImage                             *image;
@property (nonatomic)           CGFloat                             imageScale;
@property (strong, nonatomic)   SHMGalleryPhoto                     *photo;

- (void)setImage:(UIImage *)image
           scale:(CGFloat)scale
           photo:(SHMGalleryPhoto *)photo
        finished:(void(^)(void))finished;

@end


