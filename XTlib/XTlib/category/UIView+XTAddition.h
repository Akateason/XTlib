//
//  UIView+XTAddition.h
//  XTkit
//
//  Created by xtc on 2018/2/5.
//  Copyright © 2018年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XTAddition)

// tap self to hide keyboard
- (void)xt_resignAllResponderWhenTapThis ;

+ (UIWindow *)xt_topWindow ;

@end


@interface UIView (CurrentController)

- (UIViewController*)viewController ;

- (UINavigationController*)navigationController ;

- (NSString *)chainInfo ;

@end



@interface UIView (MakeScollView)

- (UIScrollView *)xt_wrapperWithScrollView ;
- (UIScrollView *)xt_wrapperWithHorizontalScrollView ;

@end