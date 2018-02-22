//
//  UniqueKeyMaker.m
//  XTkit
//
//  Created by teason23 on 2017/7/24.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "UniqueKeyMaker.h"
#import "NSString+MD5.h"

@implementation UniqueKeyMaker

+ (NSString *)makeUniqueKey:(NSArray *)strList {
    NSString *appending = @"" ;
    for (id obj in strList) {
        if ([obj isKindOfClass:[NSString class]]) {
            appending = [appending stringByAppendingString:obj] ;
        }
        else {
            NSString *str = [NSString stringWithFormat:@"%@",obj] ;
            appending = [appending stringByAppendingString:str] ;
        }
    }
    return [appending MD5] ;
}

@end
