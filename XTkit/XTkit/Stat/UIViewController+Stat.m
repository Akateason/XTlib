//
//  UIViewController+Stat.m
//  PatchBoard
//
//  Created by teason23 on 2017/7/5.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "UIViewController+Stat.h"
#import <objc/runtime.h>

@implementation UIViewController (Stat)

+ (void)load
{
    [super load] ;
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(viewDidAppear:) ;
        SEL swizzledSelector = @selector(xt_viewDidAppear:) ;
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

- (void)xt_viewDidAppear:(BOOL)animated
{
    [self xt_viewDidAppear:animated] ;
    
    NSArray *filter = @[@"UINavigationController",@"UITabBarController",@"MyNavCtrller"] ;
    NSString *className = NSStringFromClass(self.class) ;
    if ([filter containsObject:className]) return ;
    if (!self.statTitle || !self.statTitle.length) return ;
    
    // update stat .
#pragma mark - TODO
    NSLog(@"will update stat : %@",self.statTitle) ;
#pragma mark - TODO
}

static const void * kStatTitle ;
- (void)setStatTitle:(NSString *)statTitle
{
    objc_setAssociatedObject(self,
                             kStatTitle,
                             statTitle,
                             OBJC_ASSOCIATION_COPY_NONATOMIC) ;
}

- (NSString *)statTitle
{
    NSString *res = objc_getAssociatedObject(self, kStatTitle) ;
    if (!res) res = NSStringFromClass(self.class) ;
    return res ;
}

@end















