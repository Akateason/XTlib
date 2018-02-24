//
//  XTRequest+UrlString.m
//  XTReq
//
//  Created by teason23 on 2018/2/23.
//  Copyright © 2018年 teaason. All rights reserved.
//

#import "XTRequest+UrlString.h"

@implementation XTRequest (UrlString)

+ (NSString *)getFinalUrlWithTrailStr:(NSString *)strPartOfUrl {
    return [self getFinalUrlWithBaseUrl:kBaseURL trailStr:strPartOfUrl] ;
}

+ (NSString *)getFinalUrlWithBaseUrl:(NSString *)baseUrlStr
                            trailStr:(NSString *)strPartOfUrl
{
    return [baseUrlStr stringByAppendingString:strPartOfUrl] ;
}

+ (NSString *)getFinalUrlWithParam:(NSDictionary *)diction {
    return [self getFinalUrlWithBaseUrl:kBaseURL param:diction] ;
}

+ (NSString *)getFinalUrlWithBaseUrl:(NSString *)baseUrlStr
                               param:(NSDictionary *)diction
{
    return [baseUrlStr stringByAppendingString:[self getTrailUrlInGetReqModeWithDic:diction]] ;
}

+ (NSString *)getTrailUrlInGetReqModeWithDic:(NSDictionary *)dict {
    NSArray *allKeys = [dict allKeys] ;
    BOOL bFirst = YES ;
    NSString *appendingStr = @"" ;
    for (NSString *key in allKeys) {
        NSString *val = [dict objectForKey:key] ;
        NSString *item = @"";
        if (bFirst) {
            bFirst = NO ;
            item = [NSString stringWithFormat:@"?%@=%@",key,val] ;
        }
        else {
            item = [NSString stringWithFormat:@"&%@=%@",key,val] ;
        }
        appendingStr = [appendingStr stringByAppendingString:item] ;
    }
    return appendingStr ;
}

@end
