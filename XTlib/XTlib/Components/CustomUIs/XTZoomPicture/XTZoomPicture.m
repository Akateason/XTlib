//
//  XTZoomPicture.m
//  XTZoomPicture
//
//  Created by TuTu on 15/12/3.
//  Copyright © 2015年 teason. All rights reserved.
//

#define SIDE_ZOOMTORECT 80.0

#import "XTZoomPicture.h"
#import <XTBase/XTBase.h>
#import <XTBase/UIView+Sizes.h>

typedef void (^BlkTapped)(void);
typedef void (^BlkLoadComplete)(void);


@interface XTZoomPicture () <UIScrollViewDelegate>
@property (copy, nonatomic) BlkTapped blkTapped;
@property (copy, nonatomic) BlkLoadComplete blkLoadComplete;
@property (nonatomic) float imgWidth;
@property (nonatomic) float imgHeight;
@property (nonatomic) float imgRate_H_W; // h / w

@property (nonatomic, strong) UIImage *backImage;
@property (copy, nonatomic) NSString *urlStr;
@end


@implementation XTZoomPicture

#pragma mark - Initial

- (id)initWithFrame:(CGRect)frame
          backImage:(UIImage *)backImage
             tapped:(void (^)(void))tapped {
    self = [super initWithFrame:frame];
    if (self) {
        self.backImage = backImage;
        self.blkTapped = tapped;
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
           imageUrl:(NSString *)urlString
             tapped:(void (^)(void))tapped
       loadComplete:(void (^)(void))loadComplete {
    self = [super initWithFrame:frame];
    if (self) {
        self.urlStr          = urlString;
        self.blkTapped       = tapped;
        self.blkLoadComplete = loadComplete;
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self srollviewConfigure];
    [self imageView];
    [self setupGesture];
    self.delegate = self;
    if (!self.backImage) {
        UIActivityIndicatorView *aiView   = [UIActivityIndicatorView new];
        aiView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        aiView.center                     = self.center;
        [self.imageView addSubview:aiView];
        [aiView startAnimating];

        @weakify(self)
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.urlStr] completed:^(UIImage *_Nullable image, NSError *_Nullable error, SDImageCacheType cacheType, NSURL *_Nullable imageURL) {
                @strongify(self)
                    self.backImage = image;
                [aiView stopAnimating];
                [aiView removeFromSuperview];

                self.blkLoadComplete();
            }];
    }
}

- (void)srollviewConfigure {
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator   = NO;
    self.backgroundColor                = [UIColor blackColor];
    self.multipleTouchEnabled           = YES;
    self.scrollsToTop                   = NO;
    self.autoresizingMask               = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.delaysContentTouches           = NO;
    self.canCancelContentTouches        = YES;
    self.alwaysBounceVertical           = NO;
}

- (void)setupGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];

    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleTap.numberOfTapsRequired    = 2;
    [self addGestureRecognizer:doubleTap];
    [tap requireGestureRecognizerToFail:doubleTap];
}

#pragma mark - Property

- (void)setBackImage:(UIImage *)backImage {
    _backImage = backImage;

    self.imageView.image = backImage;
    _imgWidth            = backImage.size.width;
    _imgHeight           = backImage.size.height;
    _imgRate_H_W         = _imgHeight / _imgWidth;

    if (_imgRate_H_W <= 1) {
        self.maximumZoomScale = 2.5;
    }
    else { // 竖 长图处理
        self.maximumZoomScale = self.width / (self.height / _imgHeight * _imgWidth);
    }
    self.minimumZoomScale = 1;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView                 = [[UIImageView alloc] init];
        _imageView.contentMode     = UIViewContentModeScaleAspectFit;
        _imageView.backgroundColor = [UIColor blackColor];
        [self resetToOrigin];
        if (![_imageView superview]) [self addSubview:_imageView];
    }
    return _imageView;
}

#pragma mark -

- (void)resetToOrigin {
    _imageView.frame = self.bounds;

    if (self.imgHeight / self.imgWidth > self.height / self.width) {
        float height      = floor(self.imgHeight / (self.imgWidth / self.width));
        _imageView.height = height;
    }
    else {
        CGFloat height                          = self.imgHeight / self.imgWidth * self.width;
        if (height < 1 || isnan(height)) height = self.height;
        height                                  = floor(height);
        _imageView.height                       = height;
        _imageView.centerY                      = self.height / 2;
    }

    if (CGRectGetHeight(_imageView.frame) > CGRectGetHeight(self.frame)) {
        _imageView.frame = CGRectMake(_imageView.frame.origin.x, _imageView.frame.origin.y, _imageView.frame.size.width, CGRectGetHeight(self.frame));
    }

    self.contentSize = CGSizeMake(self.width, MAX(_imageView.height, self.height));
    [self scrollRectToVisible:self.bounds animated:NO];
    self.alwaysBounceVertical = _imageView.height <= self.height ? NO : YES;
}

#pragma mark - UIScrollView Delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_imgRate_H_W <= 1) return;

    float midSelf      = self.width / 2.;
    float realImageWid = (self.height / _imgHeight * _imgWidth);
    float midDeta      = (self.width - realImageWid) / 2;

    if (self.zoomScale >= self.maximumZoomScale) {
        scrollView.mj_offsetX = midDeta * self.zoomScale;
        return;
    }

    if (scrollView.mj_offsetX > midDeta * self.zoomScale) {
        scrollView.mj_offsetX = midDeta * self.zoomScale;
    }
    else if (scrollView.mj_offsetX < (midSelf + realImageWid / 2) * self.zoomScale - self.width) {
        scrollView.mj_offsetX = (midSelf + realImageWid / 2) * self.zoomScale - self.width;
    }
}

#pragma mark - Touch Actions

- (void)tap:(UITapGestureRecognizer *)tapGetrue {
    if (self.blkTapped) {
        self.blkTapped();
    }
    else {
        [self resetToOrigin];
        [self removeFromSuperview];
    }
}

- (void)doubleTap:(UITapGestureRecognizer *)tapGesture {
    if (self.zoomScale >= self.maximumZoomScale) {
        [self setZoomScale:1 animated:YES];
        [self resetToOrigin];
    }
    else {
        if (_imgRate_H_W <= 1) {
            CGPoint point = [tapGesture locationInView:self];
            [self zoomToRect:CGRectMake(point.x - SIDE_ZOOMTORECT / 2, point.y - SIDE_ZOOMTORECT / 2, SIDE_ZOOMTORECT, SIDE_ZOOMTORECT) animated:YES];
        }
        else {
            [self setZoomScale:self.maximumZoomScale];
            self.mj_offsetY = 0;
        }
    }
}

@end
