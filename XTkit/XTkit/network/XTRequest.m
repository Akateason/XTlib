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

NSString *const kStringBadNetwork = @"网络请求失败" ;
NSString *const kStringNetworkNotConnect = @"网络连接不可用" ;

@implementation XTRequest

#pragma mark --
#pragma mark - get URL with strPartOfUrl
+ (NSString *)getFinalUrl:(NSString *)strPartOfUrl { return [kBaseURL stringByAppendingString:strPartOfUrl] ; }
+ (NSMutableDictionary *)getParameters { return [@{} mutableCopy] ; }



//  status
#pragma mark --
#pragma mark - status

+ (void)startMonitor {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring] ;
}

+ (void)stopMonitor {
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring] ;
}

+ (NSString *)netWorkStatus {
    return [[AFNetworkReachabilityManager sharedManager] localizedNetworkReachabilityStatusString] ;
}

+ (BOOL)isWifi {
    return [[AFNetworkReachabilityManager sharedManager] isReachableViaWiFi] ;
}

+ (BOOL)isReachable {
    return [[AFNetworkReachabilityManager sharedManager] isReachable] ;
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
             
            [[XTReqSessionManager shareInstance] reset] ;
            if (success) {
                if (hud) [SVProgressHUD dismiss] ;
                NSLog(@"url : %@ \nparam : %@",url,dict) ;
                NSLog(@"resp %@",responseObject) ;
                success(task,responseObject) ;
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [[XTReqSessionManager shareInstance] reset] ;
            if (fail) {
                if (hud) [SVProgressHUD showErrorWithStatus:kStringBadNetwork] ;
                NSLog(@"xt_req fail Error:%@", error) ;
                fail() ;
            }

        }] ;
}

+ (void)GETWithUrl:(NSString *)url
            header:(NSDictionary *)header
               hud:(BOOL)hud
        parameters:(NSDictionary *)dict
       taskSuccess:(void (^)(NSURLSessionDataTask *, id))success
              fail:(void (^)())fail
{
    if (hud) [SVProgressHUD show] ;
    
    if (header) {
        for (NSString *key in header) {
            NSString *value = header[key] ;
            [[XTReqSessionManager shareInstance].requestSerializer setValue:value
                                                         forHTTPHeaderField:key] ;
        }
    }
    
    [[XTReqSessionManager shareInstance] GET:url
                                  parameters:dict
                                    progress:nil
                                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                         [[XTReqSessionManager shareInstance] reset] ;
                                         if (success) {
                                             if (hud) [SVProgressHUD dismiss] ;
                                             NSLog(@"url : %@ \nparam : %@",url,dict) ;
                                             NSLog(@"resp %@",responseObject) ;
                                             success(task,responseObject) ;
                                         }
                                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                         NSLog(@"xt_req fail Error:%@", error) ;
                                         [[XTReqSessionManager shareInstance] reset] ;
                                         if (fail) {
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
                                          
                                          [[XTReqSessionManager shareInstance] reset] ;
                                          if (success) {
                                              if (hud) [SVProgressHUD dismiss] ;
                                              
                                              NSLog(@"url : %@ \nparam : %@",url,dict) ;
                                              NSLog(@"resp %@",responseObject) ;
                                              success(task , responseObject) ;
                                          }
                                          
                                      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                          
                                          NSLog(@"xt_req fail Error: %@", error) ;
                                          [[XTReqSessionManager shareInstance] reset] ;
                                          if (fail) {
                                              if (hud) [SVProgressHUD showErrorWithStatus:kStringBadNetwork] ;
                                              fail() ;
                                          }
                                          
                                      }] ;
}

// post body raw
+ (void)POSTWithURL:(NSString *)url
             header:(NSDictionary *)header
              param:(NSDictionary *)param
            rawBody:(NSString *)rawBody
                hud:(BOOL)hud
            success:(void (^)(id json))success
               fail:(void (^)())fail
{
    if (hud) [SVProgressHUD show] ;

    NSData *data = [rawBody dataUsingEncoding:NSUTF8StringEncoding] ;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST"
                                                                                 URLString:url
                                                                                parameters:param
                                                                                     error:nil] ;
    request.timeoutInterval = 15 ;
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"] ;
    if (header) {
        for (NSString *key in header) {
            [request setValue:header[key] forHTTPHeaderField:key] ;
        }
    }
    
    [request setHTTPBody:data] ;
    
    [[[XTReqSessionManager shareInstance] dataTaskWithRequest:request
                                            completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                if (hud) [SVProgressHUD dismiss] ;

                                                NSLog(@"url : %@ \nparam : %@",url,param) ;
                                                NSLog(@"resp %@",responseObject) ;
                                                [[XTReqSessionManager shareInstance] reset] ;
                                                if (!error) {
                                                    success(responseObject) ;
                                                } else {
                                                    fail();
                                                    if (hud) [SVProgressHUD showErrorWithStatus:kStringBadNetwork] ;
                                                }
                                            }] resume] ;
}




static inline dispatch_queue_t xt_getCompletionQueue() { return dispatch_queue_create("xt_ForAFnetworkingSync", NULL) ; }

// sync
+ (id)syncWithReqMode:(XTRequestMode)mode
              timeout:(int)timeout
                  url:(NSString *)url
               header:(NSDictionary *)header
           parameters:(NSDictionary *)dict
{
    __block id result = nil ;
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init] ;
        manager.requestSerializer  = [AFHTTPRequestSerializer serializer] ;
        manager.responseSerializer = [AFJSONResponseSerializer serializer] ;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain",nil] ;
        manager.requestSerializer.timeoutInterval = timeout ;
        manager.completionQueue = xt_getCompletionQueue() ;
        if (header) {
            for (NSString *key in header) {
                [manager.requestSerializer setValue:header[key]
                                 forHTTPHeaderField:key] ;
            }
        }
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0) ;
        switch (mode) {
            case XTRequestMode_GET_MODE:
            {
                [manager GET:url
                  parameters:dict
                    progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         result = responseObject ;
                         dispatch_semaphore_signal(semaphore) ;
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         dispatch_semaphore_signal(semaphore) ;
                     }] ;
            }
                break ;
            case XTRequestMode_POST_MODE:
            {
                [manager POST:url
                   parameters:dict
                     progress:nil
                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                          result = responseObject ;
                          dispatch_semaphore_signal(semaphore) ;
                      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                          dispatch_semaphore_signal(semaphore) ;
                      }] ;
            }
                break ;
        }
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER) ;
    }] ;
    [operation start] ;
    [operation waitUntilFinished] ;
    
    return result ;
}

+ (id)syncWithReqMode:(XTRequestMode)mode
                  url:(NSString *)url
              header:(NSDictionary *)header
          parameters:(NSDictionary *)dict
{
    return [self syncWithReqMode:mode
                         timeout:kTIMEOUT
                             url:url
                          header:header
                      parameters:dict] ;
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




