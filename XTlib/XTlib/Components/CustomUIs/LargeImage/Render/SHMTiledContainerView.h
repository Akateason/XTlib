//
//  SHMTiledContainerView.h
//  owl
//
//  Created by teason23 on 2020/7/4.
//  Copyright © 2020 shimo.im. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SHMTiledLargeImageView, SDAnimatedImageView;

NS_ASSUME_NONNULL_BEGIN

@interface SHMTiledContainerView : UIView
@property (strong, nonatomic) SHMTiledLargeImageView *largeImageView;
@property (strong, nonatomic) SDAnimatedImageView *imageView;

- (instancetype)initWithTiledImageView:(SHMTiledLargeImageView *)tiledImageView;
- (void)clearLarge;
- (void)clearAll;
@end

NS_ASSUME_NONNULL_END
