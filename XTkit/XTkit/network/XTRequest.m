//
//  XTRequest
//
//  Created by TuTu on 15/11/12.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "XTRequest.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "YYModel.h"
#import "XTReqResonse.h"
#import "XTReqSessionManager.h"


static NSString *const kStringBadNetwork = @"网络状况差" ;

#define ACCEPTABLE_CONTENT_TYPES                    @"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain"


@implementation XTRequest

#pragma mark --
#pragma mark - get URL with strPartOfUrl
+ (NSString *)getFinalUrl:(NSString *)strPartOfUrl { return [kBaseURL stringByAppendingString:strPartOfUrl] ; }
+ (NSMutableDictionary *)getParameters { return [@{} mutableCopy] ; }



//  status
#pragma mark --
#pragma mark - status

+ (void)netWorkStatus
{
    [self netWorkStatus:nil] ;
}

+ (void)netWorkStatus:(void (^)(NSInteger status))block
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"网络状态 : %@", @(status)) ;
        block(status) ;
    }] ;
    [[AFNetworkReachabilityManager sharedManager] startMonitoring] ;
}



//  async
#pragma mark --
#pragma mark - async

+ (void)GETWithUrl:(NSString *)url
        parameters:(NSDictionary *)dict
           success:(void (^)(id json))success
              fail:(void (^)())fail
{
    [self GETWithUrl:url
                 hud:YES
          parameters:dict
             success:success
                fail:fail] ;
}

+ (void)GETWithUrl:(NSString *)url
               hud:(BOOL)hud
        parameters:(NSDictionary *)dict
           success:(void (^)(id json))success
              fail:(void (^)())fail
{
    [self GETWithUrl:url
                 hud:hud
          parameters:dict
         taskSuccess:^(NSURLSessionDataTask *task, id json) {
             success(json) ;
         }
                fail:fail] ;
}

+ (void)GETWithUrl:(NSString *)url
               hud:(BOOL)hud
        parameters:(NSDictionary *)dict
       taskSuccess:(void (^)(NSURLSessionDataTask * task ,id json))success
              fail:(void (^)())fail
{
    if (hud) [SVProgressHUD show] ;
    
    [[XTReqSessionManager shareInstance] GET:url
                                  parameters:dict
                                    progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
            if (success)
            {
                if (hud) [SVProgressHUD dismiss] ;
                NSLog(@"url : %@ \nparam : %@",url,dict) ;
                NSLog(@"resp %@",responseObject) ;
                success(task,responseObject) ;
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"xt_req fail Error:%@", error) ;
            if (fail)
            {
                if (hud) [SVProgressHUD showErrorWithStatus:kStringBadNetwork] ;
                fail() ;
            }

        }] ;
}

+ (void)POSTWithUrl:(NSString *)url
         parameters:(NSDictionary *)dict
            success:(void (^)(id json))success
               fail:(void (^)())fail
{
    [self POSTWithUrl:url
                  hud:YES
           parameters:dict
              success:success
                 fail:fail] ;
}

+ (void)POSTWithUrl:(NSString *)url
                hud:(BOOL)hud
         parameters:(NSDictionary *)dict
            success:(void (^)(id json))success
               fail:(void (^)())fail
{
    [self POSTWithUrl:url
                  hud:hud
           parameters:dict
          taskSuccess:^(NSURLSessionDataTask *task, id json) {
              success(json) ;
          } fail:fail] ;
}

+ (void)POSTWithUrl:(NSString *)url
                hud:(BOOL)hud
         parameters:(NSDictionary *)dict
        taskSuccess:(void (^)(NSURLSessionDataTask * task ,id json))success
               fail:(void (^)())fail
{
    [self POSTWithUrl:url
               header:nil
                  hud:hud
           parameters:dict
          taskSuccess:success
                 fail:fail] ;
}

+ (void)POSTWithUrl:(NSString *)url
             header:(NSDictionary *)header
                hud:(BOOL)hud
         parameters:(NSDictionary *)dict
        taskSuccess:(void (^)(NSURLSessionDataTask * task ,id json))success
               fail:(void (^)())fail
{
    if (hud) [SVProgressHUD show] ;
    
    if (header)
    {
        for (NSString *key in header)
        {
            NSString *value = header[key] ;
            [[XTReqSessionManager shareInstance].requestSerializer setValue:value
                                                         forHTTPHeaderField:key] ;
        }
    }
    
    [[XTReqSessionManager shareInstance] POST:url
                                   parameters:dict
                                     progress:nil
                                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                          
                                          if (success)
                                          {
                                              if (hud) [SVProgressHUD dismiss] ;
                                              
                                              NSLog(@"url : %@ \nparam : %@",url,dict) ;
                                              NSLog(@"resp %@",responseObject) ;
                                              success(task , responseObject) ;
                                          }
                                          
                                      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                          
                                          NSLog(@"xt_req fail Error: %@", error) ;
                                          if (fail)
                                          {
                                              if (hud) [SVProgressHUD showErrorWithStatus:kStringBadNetwork] ;
                                              fail() ;
                                          }
                                          
                                      }] ;
}


// sync
+ (id)syncGetWithUrl:(NSString *)url
          parameters:(NSDictionary *)dict
{
    __block id result = nil ;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0) ;
    [self GETWithUrl:url
                 hud:NO
          parameters:dict
         taskSuccess:^(NSURLSessionDataTask *task, id json) {
             result = json ;
             dispatch_semaphore_signal(semaphore) ;
         } fail:^{
             dispatch_semaphore_signal(semaphore) ;
         }] ;
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER) ;
    return result ;
}

+ (id)syncPostWithUrl:(NSString *)url
           parameters:(NSDictionary *)dict
{
    __block id result = nil ;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0) ;
    [self POSTWithUrl:url
                  hud:NO
           parameters:dict
          taskSuccess:^(NSURLSessionDataTask *task, id json) {
              result = json ;
              dispatch_semaphore_signal(semaphore) ;
          } fail:^{
              dispatch_semaphore_signal(semaphore) ;
          }] ;
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER) ;
    return result ;
}


#pragma mark --
#pragma mark - private
+ (NSString *)getUrlInGetModeWithDic:(NSDictionary *)dict
{
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

+ (NSString *)fullUrl:(NSString *)url
                param:(NSDictionary *)param
{
    return [url stringByAppendingString:[self getUrlInGetModeWithDic:param]] ;
}


@end




