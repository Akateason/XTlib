//
//  UIColor+AllColors.m
//
//  Created by teason on 16/3/21.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "UIColor+AllColors.h"
#import "XTColorFetcher.h"
#import <objc/runtime.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@implementation UIColor (AllColors)

+ (BOOL)resolveClassMethod:(SEL)sel {
    NSString *selectorString = NSStringFromSelector(sel) ;
    if ([[[XTColorFetcher sharedInstance].dicData allKeys] containsObject:selectorString]) {
        Method method = class_getClassMethod(self, @selector(autoFetchColor)) ;
        return class_addMethod(object_getClass(self) ,
                               sel ,
                               method_getImplementation(method) ,
                               method_getTypeEncoding(method)) ;
    }
    return [super resolveClassMethod:sel] ;
}

+ (instancetype)autoFetchColor {
    NSString *selectorString = NSStringFromSelector(_cmd) ;
    return [[XTColorFetcher sharedInstance] xt_colorWithKey:selectorString] ;
}

@end
