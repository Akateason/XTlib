

#import "KICropImageView.h"


@implementation KICropImageView

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [[self scrollView] setFrame:self.bounds];
    [[self maskView] setFrame:self.bounds];
    
//    if (CGSizeEqualToSize(_cropSize, CGSizeZero)) {
//        [self setCropSize:CGSizeMake(100, 100)];
//    }
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        [_scrollView setDelegate:self];
        [_scrollView setBounces:NO];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init] ;
        _imageView.contentMode = UIViewContentModeScaleAspectFit ;
        [[self scrollView] addSubview:_imageView];
    }
    return _imageView;
}

- (KICropImageMaskView *)maskView {
    if (_maskView == nil) {
        _maskView = [[KICropImageMaskView alloc] init] ;
        [_maskView setBackgroundColor:[UIColor clearColor]] ;
        [_maskView setUserInteractionEnabled:NO];
        [self addSubview:_maskView];
        [self bringSubviewToFront:_maskView];
    }
    return _maskView;
}

- (void)setImage:(UIImage *)image {
    if (image != _image) {
        [_image release];
        _image = nil;
        _image = [image retain];
    }
    [[self imageView] setImage:_image];
    
    [self updateZoomScale] ;
}



- (void)updateZoomScale
{
    if (_image == nil || CGSizeEqualToSize(_cropSize, CGSizeZero)) {
        return ;
    }
    
    CGFloat width = _image.size.width;
    CGFloat height = _image.size.height;
    [[self imageView] setFrame:CGRectMake(0, 0, width, height)] ;

    CGFloat xScale = _cropSize.width / width ;
    CGFloat yScale = _cropSize.height / height ;
    CGFloat min = MAX(xScale, yScale) ;

    [[self scrollView] setMinimumZoomScale:min];
    [[self scrollView] setMaximumZoomScale:min + 3] ;
    [[self scrollView] setZoomScale:min animated:NO] ;
    
    CGFloat cs_width = _cropSize.width;
    CGFloat cs_height = _cropSize.height;
    CGFloat x = (CGRectGetWidth(self.bounds) - cs_width) / 2 ;
    CGFloat y = (CGRectGetHeight(self.bounds) - cs_height) / 2 ;
    CGFloat top = y;
    CGFloat left = x;
    CGFloat right = CGRectGetWidth(self.bounds)- cs_width - x;
    CGFloat bottom = CGRectGetHeight(self.bounds)- cs_height - y;
    _imageInset = UIEdgeInsetsMake(top, left, bottom, right);
    [[self scrollView] setContentOffset:CGPointMake(0, 0)] ;
    [[self scrollView] setContentInset:_imageInset] ;
    
}

- (void)setCropSize:(CGSize)size {
    _cropSize = size;
    
    
//    CGFloat x = (CGRectGetWidth(self.bounds) - width) / 2;
//    CGFloat y = (CGRectGetHeight(self.bounds) - height) / 2;
    
    [[self maskView] setCropSize:_cropSize];
    
    [self updateZoomScale];

//    CGFloat top = y;
//    CGFloat left = x;
//    CGFloat right = CGRectGetWidth(self.bounds)- width - x;
//    CGFloat bottom = CGRectGetHeight(self.bounds)- height - y;
//    _imageInset = UIEdgeInsetsMake(top, left, bottom, right);
//    [[self scrollView] setContentInset:_imageInset];
//    
//    [[self scrollView] setContentOffset:CGPointMake(0, 0)];
}

- (UIImage *)cropImage
{
    CGFloat zoomScale = [self scrollView].zoomScale;
    
    CGFloat offsetX = [self scrollView].contentOffset.x;
    CGFloat offsetY = [self scrollView].contentOffset.y;
    CGFloat aX = offsetX>=0 ? offsetX+_imageInset.left : (_imageInset.left - ABS(offsetX));
    CGFloat aY = offsetY>=0 ? offsetY+_imageInset.top : (_imageInset.top - ABS(offsetY));
    
    aX = aX / zoomScale;
    aY = aY / zoomScale;
    
    CGFloat aWidth =  _cropSize.width / zoomScale ;
    CGFloat aHeight = _cropSize.height / zoomScale ;
    
#ifdef DEBUG
    NSLog(@"%f--%f--%f--%f", aX, aY, aWidth, aHeight);
#endif
    
    UIImage *image = [_image cropImageWithX:aX y:aY width:aWidth height:aHeight];
    
    image = [image resizeToWidth:_cropSize.width height:_cropSize.height];
    
    return image;
}

#pragma UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [self imageView];
}

- (void)dealloc {
    [_scrollView release];
    _scrollView = nil;
    [_imageView release];
    _imageView = nil;
    [_maskView release];
    _maskView = nil;
    [_image release];
    _image = nil;
    [super dealloc];
}
@end

#pragma KISnipImageMaskView

#define kMaskViewBorderWidth 2.0f

@implementation KICropImageMaskView

- (void)setCropSize:(CGSize)size
{
    CGFloat x = (CGRectGetWidth(self.bounds) - size.width) / 2;
    CGFloat y = (CGRectGetHeight(self.bounds) - size.height) / 2;
    _cropRect = CGRectMake(x, y, size.width, size.height);
    
    [self setNeedsDisplay];
}

- (CGSize)cropSize
{
    return _cropRect.size;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect] ;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext() ;
    CGContextSetRGBFillColor(ctx, 0, 0, 0, .6) ;
    CGContextFillRect(ctx, self.bounds) ;
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor) ;
    CGContextStrokeRectWithWidth(ctx, _cropRect, kMaskViewBorderWidth) ;
    CGContextClearRect(ctx, _cropRect) ;
    
//    CGContextRelease(ctx) ;
}
@end