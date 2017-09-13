//
//  XTCacheRequest.m
//  XTkit
//
//  Created by teason23 on 2017/5/8.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "XTCacheRequest.h"
#import "XTFMDB.h"
#import "XTJson.h"
#import "YYModel.h"
#import "NSDate+XTTick.h"
#import "NSString+Extend.h"

@implementation XTCacheRequest

#pragma mark --

+ (void)cacheGET:(NSString *)url
      parameters:(NSDictionary *)param
      completion:(void(^)(id json))completion
{
    [self cacheGET:url
            header:nil
        parameters:param
        completion:completion] ;
}

+ (void)cacheGET:(NSString *)url
      parameters:(NSDictionary *)param
     judgeResult:(BOOL(^)(id json))completion
{
    [self cacheGET:url
            header:nil
        parameters:param
       judgeResult:completion] ;
}

+ (void)cacheGET:(NSString *)url
          header:(NSDictionary *)header
      parameters:(NSDictionary *)param
      completion:(void(^)(id json))completion
{
    [self cacheGET:url
            header:header
        parameters:param
               hud:NO
            policy:XTResponseCachePolicyNeverUseCache
     timeoutIfNeed:0
        completion:completion] ;
}

+ (void)cacheGET:(NSString *)url
          header:(NSDictionary *)header
      parameters:(NSDictionary *)param
     judgeResult:(BOOL (^)(id json))completion
{
    [self cacheGET:url
            header:header
        parameters:param
               hud:NO
            policy:XTResponseCachePolicyNeverUseCache
     timeoutIfNeed:0
       judgeResult:completion] ;
}

+ (void)cacheGET:(NSString *)url
          header:(NSDictionary *)header
      parameters:(NSDictionary *)param
             hud:(BOOL)hud
          policy:(XTResponseCachePolicy)cachePolicy
   timeoutIfNeed:(int)timeoutIfNeed
      completion:(void(^)(id json))completion
{
    [self cacheGET:url
            header:header
        parameters:param
               hud:hud
            policy:cachePolicy
     timeoutIfNeed:timeoutIfNeed
       judgeResult:^BOOL(id json) {
           if (completion) completion(json) ;
           return FALSE ;
       }] ;
}

+ (void)cacheGET:(NSString *)url
          header:(NSDictionary *)header
      parameters:(NSDictionary *)param
             hud:(BOOL)hud
          policy:(XTResponseCachePolicy)cachePolicy
   timeoutIfNeed:(int)timeoutIfNeed
     judgeResult:(BOOL (^)(id json))completion
{
    NSString *strUniqueKey = [self fullUrl:url param:param] ;
    XTResponseDBModel *resModel = [XTResponseDBModel xt_findFirstWhere:[NSString stringWithFormat:@"requestUrl == '%@'",strUniqueKey]] ;
    if (!resModel)
    {// not cache
        resModel = [XTResponseDBModel newDefaultModelWithKey:strUniqueKey
                                                       val:nil                         // response is nil
                                                    policy:cachePolicy
                                                   timeout:timeoutIfNeed] ;
        
        [self updateRequestWithType:XTRequestMode_GET_MODE
                                url:url
                                hud:hud
                             header:header
                              param:param
                      responseModel:resModel
                         completion:^BOOL (id json) {
                             if (completion) return completion(json) ; // return
                             return FALSE ;
                         }] ;
    }
    else
    {// has cache
        switch (resModel.cachePolicy)
        {
            case XTResponseCachePolicyNeverUseCache:
            {//从不缓存 适合每次都实时的数据流.
                [self updateRequestWithType:XTRequestMode_GET_MODE
                                        url:url
                                        hud:hud
                                     header:header
                                      param:param
                              responseModel:resModel
                                 completion:^BOOL (id json) {
                                     if (completion) return completion(json) ; // return
                                     return FALSE ;
                                 }] ;
            }
                break;
            case XTResponseCachePolicyAlwaysCache:
            {//总是获取缓存的数据.不再更新.
                if (completion) completion([XTJson getJsonWithStr:resModel.response]) ;
            }
                break;
            case XTResponseCachePolicyTimeout:
            {//规定时间内.返回缓存.超时则更新数据. 需设置timeout时间. timeout默认1小时
                if ([resModel isAlreadyTimeout])
                { // timeout . update request
                    [self updateRequestWithType:XTRequestMode_GET_MODE
                                            url:url
                                            hud:hud
                                         header:header
                                          param:param
                                  responseModel:resModel
                                     completion:^BOOL (id json) {
                                         if (completion) return completion(json) ; // return
                                         return FALSE ;
                                     }] ;
                }
                else
                { // return cache
                    if (completion) completion([XTJson getJsonWithStr:resModel.response]) ;
                }
            }
                break;
            default:
                break;
        }
    }
}

#pragma mark - 

+ (void)cachePOST:(NSString *)url
       parameters:(NSDictionary *)param
       completion:(void(^)(id json))completion
{
    [self cachePOST:url
         parameters:param
         completion:completion] ;
}

+ (void)cachePOST:(NSString *)url
       parameters:(NSDictionary *)param
      judgeResult:(BOOL (^)(id json))completion
{
    [self cachePOST:url
             header:nil
         parameters:param
        judgeResult:completion] ;
}

+ (void)cachePOST:(NSString *)url
           header:(NSDictionary *)header
       parameters:(NSDictionary *)param
       completion:(void(^)(id json))completion
{
    [self cachePOST:url
             header:header
         parameters:param
                hud:NO
             policy:XTResponseCachePolicyNeverUseCache
      timeoutIfNeed:0
         completion:completion] ;
}

