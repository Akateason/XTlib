//
//  UIView+CurrentController.m
//  XTkit
//
//  Created by teason on 2017/4/20.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "UIView+CurrentController.h"

@implementation UIView (CurrentController)

- (UIViewController*)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder] ;
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController*)nextResponder ;
        }
    }
    return nil ;
}

- (UINavigationController*)navigationController
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder] ;
        if ([nextResponder isKindOfClass:[UINavigationController class]])
        {
            return (UINavigationController*)nextResponder ;
        }
    }
    return nil ;
}

@end
