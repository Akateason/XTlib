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

- (BOOL)addMethodWithClass:(Class)cls
                  selector:(SEL)selector
                       imp:(IMP)imp
                     types:(const char *)types ;

- (void)exchangeSEL1:(SEL)sel1
                SEL2:(SEL)sel2 ;

- (void)exchangeSEL1:(SEL)sel1
                SEL2:(SEL)sel2
           withClass:(Class)cls ;

- (IMP)getIMPWithMethod:(Method)method ;

- (Method)getInstanceMethodWithClass:(Class)cls
                            selector:(SEL)selector ;

- (BOOL)isContainSEL:(SEL)sel
             inClass:(Class)cls ;

- (void)logMethodList:(Class)cls ;

@end
