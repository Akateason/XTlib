//
//  XTZoomPicture.m
//  XTZoomPicture
//
//  Created by teason on 15/12/3.
//  Copyright © 2015年 teason. All rights reserved.
//
//


#define SIDE_ZOOMTORECT 80.0

#import "XTZoomPicture.h"
#import <XTBase/XTBase.h>
#import <XTBase/UIView+Sizes.h>
#import <XTTable/XTTable.h>


static void *ScrollViewBoundsChangeNotificationContext = &ScrollViewBoundsChangeNotificationContext;
typedef void(^BlkTapped)(void);

@interface XTZoomPicture () <UIScrollViewDelegate>

@property (nonatomic, readonly) CGFloat imageAspectRatio;
@property (nonatomic) CGRect initialImageFrame;
@property (copy, nonatomic) BlkTapped blkTapped;

@end

@implementation XTZoomPicture

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

#pragma mark - Tap to Zoom

- (void)setupGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];

    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTap];
    [tap requireGestureRecognizerToFail:doubleTap];
}

- (void)tap:(UIGestureRecognizer *)gestureRecognizer {
    if (self.blkTapped) self.blkTapped();
}

- (void)doubleTap:(UIGestureRecognizer *)gestureRecognizer {
    if (self.zoomScale > self.minimumZoomScale) {
        [self setZoomScale:self.minimumZoomScale animated:YES];
    } else {
        CGPoint tapLocation = [gestureRecognizer locationInView:self.imageView];
        CGFloat zoomRectWidth = self.imageView.frame.size.width / self.maximumZoomScale;
        CGFloat zoomRectHeight = self.imageView.frame.size.height / self.maximumZoomScale;
        CGFloat zoomRectX = tapLocation.x - zoomRectWidth * 0.5;
        CGFloat zoomRectY = tapLocation.y - zoomRectHeight * 0.5;
        CGRect zoomRect = CGRectMake(zoomRectX, zoomRectY, zoomRectWidth, zoomRectHeight);
        [self zoomToRect:zoomRect animated:YES];
    }
}


#pragma mark - Private Methods

- (void)configure {
    _imageView = [UIImageView new];
    _initialImageFrame = CGRectNull;
    _imageView.userInteractionEnabled = YES;
    self.userInteractionEnabled = YES;
    [self addSubview:_imageView];
            
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    [self startObservingBoundsChange];
    self.delegate = self;
    self.maximumZoomScale = 4.0;
    
    [self setupGesture];
}

- (CGFloat)imageAspectRatio {
    if (self.imageView.image) {
        return self.imageView.image.size.width / self.imageView.image.size.height;
    }
    return 1;
}

- (CGSize)rectSizeForAspectRatio: (CGFloat)ratio
                    thatFitsSize: (CGSize)size
{
    CGFloat containerWidth = size.width;
    CGFloat containerHeight = size.height;
    CGFloat resultWidth = 0;
    CGFloat resultHeight = 0;
    
    if ((ratio <= 0) || (containerHeight <= 0)) {
        return size;
    }
    
    if (containerWidth / containerHeight >= ratio) {
        resultHeight = containerHeight;
        resultWidth = containerHeight * ratio;
    }
    else {
        resultWidth = containerWidth;
        resultHeight = containerWidth / ratio;
    }
    
    return CGSizeMake(resultWidth, resultHeight);
}

- (void)scaleImageForScrollViewTransitionFromBounds: (CGRect)oldBounds
                                           toBounds: (CGRect)newBounds
{
    CGPoint oldContentOffset = CGPointMake(
                                           oldBounds.origin.x,
                                           oldBounds.origin.y
                                           );
    CGSize oldSize = oldBounds.size;
    CGSize newSize = newBounds.size;
    
    CGSize containedImageSizeOld = [self rectSizeForAspectRatio: self.imageAspectRatio
                                                   thatFitsSize: oldSize];
    
    CGSize containedImageSizeNew = [self rectSizeForAspectRatio: self.imageAspectRatio
                                                   thatFitsSize: newSize];
    
    if (containedImageSizeOld.height <= 0) {
        containedImageSizeOld = containedImageSizeNew;
    }
    
    CGFloat orientationRatio = (
                                containedImageSizeNew.height /
                                containedImageSizeOld.height
                                );
    
    CGAffineTransform t = CGAffineTransformMakeScale(
                                                     orientationRatio,
                                                     orientationRatio
                                                     );
    
    self.imageView.frame = CGRectApplyAffineTransform(self.imageView.frame, t);
    
    self.contentSize = self.imageView.frame.size;
    
    CGFloat xOffset = (oldContentOffset.x + oldSize.width * 0.5) * orientationRatio - newSize.width * 0.5;
    CGFloat yOffset = (oldContentOffset.y + oldSize.height * 0.5) * orientationRatio - newSize.height * 0.5;
    
    xOffset -= MAX(xOffset + newSize.width - self.contentSize.width, 0);
    yOffset -= MAX(yOffset + newSize.height - self.contentSize.height, 0);
    xOffset += MAX(-xOffset, 0);
    yOffset += MAX(-yOffset, 0);
    
    self.contentOffset = CGPointMake(xOffset, yOffset);
}

- (void)setupInitialImageFrame {
    if (self.imageView.image && CGRectEqualToRect(self.initialImageFrame, CGRectNull)) {
        CGSize imageViewSize = [self rectSizeForAspectRatio:self.imageAspectRatio
                                               thatFitsSize:self.bounds.size];
        self.initialImageFrame = CGRectMake(0, 0, imageViewSize.width, imageViewSize.height);
        self.imageView.frame = self.initialImageFrame;
        self.contentSize = self.initialImageFrame.size;
    }
}

- (void)reset {
    [self setupInitialImageFrame];
    self.zoomScale = 1;
}

- (void)onTapped:(void(^)(void))tapped {
    self.blkTapped = tapped;
}

#pragma mark - KVO

- (void)startObservingBoundsChange {
    [self addObserver:self
           forKeyPath:@"bounds"
              options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
              context:ScrollViewBoundsChangeNotificationContext];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (context == ScrollViewBoundsChangeNotificationContext) {
        CGRect oldRect = ((NSValue *)change[NSKeyValueChangeOldKey]).CGRectValue;
        CGRect newRect = ((NSValue *)change[NSKeyValueChangeNewKey]).CGRectValue;
        if (! CGSizeEqualToSize(oldRect.size, newRect.size)) {
            [self scaleImageForScrollViewTransitionFromBounds: oldRect
                                                     toBounds: newRect];
        }
    }
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"bounds"];
}

#pragma mark - UIScrollView

- (void)setContentOffset:(CGPoint)contentOffset
{
    const CGSize contentSize = self.contentSize;
    const CGSize scrollViewSize = self.bounds.size;
    
    if (contentSize.width < scrollViewSize.width)
    {
        contentOffset.x = - (scrollViewSize.width - contentSize.width) * 0.5;
    }
    
    if (contentSize.height < scrollViewSize.height)
    {
        contentOffset.y = - (scrollViewSize.height - contentSize.height) * 0.5;
    }
    
    [super setContentOffset:contentOffset];
}

#pragma mark - UIView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configure];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configure];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupInitialImageFrame];
}

@end
