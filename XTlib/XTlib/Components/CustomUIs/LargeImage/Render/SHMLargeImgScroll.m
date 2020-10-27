//
//  ImageScrollView.m
//  owl
//
//  Created by teason23 on 2020/2/28.
//  Copyright © 2020 shimo.im. All rights reserved.
//

#import "SHMLargeImgScroll.h"
#import <ReactiveObjC.h>
#import <Photos/Photos.h>
#import "UIImage+SHMExtension.h"
#import "SHMLargeImgScroll+Render.h"
#import "SHMLargeImgScroll+ScrollView.h"
#import "SHMLargeImgScroll+Util.h"
#import "SHMRootWindow.h"
#import "SHMImgCacheManager.h"
#import "UIImageView+SHMThumbnail.h"



@interface SHMLargeImgScroll ()<UIScrollViewDelegate, SHMTiledLargeImageViewDelegate>
@property (strong, nonatomic) RACSubject *thumbFinishSignal;
@end

@implementation SHMLargeImgScroll

#pragma mark - life

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupScrollView];
        [self setupGesture];
        [self container];
        [self activityIndicator];
        [self setupNotificationsAndSignals];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // fix: 缩放不稳定跳
    [self setupContainerFrame:self.container.frame];
}

- (void)setupScrollView {
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.bouncesZoom = YES;
    self.decelerationRate = UIScrollViewDecelerationRateFast;
    self.delegate = self;
    self.backgroundColor = [UIColor blackColor];
}

- (void)setupNotificationsAndSignals {
    @weakify(self)
    [[[[[[NSNotificationCenter defaultCenter] rac_addObserverForName:kNoti_GallaryPhoto_ResetToThumbNail object:nil]
        throttle:.01]
       deliverOnMainThread]
      takeUntil:self.rac_willDeallocSignal]
     subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        SHM_LOG_DEBUG(@"🍠外面滑动瞬间, 全部切缩略图,%ld, 当前%ld",self.myPhoto.idxOnView,[self.callback currentPhotoIndex]);
        self.displayMode = SHMLargeImgScrollDisplayModeSmall;
        [self.container clearLarge];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.isOnZooming && ![self isRenderPhotoOnScreenCenter]) {
                [self resetScrollToOrigin];
            }
        });
    }];
    
    RACSignal *signal = [[self.renderingSignal throttle:0.6] merge:self.zoomSignal];
    [[[[signal throttle:1]
        takeUntil:self.rac_willDeallocSignal]
      deliverOnMainThread]
     subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        SHM_LOG_DEBUG(@"大图 work all done 🇨🇳");
        [self doAfterTheProgress];
    }];
    
    
    [[[[[self.thumbFinishSignal merge:self.browserScrollSignal]
        throttle:.3]
       takeUntil:self.rac_willDeallocSignal]
      deliverOnMainThread]
     subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        if (self.container.imageView.image != nil) {
            if (![self isRenderPhotoOnScreenCenter]) return;
            if (self.container.largeImageView.image != nil) return;
                
            SHM_LOG_DEBUG(@"加载changelarge : %ld ",(long)self.myPhoto.idxOnView);
            //self.userInteractionEnabled = NO;
            @weakify(self)
            [self changeLargePhoto:^{
                @strongify(self)
                self.userInteractionEnabled = YES;
                [self.callback imageIsOnLoading:NO photo:self.myPhoto];
            }];
 
        } else {
            SHM_LOG_DEBUG(@"error, thumb还未加载");
        }

    }];
    
    [[[[[[NSNotificationCenter defaultCenter] rac_addObserverForName:SHMRootWindowFrameDidChangeNotification object:nil]
        delay:0.2]
       takeUntil:self.rac_willDeallocSignal]
      deliverOnMainThread]
     subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        self.displayMode = SHMLargeImgScrollDisplayModeSmall;
        [self.container clearLarge];

        [self setupPhoto:self.myPhoto];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.isOnZooming) {
                [self resetScrollToOrigin];
            }
        });
                
    }];
    
    [[[[[NSNotificationCenter defaultCenter]
       rac_addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:nil]
       throttle:0.1]
      deliverOnMainThread]
     subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        [self.container clearLarge];
                
        [[SDImageCache sharedImageCache] clearMemory];
        
        //[SHMGalleryPhoto cancelAllFetching];
    }];
}

- (void)setupLargeImage:(UIImage *)img
               finished:(void(^)(void))finished {
    
    if (![self isRenderPhotoOnScreenCenter]) return;
                    
    SHM_LOG_DEBUG(@"🐈%ldRender大图",self.myPhoto.idxOnView);
    img = [UIImage shm_fixOrientation:img]; // fix: cgImage裁剪会丢失方向

    [self prepareLargeImage:img finished:finished];
}

static const CGFloat kSHMDefaultMaxValue = 5;

