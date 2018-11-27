//
//  TestSon.m
//  XTlib
//
//  Created by teason23 on 2018/11/26.
//  Copyright © 2018 teason23. All rights reserved.
//

#import "TestSon.h"

@implementation TestSon

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"[self class] %@", NSStringFromClass([self class]));
        NSLog(@"[super class] %@", NSStringFromClass([super class]));
    }
    return self;
}

/*
 2018-11-26 17:46:08.226809+0800 XTlib[33055:1381392] [self class] TestSon
 2018-11-26 17:46:08.226999+0800 XTlib[33055:1381392] [super class] TestSon
 class 获取当前方法的调用者的类，superClass 获取当前方法的调用者的父类，super 仅仅是一个编译指示器，就是给编译器看的，不是一个指针。
 本质：只要编译器看到super这个标志，就会让当前对象去调用父类方法，本质还是当前对象在调用
 https://juejin.im/post/593f77085c497d006ba389f0#comment
 */

@end
