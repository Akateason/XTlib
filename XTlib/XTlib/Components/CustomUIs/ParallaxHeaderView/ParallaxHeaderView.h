//
//  ParallaxHeaderView.h
//  ParallaxTableViewHeader

//

#import <UIKit/UIKit.h>


@interface ParallaxHeaderView : UIView
//@property (nonatomic) IBOutlet UILabel *headerTitleLabel;
@property (nonatomic) UIImage *headerImage;

+ (id)parallaxHeaderViewWithImage:(UIImage *)image forSize:(CGSize)headerSize;
+ (id)parallaxHeaderViewWithSubView:(UIView *)subView;
- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset;
- (void)refreshBlurViewForNewImage;
@end