- (void)prepareLargeImage:(UIImage *)img
                 finished:(void(^)(void))finished {
    
    if (!img) {
        NSLog(@"渲染空图");
    }
    
    RACTuple *info = [self getInfoFromImageThenSetContainerFrame:img];
    RACTupleUnpack(NSNumber *scaleNum, NSValue *rectVal) = info ;
    CGFloat imageScale = scaleNum.floatValue;
    if (imageScale == 0) {
        imageScale = 1;
    }
                        
    // 根据图片的缩放计算Scrollview的缩放级别
    // 图片相对于视图放大了 1 / imageScale 倍，所以用log2(1/imageScale)得出缩放次数，
    int level = ceil( log2 (1 / imageScale) ) ;
    CGFloat zoomInLevels = pow(2, level);
    
    XT_IN_MAINQUEUE(
                     
        self.maximumZoomScale = MIN(MAX(kSHMDefaultMaxValue, zoomInLevels), 20);
        self.minimumZoomScale = 1;
        
        WEAK_SELF
        [self.container.largeImageView setImage:img
                                       scale:imageScale
                                       photo:self.myPhoto
                                    finished:^{
            STRONG_SELF
            [self turnOnActivityIndicator:NO];
            if (finished) finished();
        }];
                     
                     )
}


- (void)setupSDRender:(UIImage *)img
             setImage:(BOOL)setImage
             finished:(void(^)(void))finished {
    SHM_LOG_DEBUG(@"🦟renderSD或小图,%ld",(long)self.myPhoto.idxOnView);
    [self prepareSDImage:img setImage:setImage finished:finished];
}

- (void)prepareSDImage:(UIImage *)img
              setImage:(BOOL)setImage
              finished:(void(^)(void))finished {
    XT_IN_MAINQUEUE(
        self.maximumZoomScale = kSHMDefaultMaxValue;
        self.minimumZoomScale = 1;
                 
        if (setImage) self.container.imageView.image = img;
        [self setupContainerFrameWithImage:img];
        [self turnOnActivityIndicator:NO];

        if (finished) finished();
                     )
}

