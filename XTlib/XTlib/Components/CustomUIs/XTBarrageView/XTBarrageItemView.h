

#import <UIKit/UIKit.h>
//#import "ArticleComment.h"


@interface XTBarrageItemView : UIView

@property (nonatomic, copy) NSString *strWillShow;
@property (assign, nonatomic) NSInteger itemIndex;

- (void)setFlywordWithComment:(id)comment;
- (void)setFlywordWithComment:(id)comment
                   WithBorder:(BOOL)hasBorder;

//- (void)setAvatarWithImage:(UIImage *)image withContent:(NSString *)content;
//- (void)setAvatarWithImageString:(NSString *)imageStr withContent:(NSString *)content;

@end
