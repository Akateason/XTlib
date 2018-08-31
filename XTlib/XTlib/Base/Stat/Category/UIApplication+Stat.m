//
//  UIApplication+Stat.m
//  PatchBoard
//
//  Created by teason23 on 2017/7/6.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "UIApplication+Stat.h"
#import <objc/runtime.h>
#import "ApplicationEvent.h"
#import "XTStatConst.h"

@implementation UIApplication (Stat)

+ (void)load
{
    [super load] ;
    
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(sendAction:to:from:forEvent:) ;
        SEL swizzledSelector = @selector(xt_sendAction:to:from:forEvent:) ;
        Method originalMethod = class_getInstanceMethod(self.class, originalSelector) ;
        Method swizzledMethod = class_getInstanceMethod(self.class, swizzledSelector) ;
        method_exchangeImplementations(originalMethod, swizzledMethod) ;
    }) ;
}

- (BOOL)xt_sendAction:(SEL)action
                   to:(nullable id)target
                 from:(nullable id)sender
             forEvent:(nullable UIEvent *)event
{
    if (!xt_Run_Stat) return [self xt_sendAction:action
                                              to:target
                                            from:sender
                                        forEvent:event] ;

    XTSTATLog(@"\naction:%@\ntarget:%@\nsender:%@\nevent:%@",NSStringFromSelector(action),target,sender,event) ;
    ApplicationEvent *aEvent = [[ApplicationEvent alloc] initWithSEL:action
                                                                  to:target
                                                                from:sender
                                                            forEvent:event] ;
    [aEvent insert] ;
    
    return [self xt_sendAction:action
                            to:target
                          from:sender
                      forEvent:event] ;
}


@end
