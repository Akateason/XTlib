//
//  XTResponseDBModel.m
//  XTkit
//
//  Created by teason23 on 2017/5/10.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "XTResponseDBModel.h"
#import "NSDate+XTTick.h"
#import "NSString+Extend.h"

@implementation XTResponseDBModel
@synthesize response = _response ;

#pragma mark - props Sqlite Keywords
+ (NSDictionary *)modelPropertiesSqliteKeywords
{
    return @{
             @"requestUrl" : @"UNIQUE" ,
             } ;
}


#pragma mark --
#pragma mark - setter
- (void)setResponse:(NSString *)response
{
    if (!response) return ;
    _response = [response encodeTransferredMeaningForSingleQuotes] ; // 去掉'号 转义
}

// get decode response
- (NSString *)decodeResponse
{
    return [self.response decodeTransferredMeaningForSingleQuotes] ;
}


#pragma mark --
#pragma mark - public
// new a Default Model
+ (instancetype)newDefaultModelWithKey:(NSString *)urlStr
                                   val:(NSString *)respStr
{
    return [self newDefaultModelWithKey:urlStr
                                    val:respStr
                                 policy:0
                                timeout:0] ;
}

+ (instancetype)newDefaultModelWithKey:(NSString *)urlStr
                                   val:(NSString *)respStr
                                policy:(int)policy
                               timeout:(int)timeout
{
    if (!policy) policy = XTResponseCachePolicyNeverUseCache ; // default policy
    if (policy == XTResponseCachePolicyTimeout && !timeout) timeout = 60 * 60 ; // 1hour default timeout if need .
    XTResponseDBModel *dbModel = [[XTResponseDBModel alloc] init] ;
    dbModel.requestUrl = urlStr ;
    dbModel.response = respStr ;
    dbModel.cachePolicy = policy ;
    dbModel.timeout = timeout ;
    dbModel.createTime = [NSDate xt_getNowTick] ;
    dbModel.updateTime = dbModel.createTime ;
    return dbModel ;
}

- (BOOL)isAlreadyTimeout
{
    NSDate *now = [NSDate date] ;
    NSDate *dateUpdate = [NSDate xt_getDateWithTick:self.updateTime] ;
    NSDate *dateWillTimeout = [NSDate dateWithTimeInterval:self.timeout
                                                 sinceDate:dateUpdate] ;
    NSComparisonResult result = [dateWillTimeout compare:now] ;
    return result == NSOrderedAscending ;
}

@end
