//
//  AppDelegate.m
//  XTRequest
//
//  Created by teason on 15/11/12.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "XTReqSessionManager.h"
@class XTReqResonse , NSURLSessionDataTask ;

extern NSString *const kStringBadNetwork ;

// req mode
typedef NS_ENUM(NSInteger, XTRequestMode) {
    XTRequestMode_GET_MODE      ,
    XTRequestMode_POST_MODE
} ;

// base URL
static NSString *const kBaseURL = @"http://top.akateason.top" ;

// get PARAM
#define XT_GET_PARAM                         NSMutableDictionary *param = [XTRequest getParameters] ;





@interface XTRequest : XTReqSessionManager

// set URL string with base url
+ (NSString *)getFinalUrl:(NSString *)strPartOfUrl ;
// get url format baseurl?param1&param2&param3...
+ (NSString *)fullUrl:(NSString *)url
                param:(NSDictionary *)param ;
// param
+ (NSMutableDictionary *)getParameters ;

// status
+ (void)startMonitor ;

+ (void)stopMonitor  ;

+ (NSString *)netWorkStatus ; // reachability

+ (BOOL)isWifi ;

+ (BOOL)isReachable ;

/**
 async
 */
// get
+ (void)GETWithUrl:(NSString *)url
        parameters:(NSDictionary *)dict
           success:(void (^)(id json))success
              fail:(void (^)())fail ;

+ (void)GETWithUrl:(NSString *)url
               hud:(BOOL)hud
        parameters:(NSDictionary *)dict
           success:(void (^)(id json))success
              fail:(void (^)())fail ;

+ (void)GETWithUrl:(NSString *)url
               hud:(BOOL)hud
        parameters:(NSDictionary *)dict
       taskSuccess:(void (^)(NSURLSessionDataTask * task ,id json))success
              fail:(void (^)())fail ;

+ (void)GETWithUrl:(NSString *)url
            header:(NSDictionary *)header
               hud:(BOOL)hud
        parameters:(NSDictionary *)dict
       taskSuccess:(void (^)(NSURLSessionDataTask * task ,id json))success
              fail:(void (^)())fail ;

// post
+ (void)POSTWithUrl:(NSString *)url
         parameters:(NSDictionary *)dict
            success:(void (^)(id json))success
               fail:(void (^)())fail ;

+ (void)POSTWithUrl:(NSString *)url
                hud:(BOOL)hud
         parameters:(NSDictionary *)dict
            success:(void (^)(id json))success
               fail:(void (^)())fail ;

+ (void)POSTWithUrl:(NSString *)url
                hud:(BOOL)hud
         parameters:(NSDictionary *)dict
        taskSuccess:(void (^)(NSURLSessionDataTask * task ,id json))success
               fail:(void (^)())fail ;

+ (void)POSTWithUrl:(NSString *)url
             header:(NSDictionary *)header
                hud:(BOOL)hud
         parameters:(NSDictionary *)dict
        taskSuccess:(void (^)(NSURLSessionDataTask * task ,id json))success
               fail:(void (^)())fail ;

// post body raw
+ (void)POSTWithURL:(NSString *)url
             header:(NSDictionary *)header
              param:(NSDictionary *)param
            rawBody:(NSString *)rawBody
                hud:(BOOL)hud
            success:(void (^)(id json))success
               fail:(void (^)())fail ;

/**
 sync
 */
+ (id)syncWithReqMode:(XTRequestMode)mode
              timeout:(int)timeout
                  url:(NSString *)url
               header:(NSDictionary *)header
           parameters:(NSDictionary *)dict ;

+ (id)syncWithReqMode:(XTRequestMode)mode
                  url:(NSString *)url
               header:(NSDictionary *)header
           parameters:(NSDictionary *)dict ;

@end





