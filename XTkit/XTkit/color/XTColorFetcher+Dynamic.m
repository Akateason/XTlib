//
//  XTColorFetcher+Dynamic.m
//  XTkit
//
//  Created by teason23 on 2017/7/10.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "XTColorFetcher+Dynamic.h"
#import <objc/runtime.h>

@implementation XTColorFetcher (Dynamic)

+ (void)load
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"xtAllColorsList" ofType:@"plist"] ;
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath] ;
    for (NSString *key in data)
    {
        class_addMethod([self class],
                        NSSelectorFromString(key),
                        class_getMethodImplementation(self,@selector(startEngine)),
                        "c@:") ;
    }
}

- (UIColor *)startEngine
{
     XTCOLOR
}

- (UIColor *)fetchColor:(NSString *)color
{
    SEL selector = NSSelectorFromString(color) ;
    IMP imp = [[XTColorFetcher sharedInstance] methodForSelector:selector] ;
    UIColor *(*func)(id, SEL) = (void *)imp ;
    return func([XTColorFetcher sharedInstance], selector) ;
}

@end













