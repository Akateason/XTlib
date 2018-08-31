//
//  NSObject+Runtime.m
//  XTkit
//
//  Created by teason23 on 2017/7/8.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "NSObject+Runtime.h"

@implementation NSObject (Runtime)

- (BOOL)addMethodWithClass:(Class)cls
                  selector:(SEL)selector
                       imp:(IMP)imp
                     types:(const char *)types
{
    return class_addMethod(cls,
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
           withClass:(Class)cls
{
    Method firstMethod  = class_getInstanceMethod(cls, sel1) ;
    Method secondMethod = class_getInstanceMethod(cls, sel2) ;
    method_exchangeImplementations(firstMethod, secondMethod) ;
}

- (IMP)getIMPWithMethod:(Method)method
{
    return method_getImplementation(method) ;
}

- (Method)getInstanceMethodWithClass:(Class)cls
                            selector:(SEL)selector
{
    return class_getInstanceMethod(cls, selector) ;
}

- (BOOL)isContainSEL:(SEL)sel
             inClass:(Class)cls
{
    unsigned int count;
    Method *methodList = class_copyMethodList(cls,&count) ;
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

- (void)logMethodList:(Class)cls
{
    unsigned int count ;
    Method *methodList = class_copyMethodList(cls,&count) ;
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        NSLog(@"logMethodList : %s",sel_getName(method_getName(method))) ;
    }
}

@end
