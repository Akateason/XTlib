//
//  SHMTiledContainerView.m
//  owl
//
//  Created by teason23 on 2020/7/4.
//  Copyright © 2020 shimo.im. All rights reserved.
//

#import "SHMTiledContainerView.h"
#import "SHMTiledLargeImageView.h"
#import <SDWebImage.h>

@interface SHMTiledContainerView ()

@end

@implementation SHMTiledContainerView

- (instancetype)initWithTiledImageView:(SHMTiledLargeImageView *)tiledImageView {
    self = [super initWithFrame:tiledImageView.bounds];
    if (!self) return nil;

    SDAnimatedImageView *imageView = [[SDAnimatedImageView alloc] initWithFrame:tiledImageView.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView = imageView;
    _imageView.maxBufferSize = 1;
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

    tiledImageView.contentMode = UIViewContentModeScaleAspectFit;
    _largeImageView = tiledImageView;
    [self addSubview:tiledImageView];
    [tiledImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

    self.backgroundColor = [UIColor blackColor];
    
    return self;
}

- (void)clearLarge {
    _largeImageView.hidden = YES;
    _largeImageView.image = nil;
    [_largeImageView setNeedsDisplay];
}

- (void)clearAll {
    [self clearLarge];
    _imageView.image = nil;
}

- (void)setFrame:(CGRect)frame {
    //fix: CALayer position contains NaN: [nan nan]
    if (self.layer == nil || self.largeImageView.layer == nil || self.imageView.layer == nil) {
        return;
    }
    
    [super setFrame:frame]; // zoom set frame
}

@end
