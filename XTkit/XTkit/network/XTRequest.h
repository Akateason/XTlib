//
//  AppDelegate.m
//  XTRequest
//
//  Created by TuTu on 15/11/12.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XTReqResonse , NSURLSessionDataTask ;


// get PARAM
#define XT_GET_PARAM                         NSMutableDictionary *param = [XTRequest getParameters] ;

// base URL
static NSString *const kBaseURL = @"http://www.akateason.top" ;

// method
typedef NS_ENUM(NSInteger, XTRequestMode) {
    XTRequestMode_GET_MODE      ,
    XTRequestMode_POST_MODE
} ;





@interface XTRequest : NSObject

// set URL string with base url
+ (NSString *)getFinalUrl:(NSString *)strPartOfUrl ;
// get url format baseurl?param1&param2&param3...
+ (NSString *)fullUrl:(NSString *)url
                param:(NSDictionary *)param ;
// param
+ (NSMutableDictionary *)getParameters ;

// status
+ (void)netWorkStatus ;
+ (void)netWorkStatus:(void (^)(NSInteger status))block ;

// async
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

//  sync
+ (XTReqResonse *)getResultWithURLstr:(NSString *)urlstr
                                  param:(NSDictionary *)dict
                                   mode:(XTRequestMode)mode ;

+ (XTReqResonse *)getResultWithURLstr:(NSString *)urlstr
                                  param:(NSDictionary *)dict
                                   mode:(XTRequestMode)mode
                                    hud:(BOOL)hud ;

+ (id)getJsonObjectWithURLstr:(NSString *)urlstr
                        param:(NSDictionary *)dict
                         mode:(XTRequestMode)mode ;

+ (id)getJsonObjectWithURLstr:(NSString *)urlstr
                        param:(NSDictionary *)dict
                         mode:(XTRequestMode)mode
                          hud:(BOOL)hud ;

@end
