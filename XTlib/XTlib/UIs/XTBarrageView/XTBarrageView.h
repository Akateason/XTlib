

#import <UIKit/UIKit.h>

@interface XTBarrageView : UIView

/**
 *  dataArray's object is NSDictionary
 *  key "avatar" is NSString or UIImage or ImageUrl
 *  key "content" is NSString
 */
@property (strong, nonatomic)NSArray *dataArray;

- (void)start;
- (void)stop;

@end
