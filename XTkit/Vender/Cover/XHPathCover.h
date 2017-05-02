
#import <UIKit/UIKit.h>
//#import "User.h"
//#import "UserInfoView.h"

// user info key for Dictionary
extern NSString *const XHUserNameKey;
extern NSString *const XHBirthdayKey;

@interface XHPathCover : UIView
//@property (nonatomic, strong) User *userObj ;
//@property (nonatomic, strong) UserInfoView *infoView ;

// parallax background
@property (nonatomic, strong) UIImageView *bannerImageView;

//scrollView call back
@property (nonatomic) BOOL touching;
@property (nonatomic) CGFloat offsetY;

// parallax background origin Y for parallaxHeight
@property (nonatomic, assign) CGFloat parallaxHeight; // default is 170， this height was not self heigth.

@property (nonatomic, assign) BOOL isZoomingEffect; // default is NO， if isZoomingEffect is YES, will be dissmiss parallax effect
@property (nonatomic, assign) BOOL isLightEffect; // default is YES
@property (nonatomic, assign) CGFloat lightEffectPadding; // default is 80
@property (nonatomic, assign) CGFloat lightEffectAlpha; // default is 1.12 (between 1 - 2)

@property (nonatomic, copy) void(^handleRefreshEvent)(void);

//@property (nonatomic, copy) void(^handleTapBackgroundImageEvent)(void);

// stop Refresh
- (void)stopRefresh;

// background image
- (void)setBackgroundImage:(UIImage *)backgroundImage;
// custom set url for subClass， There is not work
- (void)setBackgroundImageUrlString:(NSString *)backgroundImageUrlString;

- (void)animateStart ;

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
@end
