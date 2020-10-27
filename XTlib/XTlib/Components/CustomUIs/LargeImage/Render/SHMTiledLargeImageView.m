//
//  TiledImageView.m
//  owl
//
//  Created by teason23 on 2020/2/28.
//  Copyright © 2020 shimo.im. All rights reserved.
//

#import "SHMTiledLargeImageView.h"
#import "SHMTiledLayer.h"
#import "SHMLargeImgScroll+Util.h"
#import "UIImageView+XtHugeImageDownsize.h"

typedef void(^RenderFinishedBlk)(void);

@interface SHMTiledLargeImageView ()
@property (strong, nonatomic) RACSubject        *drawingSignal;
@property (copy, nonatomic)   RenderFinishedBlk blkFinished;
@end

@implementation SHMTiledLargeImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.drawingSignal = [RACSubject new];
        
        @weakify(self)
        [[[self.drawingSignal throttle:.6]
          deliverOnMainThread]
        subscribeNext:^(id  _Nullable x) {
            @strongify(self)
            SHM_LOG_DEBUG(@"%ld 🙅‍♀️large render blkFinished", (long)self.photo.idxOnView);
            if (self.blkFinished) self.blkFinished();
        }];
    }
    return self;
}

- (void)setImage:(UIImage *)image
           scale:(CGFloat)scale
           photo:(SHMGalleryPhoto *)photo
        finished:(void(^)(void))finished {
    
    if (self.photo != nil &&
        [photo.keyPath isEqualToString:self.photo.keyPath] &&
        self.image != nil) {
        return;
    }
    
    self.blkFinished = finished;
    SHMTiledLayer *tiledLayer = (SHMTiledLayer *)[self layer];
    if (tiledLayer.contents && self.image) {
        tiledLayer.contents = nil; //cancel上次没结束的render
        [self setNeedsDisplay];
    }
    
    self.image = image;
    self.imageScale = scale;
    self.photo = photo;
    
    // 根据图片的缩放计算scrollview的缩放次数
    // 图片相对于视图放大了1/imageScale倍，所以用log2(1/imageScale)得出缩放次数，
    // 然后通过pow得出缩放倍数，至于为什么要加1，
    // 是希望图片在放大到原图比例时，还可以继续放大一次（即2倍），可以看的更清晰
    int lev = ceil( log2(1 / scale) );
    tiledLayer.levelsOfDetail = 1;
    tiledLayer.levelsOfDetailBias = lev;
    // tiledLayer.tileSize  此处tilesize使用默认的256x256即可
    [self setNeedsDisplay];
    
    [self.drawingSignal sendNext:@1];
}

- (void)drawRect:(CGRect)rect {
    @autoreleasepool{
        if (!self.photo)        return;
        if (_imageScale == 0)   return;
        if (!self.photo)        return;
        
        NSString *tmpKey = self.photo.keyPath;
                        
        CGRect imageCutRect = CGRectMake(rect.origin.x / _imageScale,
                                         rect.origin.y / _imageScale,
                                         rect.size.width / _imageScale,
                                         rect.size.height / _imageScale);
        
        CGImageRef imageRef = CGImageCreateWithImageInRect(self.image.CGImage, imageCutRect);
        UIImage *tileImage = [UIImage imageWithCGImage:imageRef];
        CGContextRef context = UIGraphicsGetCurrentContext();
        UIGraphicsPushContext(context);
        [tileImage drawInRect:rect];
        CGImageRelease(imageRef);
        UIGraphicsPopContext();
        // https://stackoverflow.com/questions/39891468/catiledlayer-shows-previous-tiles
        if (self.photo != nil && ![tmpKey isEqualToString:self.photo.keyPath] && tmpKey != nil && self.photo.keyPath != nil) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.layer setNeedsDisplayInRect:rect];
                SHM_LOG_DEBUG(@"渲染有冲突, 单独延后渲染这块");
                return;
            });
        }
        
        if (self.delegate) [self.delegate tiledLargeImageIsRendering:self.photo];
        [self.drawingSignal sendNext:@1];
    }
}

+ (Class)layerClass {
    return [SHMTiledLayer class];
}

@end
