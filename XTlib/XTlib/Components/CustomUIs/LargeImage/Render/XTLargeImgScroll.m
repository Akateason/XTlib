//
//  XTLargeImgScroll.m
//  XTlib
//
//  Created by teason23 on 2020/4/10.
//  Copyright © 2020 teason23. All rights reserved.
//

#import "XTLargeImgScroll.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "XTLargeImageCompressUtil.h"
#import <XTBase/XTBase.h>

@implementation XTLargeImgScroll

#pragma mark - life

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bouncesZoom = YES;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.delegate = self;
        self.backgroundColor = [UIColor blackColor];
        [self setupGesture];
        [self largeImgView];
    }
    return self;
}

- (void)setupLargeImage:(UIImage *)img {
    [self clear];
        
    RACTuple *info = [self infoFromImage:img];
    RACTupleUnpack(NSNumber *scaleNum, NSValue *rectVal) = info ;
    CGFloat imageScale = scaleNum.floatValue;
    CGRect imageRect = rectVal.CGRectValue;
                        
    // 根据图片的缩放计算Scrollview的缩放级别
    // 图片相对于视图放大了 1 / imageScale 倍，所以用log2(1/imageScale)得出缩放次数，
    int level = ceil(log2(1 / imageScale)) ;
    CGFloat zoomOutLevels = 1;
    CGFloat zoomInLevels = pow(2, level);
    
    self.maximumZoomScale = zoomInLevels;
    self.minimumZoomScale = zoomOutLevels;

    [self.largeImgView setImage:img scale:imageScale] ;
    self.largeImgView.frame = imageRect;
    [self resetScrollToOrigin];
}



#pragma mark - gesture

- (void)setupGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];

    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTap];
    [tap requireGestureRecognizerToFail:doubleTap];
}

- (void)tap:(UITapGestureRecognizer *)tapGetrue {}

static const float kSIDE_ZOOMTORECT = 80.0f;
- (void)doubleTap:(UITapGestureRecognizer *)tapGesture {
    if (self.zoomScale == 1) {
        CGPoint point = [tapGesture locationInView:self];
        [self zoomToRect:CGRectMake(point.x - kSIDE_ZOOMTORECT / 2, point.y - kSIDE_ZOOMTORECT / 2, kSIDE_ZOOMTORECT, kSIDE_ZOOMTORECT) animated:YES];
    } else {
        [self setZoomScale:1 animated:YES];
        [self resetScrollToOrigin];
    }
}

#pragma mark - scrollview

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.largeImgView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self setuplargeImgViewFrame];
}


#pragma mark - p

- (XTTiledLargeImageView *)largeImgView {
    if (!_largeImgView) {
        _largeImgView = [[XTTiledLargeImageView alloc] initWithFrame:self.bounds];
        if (!_largeImgView.superview) [self addSubview:_largeImgView];
    }
    return _largeImgView;
}

#pragma mark - util

- (void)setuplargeImgViewFrame {
    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = self.largeImgView.frame;
    // center horizontally
    if (frameToCenter.size.width < boundsSize.width)
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    else frameToCenter.origin.x = 0;
    // center vertically
    if (frameToCenter.size.height < boundsSize.height)
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    else frameToCenter.origin.y = 0;
    
    self.largeImgView.frame = frameToCenter;
    // to handle the interaction between CATiledLayer and high resolution screens, we need to manually set the
    // tiling view's contentScaleFactor to 1.0. (If we omitted this, it would be 2.0 on high resolution screens,
    // which would cause the CATiledLayer to ask us for tiles of the wrong scales.)
    self.largeImgView.contentScaleFactor = 1.0;
}

- (void)clear {
    self.largeImgView.image = nil;
}

- (void)resetScrollToOrigin {
    self.zoomScale = 1;
    [self setuplargeImgViewFrame];
    [self scrollRectToVisible:self.bounds animated:NO];
}


/// infoFromImage
/// @return tuple @[@(imageScale), @(imageRect)]
/// 根据图片实际尺寸 和 屏幕尺寸 计算图片视图尺寸
- (RACTuple *)infoFromImage:(UIImage *)img {
    CGRect imageRect = CGRectMake(0.0f,0.0f,CGImageGetWidth(img.CGImage),CGImageGetHeight(img.CGImage));
    CGFloat scaleW = self.frame.size.width / imageRect.size.width ;
    CGFloat scaleH = self.frame.size.height / imageRect.size.height ;
    CGFloat imageScale = MIN(scaleH, scaleW) ;
    imageRect.size = CGSizeMake(imageRect.size.width * imageScale, imageRect.size.height * imageScale) ;
    return RACTuplePack(@(imageScale),@(imageRect));
}




@end
