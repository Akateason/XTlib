//
//  PlistUtil.m
//  XTkit
//
//  Created by teason23 on 2017/10/25.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "PlistUtil.h"


@implementation PlistUtil

+ (NSDictionary *)dictionaryWithPlist:(NSString *)plistName {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistName
                                                          ofType:@"plist"];
    return [[NSDictionary alloc] initWithContentsOfFile:plistPath];
}

+ (NSArray *)arrayWithPlist:(NSString *)plistName {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistName
                                                          ofType:@"plist"];
    return [[NSArray alloc] initWithContentsOfFile:plistPath];
}

@end
