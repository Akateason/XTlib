//
//  UIView+CurrentController.h
//  XTkit
//
//  Created by teason on 2017/4/20.
//  Copyright © 2017年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CurrentController)

- (UIViewController*)viewController ;

- (UINavigationController*)navigationController ;

- (NSString *)chainInfo ;

@end
