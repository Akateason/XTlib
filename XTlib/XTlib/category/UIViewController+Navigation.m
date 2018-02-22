//
//  UIViewController+Navigation.m
//  XTkit
//
//  Created by teason23 on 2017/7/5.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "UIViewController+Navigation.h"
#import <objc/runtime.h>

@implementation UIViewController (Navigation)

+ (void)load
{
    [super load] ;
    
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(viewWillDisappear:) ;
        SEL swizzledSelector = @selector(xt_viewWillDisappear:) ;
        Method originalMethod = class_getInstanceMethod(self.class, originalSelector) ;
        Method swizzledMethod = class_getInstanceMethod(self.class, swizzledSelector) ;
        BOOL didAddMethod = class_addMethod(self.class,
                                            originalSelector,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod)) ;
        if (didAddMethod) {
            class_replaceMethod(self.class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod)) ;
        }
        else {
            method_exchangeImplementations(originalMethod, swizzledMethod) ;
        }
    }) ;
}

- (void)xt_viewWillDisappear:(BOOL)animated
{
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        if (self.navigationDidClickBackButton) {
            self.navigationDidClickBackButton() ;
        }
    }
    
    [self xt_viewWillDisappear:animated] ;
}



#pragma mark - prop

static const void *kNavigationDidClickBackButton ;
- (void)setNavigationDidClickBackButton:(NavigationBackButtonOnClick)navigationDidClickBackButton
{
    objc_setAssociatedObject(self,
                             &kNavigationDidClickBackButton,
                             navigationDidClickBackButton,
                             OBJC_ASSOCIATION_COPY_NONATOMIC) ;
}

- (NavigationBackButtonOnClick)navigationDidClickBackButton
{
    return objc_getAssociatedObject(self,
                                    &kNavigationDidClickBackButton) ;
}

@end
