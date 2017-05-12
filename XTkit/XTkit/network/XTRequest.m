//
//  AppDelegate.m
//  XTRequest
//
//  Created by TuTu on 15/11/12.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "XTRequest.h"
#import "AFNetworking.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "YYModel.h"
#import "XTJson.h"
#import "UrlRequestHeader.h"
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
    
    XTReqSessionManager *manager = [XTReqSessionManager shareInstance] ;
    
    [manager GET:url
      parameters:dict
        progress:nil //^(NSProgress * _Nonnull downloadProgress) {}
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
    if (hud) [SVProgressHUD show] ;
    
    XTReqSessionManager *manager = [XTReqSessionManager shareInstance] ;
    
    [manager POST:url
       parameters:dict
         progress:nil //^(NSProgress * _Nonnull uploadProgress) {}
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





//  sync
#pragma mark --
#pragma mark - sync
+ (XTReqResonse *)getResultWithURLstr:(NSString *)urlstr
                                  param:(NSDictionary *)dict
                                   mode:(XTRequestMode)mode
{
    XTReqResonse *result = [self getResultWithURLstr:urlstr
                                                 param:dict
                                                  mode:mode
                                                   hud:TRUE] ;
    return result ;
}

+ (XTReqResonse *)getResultWithURLstr:(NSString *)urlstr
                                  param:(NSDictionary *)dict
                                   mode:(XTRequestMode)mode
                                    hud:(BOOL)hud
{
    id jsonObj = [self getJsonObjectWithURLstr:urlstr
                                         param:dict
                                          mode:mode
                                           hud:hud] ;
    return [XTReqResonse yy_modelWithJSON:jsonObj] ;
}

+ (id)getJsonObjectWithURLstr:(NSString *)urlstr
                        param:(NSDictionary *)dict
                         mode:(XTRequestMode)mode
{
    return [self getJsonObjectWithURLstr:urlstr
                                   param:dict
                                    mode:mode
                                     hud:TRUE] ;
}

+ (id)getJsonObjectWithURLstr:(NSString *)urlstr
                        param:(NSDictionary *)dict
                         mode:(XTRequestMode)mode
                          hud:(BOOL)hud
{
    if (hud) [SVProgressHUD show] ;
    NSString *response = nil ;
    if (mode == XTRequestMode_GET_MODE)
    {
        NSString *apStr = [self getUrlInGetModeWithDic:dict] ;
        urlstr = [urlstr stringByAppendingString:apStr] ;
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlstr]];
        request.timeOutSeconds = kTIMEOUT ;
        [request startSynchronous] ;
        NSError *error = [request error] ;
        if (error)
        {
            NSLog(@"xt_req fail error:%@",error) ;
            return nil ;
        }
        response = [request responseString] ;
    }
    else if (mode == XTRequestMode_POST_MODE)
    {
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlstr]] ;
        request.timeOutSeconds = kTIMEOUT ;
        
        NSArray *allKeys = [dict allKeys] ;
        for (NSString *key in allKeys)
        {
            NSString *val = [dict objectForKey:key] ;
            [request setPostValue:val forKey:key] ;
        }
        [request startSynchronous] ;
        NSError *error = [request error] ;
        
        if (error)
        {
            NSLog(@"xt_req fail error : %@",error) ;
            return nil ;
        }
        response = [request responseString] ;
    }
    NSLog(@"urlstr : %@\nresponse : %@\n",urlstr,response) ;
    if (hud) [SVProgressHUD dismiss] ;
    return [XTJson getJsonWithStr:response] ;
}



#pragma mark --
#pragma mark - private
+ (NSString *)getUrlInGetModeWithDic:(NSDictionary *)dict
{
    NSArray *allKeys = [dict allKeys] ;
    BOOL bFirst = YES ;
    NSString *appendingStr = @"" ;
    for (NSString *key in allKeys)
    {
        NSString *val = [dict objectForKey:key] ;
        NSString *item = @"";
        if (bFirst)
        {
            bFirst = NO ;
            item = [NSString stringWithFormat:@"?%@=%@",key,val] ;
        }
        else
        {
            item = [NSString stringWithFormat:@"&%@=%@",key,val] ;
        }
        
        appendingStr = [appendingStr stringByAppendingString:item] ;
    }
    
    return appendingStr ;
}

+ (NSString *)fullUrl:(NSString *)url param:(NSDictionary *)param
{
    return [url stringByAppendingString:[self getUrlInGetModeWithDic:param]] ;
}


@end




