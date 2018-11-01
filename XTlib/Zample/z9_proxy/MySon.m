//
//  MySon.m
//  XTkit
//
//  Created by teason23 on 2017/10/25.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "MySon.h"
#import <objc/runtime.h>


@interface MySon () {
    Father *_father;
    Mother *_mother;
    NSMutableDictionary *_methodsMap;
}
@end


@implementation MySon

#pragma mark - class method

+ (instancetype)sonProxy {
    return [[MySon alloc] init];
}

#pragma mark - init

- (instancetype)init {
    _methodsMap = [NSMutableDictionary dictionary];
    _father     = [[Father alloc] init];
    _mother     = [[Mother alloc] init];

    //映射target及其对应方法名
    [self _registerMethodsWithTarget:_father];
    [self _registerMethodsWithTarget:_mother];

    return self;
}

#pragma mark - private method
- (void)_registerMethodsWithTarget:(id)target {
    unsigned int numberOfMethods = 0;
    //获取target方法列表
    Method *method_list = class_copyMethodList([target class], &numberOfMethods);
    for (int i = 0; i < numberOfMethods; i++) {
        //获取方法名并存入字典
        Method temp_method           = method_list[i];
        SEL temp_sel                 = method_getName(temp_method);
        const char *temp_method_name = sel_getName(temp_sel);
        [_methodsMap setObject:target forKey:[NSString stringWithUTF8String:temp_method_name]];
    }
    free(method_list);
}

#pragma mark - NSProxy override methods

- (void)forwardInvocation:(NSInvocation *)invocation {
    //获取当前选择子
    SEL sel = invocation.selector;
    //获取选择子方法名
    NSString *methodName = NSStringFromSelector(sel);
    //在字典中查找对应的target
    id target = _methodsMap[methodName];
    //检查target
    if (target && [target respondsToSelector:sel]) {
        [invocation invokeWithTarget:target];
    }
    else {
        [super forwardInvocation:invocation];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    //获取选择子方法名
    NSString *methodName = NSStringFromSelector(sel);
    //在字典中查找对应的target
    id target = _methodsMap[methodName];
    //检查target
    if (target && [target respondsToSelector:sel]) {
        return [target methodSignatureForSelector:sel];
    }
    else {
        return [super methodSignatureForSelector:sel];
    }
}

@end