+ (void)cachePOST:(NSString *)url
           header:(NSDictionary *)header
       parameters:(NSDictionary *)param
      judgeResult:(BOOL (^)(id json))completion
{
    [self cachePOST:url
             header:header
         parameters:param
                hud:NO
             policy:XTResponseCachePolicyNeverUseCache
      timeoutIfNeed:0
        judgeResult:completion] ;
}

+ (void)cachePOST:(NSString *)url
           header:(NSDictionary *)header
       parameters:(NSDictionary *)param
              hud:(BOOL)hud
           policy:(XTResponseCachePolicy)cachePolicy
    timeoutIfNeed:(int)timeoutIfNeed
       completion:(void(^)(id json))completion
{
    [self cachePOST:url
             header:header
         parameters:param
                hud:YES
             policy:cachePolicy
      timeoutIfNeed:timeoutIfNeed
        judgeResult:^BOOL(id json) {
            if (completion) completion(json) ;
            return FALSE ;
         }] ;
}

+ (void)cachePOST:(NSString *)url
           header:(NSDictionary *)header
       parameters:(NSDictionary *)param
              hud:(BOOL)hud
           policy:(XTResponseCachePolicy)cachePolicy
    timeoutIfNeed:(int)timeoutIfNeed
      judgeResult:(BOOL(^)(id json))completion
{
    NSString *strUniqueKey = [self fullUrl:url param:param] ;
    XTResponseDBModel *resModel = [XTResponseDBModel xt_findFirstWhere:[NSString stringWithFormat:@"requestUrl == '%@'",strUniqueKey]] ;
    if (!resModel)
    {// not cache
        resModel = [XTResponseDBModel newDefaultModelWithKey:strUniqueKey
                                                       val:nil                         // response is nil
                                                    policy:cachePolicy
                                                   timeout:timeoutIfNeed] ;
        
        [self updateRequestWithType:XTRequestMode_POST_MODE
                                url:url
                                hud:hud
                             header:header
                              param:param
                      responseModel:resModel
                         completion:^BOOL (id json) {
                             if (completion) return completion(json) ; // return
                             return FALSE ;
                         }] ;
    }
    else
    {// has cache
        switch (resModel.cachePolicy)
        {
            case XTResponseCachePolicyNeverUseCache:
            {//从不缓存 适合每次都实时的数据流.
                [self updateRequestWithType:XTRequestMode_POST_MODE
                                        url:url
                                        hud:hud
                                     header:header
                                      param:param
                              responseModel:resModel
                                 completion:^BOOL (id json) {
                                     if (completion) return completion(json) ; // return
                                     return FALSE ;
                                 }] ;
            }
                break;
            case XTResponseCachePolicyAlwaysCache:
            {//总是获取缓存的数据.不再更新.
                if (completion) completion([XTJson getJsonWithStr:resModel.response]) ;
            }
                break;
            case XTResponseCachePolicyTimeout:
            {//规定时间内.返回缓存.超时则更新数据. 需设置timeout时间. timeout默认1小时
                if ([resModel isAlreadyTimeout])
                { // timeout . update request
                    [self updateRequestWithType:XTRequestMode_POST_MODE
                                            url:url
                                            hud:hud
                                         header:header
                                          param:param
                                  responseModel:resModel
                                     completion:^BOOL (id json) {
                                         if (completion) return completion(json) ; // return
                                         return FALSE ;
                                     }] ;
                }
                else
                { // return cache
                    if (completion) completion([XTJson getJsonWithStr:resModel.response]) ;
                }
            }
                break;
            default:
                break;
        }
    }
}





#pragma mark --
#pragma mark - private

+ (void)updateRequestWithType:(XTRequestMode)requestType
                          url:(NSString *)url
                          hud:(BOOL)hud
                       header:(NSDictionary *)header
                        param:(NSDictionary *)param
                responseModel:(XTResponseDBModel *)resModel
                   completion:(BOOL(^)(id json))completion
{
    if (requestType == XTRequestMode_GET_MODE)
    {
        [self GETWithUrl:url
                  header:header
                     hud:hud
              parameters:param
             taskSuccess:^(NSURLSessionDataTask *task, id json) {
                 
                 BOOL bDisableCache = FALSE ;
                 if (completion) bDisableCache = completion(json) ; // return .
                 // 请求为空 . 不做更新
                 if (!json) return ;
                 // 外部禁止了缓存
                 if (bDisableCache) return ;
                 // db
                 if (!resModel.response) {
                     resModel.response = [json yy_modelToJSONString] ;
                     [resModel xt_insert] ; // db insert
                 }
                 else {
                     resModel.response = [json yy_modelToJSONString] ;
                     resModel.updateTime = [NSDate xt_getNowTick] ;
                     [resModel xt_update] ; // db update
                 }
             }
                    fail:^{
                        if (completion) completion([XTJson getJsonWithStr:resModel.response]) ;
                    }] ;
    }
    else if (requestType == XTRequestMode_POST_MODE)
    {
        [self POSTWithUrl:url
                   header:header
                      hud:hud
               parameters:param
              taskSuccess:^(NSURLSessionDataTask *task, id json) {
                  
                  BOOL bDisableCache = FALSE ;
                  if (completion) bDisableCache = completion(json) ; // return .
                  // 请求为空 . 不做更新
                  if (!json) return ;
                  // 外部禁止了缓存
                  if (bDisableCache) return ;
                  // db
                  if (!resModel.response) {
                      resModel.response = [json yy_modelToJSONString] ;
                      [resModel xt_insert] ; // db insert
                  }
                  else {
                      resModel.response = [json yy_modelToJSONString] ;
                      resModel.updateTime = [NSDate xt_getNowTick] ;
                      [resModel xt_update] ; // db update
                  }
              }
                     fail:^{
                         if (completion) completion([XTJson getJsonWithStr:resModel.response]) ;
              }] ;
    }
}




@end






