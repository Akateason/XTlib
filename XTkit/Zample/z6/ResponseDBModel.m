//
//  ResponseDBModel.m
//  XTkit
//
//  Created by teason23 on 2017/5/4.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "ResponseDBModel.h"

@implementation ResponseDBModel

#pragma mark - props Sqlite Keywords
+ (NSDictionary *)modelPropertiesSqliteKeywords
{
    return @{
             @"requestUrl" : @"UNIQUE" ,
             } ;
}

@end