- (void)setupGifDataFinished:(void(^)(void))finished {
    SHM_LOG_DEBUG(@"🦟renderGIF,%ld",self.myPhoto.idxOnView);
    // gif屏蔽旋转
    if (self.callback && [self.callback respondsToSelector:@selector(currentPhotoIsGif)]) [self.callback currentPhotoIsGif];
                
    [self.container clearLarge];
            
    self.maximumZoomScale = kSHMDefaultMaxValue;
    self.minimumZoomScale = 1;
    
    SDAnimatedImage *aImage = [SDAnimatedImage imageWithData:self.myPhoto.original];
    [self setupContainerFrameWithImage:aImage];
    self.container.imageView.image = aImage;
    
    [self turnOnActivityIndicator:NO];
        
    if (finished) finished();
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

- (void)tap:(UITapGestureRecognizer *)tapGetrue {
    if (self.zoomScale != 1) {
        SHM_LOG_DEBUG(@"放大中, 单击被屏蔽");
        return;
    }
    
    if (!self.scrollEnabled) {
        return;
    }
    
    if (self.myPhoto.status == SHMGalleryImageStatusError) {
        if (self.callback && [self.callback respondsToSelector:@selector(retry)]) [self.callback retry];
    } else if (self.myPhoto.status == SHMGalleryImageStatusDone) {
        if (self.callback && [self.callback respondsToSelector:@selector(tapped:)]) [self.callback tapped:self.myPhoto];
    }
}

- (void)doubleTap:(UITapGestureRecognizer *)tapGesture {
    if (!self.scrollEnabled) {
        return;
    }
    
    if (self.zoomScale == 1) {
        SHM_LOG_DEBUG(@"双击放大");
        CGPoint pt = [tapGesture locationInView:self.container];
        CGFloat longSide = MAX(self.container.imageView.image.size.width, self.container.imageView.image.size.height);
        CGFloat shortSide = MIN(self.container.imageView.image.size.width, self.container.imageView.image.size.height);
        if (!shortSide) shortSide = 1.0;
        CGRect zoomRect;
        if (longSide / shortSide > 5.0) { // 长图
            zoomRect = [self zoomRectForScale:self.maximumZoomScale withCenter:pt];
        } else { // 默认
            zoomRect = [self zoomRectForScale:2 withCenter:pt];
        }
        [self zoomToRect:zoomRect animated:YES];
        self.isOnZooming = YES;
    } else {
        SHM_LOG_DEBUG(@"双击复原");
        [self resetScrollToOriginAnimated:YES];
        
        self.isOnZooming = NO;
    }
}

#pragma mark - SHMTiledLargeImageViewDelegate <NSObject>

- (void)tiledLargeImageIsRendering:(SHMGalleryPhoto *)photo {
    if (!photo || !self.container.largeImageView.image) return;
    
    [self.renderingSignal sendNext:@4];
    
    XT_IN_MAINQUEUE([self doBeforeTheProgress];)
    
    SHM_LOG_DEBUG(@"%ld 🐉drawing large", (long)self.myPhoto.idxOnView);
}

#pragma mark - prop

- (void)setIsOnZooming:(BOOL)isOnZooming {
    _isOnZooming = isOnZooming;
    
    if (self.callback) [self.callback isOnZooming:isOnZooming];
}

- (SHMTiledContainerView *)container {
    if (!_container) {
        SHMTiledLargeImageView *largeImgView = [[SHMTiledLargeImageView alloc] initWithFrame:(CGRect) {
            CGPointZero,
            [SHMDevice currentDevice].screenSize
        }];
        largeImgView.contentMode = UIViewContentModeScaleAspectFit;
        largeImgView.delegate = self;

        _container = [[SHMTiledContainerView alloc] initWithTiledImageView:largeImgView];
        [self addSubview:_container];
    }
    return _container;
}

- (UIActivityIndicatorView *)activityIndicator {
    if (!_activityIndicator) {
        _activityIndicator = [UIActivityIndicatorView new];
        _activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        _activityIndicator.center = self.center;
        [self addSubview:_activityIndicator];
        _activityIndicator.hidden = YES;
    }
    return _activityIndicator;
}

- (UIImageView *)failedTipImage {
    if (!_failedTipImage) {
        _failedTipImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gallery_failed"]];
    }
    return _failedTipImage;
}

- (UILabel *)failedTipLabel {
    if (!_failedTipLabel) {
        _failedTipLabel = [UILabel new];
        _failedTipLabel.text = @"图片加载失败，请点击屏幕重试";
        _failedTipLabel.font = [UIFont fontWithName:@"PingFangSC-Regular"size:12];
        _failedTipLabel.textColor = SHM_UIColorRGB(165, 165, 165);
    }
    return _failedTipLabel;
}

- (RACSubject *)zoomSignal {
    if (!_zoomSignal) {
        _zoomSignal = [RACSubject new];
    }
    return _zoomSignal;
}

- (RACSubject *)renderingSignal {
    if (!_renderingSignal) {
        _renderingSignal = [RACSubject new];
    }
    return _renderingSignal;
}

- (RACSubject *)thumbFinishSignal {
    if (!_thumbFinishSignal) {
        _thumbFinishSignal = [RACSubject new];
    }
    return _thumbFinishSignal;
}

- (RACSubject *)browserScrollSignal {
    if (!_browserScrollSignal) {
        _browserScrollSignal = [RACSubject new];
    }
    return _browserScrollSignal;
}

#pragma mark - public

// 由于cell的reuse机制，这个方法不是每次都调用。
- (void)setupPhoto:(SHMGalleryPhoto *)photo {
    SHM_LOG_DEBUG(@"cell图片setup : %ld",(long)photo.idxOnView); // iphone6 这里卡顿, 拿不到图片, 偶现
    
    XT_IN_MAINQUEUE(
                     self.userInteractionEnabled = NO;
                     [self.container clearAll];
                     [self resetScrollToOrigin];
                     )
        
    self.myPhoto = photo;
    self.isOnZooming = NO;
    self.originRect = CGRectZero;
    
    if (SHM_IS_IPHONE_6 || SHM_LESS_THAN_IPHONE_6) {
        [[SDImageCache sharedImageCache] clearMemory];
    }

    [self.callback imageIsOnLoading:YES photo:self.myPhoto];
        
    WEAK_SELF
    [self renderThumbnail:^{
        STRONG_SELF
        self.userInteractionEnabled = YES;
        [self.thumbFinishSignal sendNext:self.myPhoto.keyPath];
    }];    
}

- (void)renderThumbnail:(void(^)(void))complete {
    if (self.isOnZooming) return;
            
    self.displayMode = SHMLargeImgScrollDisplayModeSmall;
    [self renderGallaryPhoto:complete];
}

- (void)changeLargePhoto:(void(^)(void))complete {
    if (![self isRenderPhotoOnScreenCenter]) return;
        
    if (self.myPhoto.sizeMode == SHMGalleryImageSizeLarge && self.myPhoto.status == SHMGalleryImageStatusDone) {
        // 若是大图, 且有原图, 加载大图        
        self.displayMode = SHMLargeImgScrollDisplayModeLarge;
        //[self turnOnActivityIndicator:YES];
        WEAK_SELF
        [self renderPhoto:^{
            STRONG_SELF
            self.container.largeImageView.hidden = NO;
            complete();
        }];

    } else {
        NSString *tipSize = self.myPhoto.sizeMode == SHMGalleryImageSizeNormal ? @"不是大图":@"未知状态";
        NSString *tipStatus = self.myPhoto.status == SHMGalleryImageStatusError ? @"加载出错": SHM_STR_FORMAT(@"状态: %lu",(unsigned long)self.myPhoto.status) ;
        SHM_LOG_DEBUG(@"🐈%ld 大图不加载,size:%@,status:%@",self.myPhoto.idxOnView,tipSize,tipStatus);
        if (complete) complete();
    }
}

@end
