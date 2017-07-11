//
//  NSObject+Runtime.h
//  XTkit
//
//  Created by teason23 on 2017/7/8.
//  Copyright © 2017年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>

@interface NSObject (Runtime)

- (BOOL)addMethodWithClass:(Class)class
                  selector:(SEL)selector
                       imp:(IMP)imp
                     types:(const char *)types ;

- (void)exchangeSEL1:(SEL)sel1
                SEL2:(SEL)sel2 ;

- (void)exchangeSEL1:(SEL)sel1
                SEL2:(SEL)sel2
           withClass:(Class)class ;

- (IMP)getIMPWithMethod:(Method)method ;

- (Method)getInstanceMethodWithClass:(Class)class
                            selector:(SEL)selector ;

- (BOOL)isContainSEL:(SEL)sel
             inClass:(Class)class ;

- (void)logMethodList:(Class)class ;

@end
