
#import "XHPathCover.h"

NSString *const XHUserNameKey = @"XHUserName";
NSString *const XHBirthdayKey = @"XHBirthday";

#import <Accelerate/Accelerate.h>
#import <float.h>


@interface XHPathCover () 
{
    BOOL normal, paste, hasStop;
    BOOL isrefreshed;
}
@property (nonatomic, strong) UIView *bannerView;
@property (nonatomic, strong) UIView *showView;
@end

@implementation XHPathCover

#pragma mark - Publish Api

- (void)animateStart
{
//    [self.infoView animationForUserHead] ;
}

- (void)stopRefresh
{
    if(_touching == NO) {
        [self resetTouch];
    } else {
        hasStop = YES;
    }
}

/*
- (void)setUserObj:(User *)userObj
{
    _userObj = userObj ;
    
    self.infoView.theUser = userObj ;
}
*/

// background
- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _bannerImageView.image = backgroundImage;
}

- (void)setBackgroundImageUrlString:(NSString *)backgroundImageUrlString {
    if (backgroundImageUrlString) {
        
    }
}


- (void)setAvatarUrlString:(NSString *)avatarUrlString {
    if (avatarUrlString) {
        
    }
}

/*
- (UserInfoView *)infoView
{
    if (!_infoView) {
        _infoView = [[[NSBundle mainBundle] loadNibNamed:@"UserInfoView" owner:self options:nil] lastObject] ;
         CGRect rectInfo = _infoView.frame ;
        rectInfo.size.width = APPFRAME.size.width ;
        _infoView.frame = rectInfo ;
        _infoView.delegate = self ;
    }

    return _infoView ;
}
*/

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.touching = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.offsetY = scrollView.contentOffset.y;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(decelerate == NO) {
        self.touching = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.touching = NO;
}

#pragma mark - Propertys

- (void)setTouching:(BOOL)touching {
    if(touching)
    {
        if(hasStop) {
            [self resetTouch];
        }
        
        if(normal) {
            paste = YES;
        } else if (paste == NO ) {
            normal = YES;
        }
    }
    else
    {
        [self resetTouch];
    }
    _touching = touching;
}

- (void)setOffsetY:(CGFloat)y
{
    _offsetY = y;
    
    __weak XHPathCover *wself =self ;

    if (y < - 60 && isrefreshed == NO) {
        [wself setIsRefreshed:YES];
        if(wself.handleRefreshEvent) {
            wself.handleRefreshEvent() ;
        }
    }

    UIView *bannerSuper = _bannerImageView.superview;
    CGRect bframe = bannerSuper.frame;
    if(y < 0) {
        bframe.origin.y = y;
        bframe.size.height = -y + bannerSuper.superview.frame.size.height;
        bannerSuper.frame = bframe;
        
        CGPoint center =  _bannerImageView.center;
        center.y = bannerSuper.frame.size.height / 2;
        _bannerImageView.center = center;
        
        if (self.isZoomingEffect) {
            _bannerImageView.center = center;
            CGFloat scale = fabs(y) / self.parallaxHeight;
            _bannerImageView.transform = CGAffineTransformMakeScale(1+scale, 1+scale);
        }
    } else {
        if(bframe.origin.y != 0) {
            bframe.origin.y = 0;
            bframe.size.height = bannerSuper.superview.frame.size.height;
            bannerSuper.frame = bframe;
        }
        if(y < bframe.size.height) {
            CGPoint center =  _bannerImageView.center;
            center.y = bannerSuper.frame.size.height/2 + 0.5 * y;
            _bannerImageView.center = center;
        }
    }

}

#pragma mark - Life cycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self _setup];
    }
    return self;
}

- (void)_setup
{
    self.parallaxHeight = self.bounds.size.height ;
    
    _bannerView = [[UIView alloc] initWithFrame:self.bounds];
    _bannerView.clipsToBounds = YES;
    
    _bannerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, - self.parallaxHeight, CGRectGetWidth(_bannerView.frame), CGRectGetHeight(_bannerView.frame) + self.parallaxHeight * 2)];

    _bannerImageView.contentMode = UIViewContentModeScaleAspectFit;
//    _bannerImageView.backgroundColor = COLOR_MAIN ;
    [_bannerView addSubview:self.bannerImageView];
    [self addSubview:self.bannerView];
    
    _showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    
    _showView.backgroundColor = nil ;
    
//    [self infoView] ;
//    if (![_infoView superview]) {
//        [_showView addSubview:_infoView] ;
//    }
    
    [self addSubview:self.showView];
}

- (void)dealloc
{
    self.bannerImageView = nil;
    
    self.bannerView = nil;
    self.showView = nil;
    

}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];

}



- (void)setIsRefreshed:(BOOL)b
{
    isrefreshed = b;
}

- (void)refresh
{

}

- (void)resetTouch
{
    normal = NO;
    paste = NO;
    hasStop = NO;
    isrefreshed = NO;
}

@end
