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
          policy:(XTResponseCachePolicy)cachePolicy
   timeoutIfNeed:(int)timeoutIfNeed
      completion:(void (^)(id json))completion
{
    [self cacheGET:url
        parameters:param
               hud:YES
            policy:cachePolicy
     timeoutIfNeed:timeoutIfNeed
        completion:completion] ;
}

+ (void)cacheGET:(NSString *)url
      parameters:(NSDictionary *)param
      completion:(void (^)(id json))completion
{
    [self cacheGET:url
        parameters:param
               hud:YES
            policy:XTResponseCachePolicyNeverUseCache
     timeoutIfNeed:0
        completion:completion] ;
}

+ (void)cacheGET:(NSString *)url
      parameters:(NSDictionary *)param
             hud:(BOOL)hud
          policy:(XTResponseCachePolicy)cachePolicy
   timeoutIfNeed:(int)timeoutIfNeed
      completion:(void (^)(id json))completion
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
                              param:param
                      responseModel:resModel
                         completion:^(id json) {
                             if (completion) completion(json) ; // return
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
                                      param:param
                              responseModel:resModel
                                 completion:^(id json) {
                                     if (completion) completion(json) ; // return
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
                                          param:param
                                  responseModel:resModel
                                     completion:^(id json) {
                                         if (completion) completion(json) ; // return
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


+ (void)cachePOST:(NSString *)url
       parameters:(NSDictionary *)param
       completion:(void (^)(id json))completion
{
    [self cachePOST:url
         parameters:param
                hud:YES
             policy:XTResponseCachePolicyNeverUseCache
      timeoutIfNeed:0
         completion:completion] ;
}

+ (void)cachePOST:(NSString *)url
       parameters:(NSDictionary *)param
           policy:(XTResponseCachePolicy)cachePolicy
    timeoutIfNeed:(int)timeoutIfNeed
       completion:(void (^)(id json))completion
{
    [self cachePOST:url
         parameters:param
                hud:YES
             policy:cachePolicy
      timeoutIfNeed:timeoutIfNeed
         completion:completion] ;
}

+ (void)cachePOST:(NSString *)url
       parameters:(NSDictionary *)param
              hud:(BOOL)hud
           policy:(XTResponseCachePolicy)cachePolicy
    timeoutIfNeed:(int)timeoutIfNeed
       completion:(void (^)(id json))completion
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
                              param:param
                      responseModel:resModel
                         completion:^(id json) {
                             if (completion) completion(json) ; // return
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
                                      param:param
                              responseModel:resModel
                                 completion:^(id json) {
                                     if (completion) completion(json) ; // return
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
                                          param:param
                                  responseModel:resModel
                                     completion:^(id json) {
                                         if (completion) completion(json) ; // return
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
                        param:(NSDictionary *)param
                responseModel:(XTResponseDBModel *)resModel
                   completion:(void (^)(id json))completion
{
    if (requestType == XTRequestMode_GET_MODE)
    {
        [self GETWithUrl:url
                     hud:hud
              parameters:param
                 success:^(id json) {
                     if (completion) completion(json) ; // return .
                     // 请求为空 . 不做更新
                     if (!json)
                     {
                         completion(json) ;
                         return ;
                     }
                     
                     if (!resModel.response)
                     {
                         resModel.response = [json yy_modelToJSONString] ;
                         [resModel xt_insert] ; // db insert
                     }
                     else
                     {
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
                      hud:hud
               parameters:param
                  success:^(id json) {
                      if (completion) completion(json) ; // return .
                      // 请求为空 . 不做更新
                      if (!json)
                      {
                          completion(json) ;
                          return ;
                      }
                      
                      if (!resModel.response)
                      {
                          resModel.response = [json yy_modelToJSONString] ;
                          [resModel xt_insert] ; // db insert
                      }
                      else
                      {
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






