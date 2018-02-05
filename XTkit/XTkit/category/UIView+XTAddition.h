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
- (void)resignAllResponderWhenTapThis ;

@end


@interface UIView (CurrentController)

- (UIViewController*)viewController ;

- (UINavigationController*)navigationController ;

- (NSString *)chainInfo ;

@end
