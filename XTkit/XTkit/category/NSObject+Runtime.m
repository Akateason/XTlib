//
//  NSObject+Runtime.m
//  XTkit
//
//  Created by teason23 on 2017/7/8.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "NSObject+Runtime.h"

@implementation NSObject (Runtime)

- (BOOL)addMethodWithClass:(Class)class
                  selector:(SEL)selector
                       imp:(IMP)imp
                     types:(const char *)types
{
    return class_addMethod(class,
                           selector,
                           imp,
                           types) ;
}

- (void)exchangeSEL1:(SEL)sel1
                SEL2:(SEL)sel2
{
    [self exchangeSEL1:sel1
                  SEL2:sel2
             withClass:[self class]] ;
}

- (void)exchangeSEL1:(SEL)sel1
                SEL2:(SEL)sel2
           withClass:(Class)class
{
    Method firstMethod  = class_getInstanceMethod(class, sel1) ;
    Method secondMethod = class_getInstanceMethod(class, sel2) ;
    method_exchangeImplementations(firstMethod, secondMethod) ;
}

- (IMP)getIMPWithMethod:(Method)method
{
    return method_getImplementation(method) ;
}

- (Method)getInstanceMethodWithClass:(Class)class
                            selector:(SEL)selector
{
    return class_getInstanceMethod(class, selector) ;
}

- (BOOL)isContainSEL:(SEL)sel
             inClass:(Class)class
{
    unsigned int count;
    Method *methodList = class_copyMethodList(class,&count) ;
    for (int i = 0; i < count; i++)
    {
        Method method = methodList[i];
        NSString *tempMethodString = [NSString stringWithUTF8String:sel_getName(method_getName(method))] ;
        if ([tempMethodString isEqualToString:NSStringFromSelector(sel)]) {
            return YES ;
        }
    }
    return NO ;
}

- (void)logMethodList:(Class)class
{
    unsigned int count ;
    Method *methodList = class_copyMethodList(class,&count) ;
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        NSLog(@"logMethodList : %s",sel_getName(method_getName(method))) ;
    }
}

@end
