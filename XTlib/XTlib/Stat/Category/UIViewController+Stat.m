//
//  UIViewController+Stat.m
//  PatchBoard
//
//  Created by teason23 on 2017/7/5.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "UIViewController+Stat.h"
#import <objc/runtime.h>
#import "CtrllerEvent.h"
#import "XTStatConst.h"

@implementation UIViewController (Stat)

+ (void)load
{
    [super load] ;
    
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{        
        [self swizzledOrigin:@selector(viewDidLoad)
                         new:@selector(xt_viewDidLoad)] ;
        [self swizzledOrigin:@selector(viewWillAppear:)
                         new:@selector(xt_viewWillAppear:)] ;
        [self swizzledOrigin:@selector(viewWillDisappear:)
                         new:@selector(xt_viewWillDisappear:)] ;
        [self swizzledOrigin:NSSelectorFromString(@"dealloc")
                         new:@selector(xt_dealloc)] ;
    }) ;
}

+ (void)swizzledOrigin:(SEL)originalSelector
                   new:(SEL)swizzledSelector
{
    Method originalMethod = class_getInstanceMethod(self.class, originalSelector) ;
    Method swizzledMethod = class_getInstanceMethod(self.class, swizzledSelector) ;
    method_exchangeImplementations(originalMethod, swizzledMethod) ;
}

- (void)xt_viewDidLoad
{
    [self collectStatInfo:@"viewDidLoad"] ;
    [self xt_viewDidLoad] ;
}

- (void)xt_viewWillAppear:(BOOL)animated
{
    [self collectStatInfo:@"viewWillAppear"] ;
    [self xt_viewWillAppear:animated] ;
}

- (void)xt_viewWillDisappear:(BOOL)animated
{
    [self collectStatInfo:@"viewWillDisappear"] ;
    [self xt_viewWillDisappear:animated] ;
}

- (void)xt_dealloc
{
    [self collectStatInfo:@"dealloc"] ;
    [self xt_dealloc] ;
}

- (void)collectStatInfo:(NSString *)funcName
{
    if (!xt_Run_Stat) return ;
    
    NSArray *filter = @[@"UINavigationController",@"UITabBarController",@"MyNavCtrller"] ;
    NSString *className = NSStringFromClass(self.class) ;
    if ([filter containsObject:className]) return ;
    if (!self.statTitle || !self.statTitle.length) return ;
    XTSTATLog(@"%@ : %@",funcName,self.statTitle) ;
    CtrllerEvent *cEvent = [[CtrllerEvent alloc] initWithName:NSStringFromClass(self.class)
                                                        title:self.statTitle
                                                       action:funcName
                                                      ctrller:self] ;
    [cEvent insert] ;
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















