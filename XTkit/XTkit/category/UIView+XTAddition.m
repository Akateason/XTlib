//
//  UIView+XTAddition.m
//  XTkit
//
//  Created by xtc on 2018/2/5.
//  Copyright © 2018年 teason. All rights reserved.
//

#import "UIView+XTAddition.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation UIView (XTAddition)

- (void)resignAllResponderWhenTapThis {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init] ;
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil] ;
    }] ;
    [self addGestureRecognizer:tap] ;
}

@end



@implementation UIView (CurrentController)

- (UIViewController *)viewController
{
    for (UIView *next = [self superview] ; next ; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder] ;
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder ;
        }
    }
    return nil ;
}

- (UINavigationController *)navigationController
{
    for (UIView *next = [self superview] ; next ; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder] ;
        if ([nextResponder isKindOfClass:[UINavigationController class]])
        {
            return (UINavigationController *)nextResponder ;
        }
    }
    return nil ;
}


static NSString *const kSeperateLine = @"/" ;
/**
 view chainInfo
 @return string  @"subview/superview/currentController"
 */
- (NSString *)chainInfo

{
    NSMutableString *tmpString = [@"" mutableCopy] ;
    for (UIView *next = self ; next ; next = next.superview)
    {
        [tmpString appendFormat:@"%@%@",NSStringFromClass(next.class),kSeperateLine] ;
        UIResponder *nextResponder = [next nextResponder] ;
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            [tmpString appendFormat:@"%@%@",NSStringFromClass(nextResponder.class),kSeperateLine] ;
            break ;
        }
    }
    return tmpString ;
}

@end
