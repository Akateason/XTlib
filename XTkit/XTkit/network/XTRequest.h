//
//  AppDelegate.m
//  XTRequest
//
//  Created by TuTu on 15/11/12.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>

// get PARAM
#define XT_GET_PARAM                         NSMutableDictionary *param = [self getParameters] ;
// global timeout
static const float kTIMEOUT = 5.f ;
// method
typedef NS_ENUM(NSInteger, METHOD_REQUEST) {
    GET_MODE  ,
    POST_MODE
} ;



@class ResultParsered ;

@interface XTRequest : NSObject

// set URL string
+ (NSString *)getFinalUrl:(NSString *)strPartOfUrl ;

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

+ (void)POSTWithUrl:(NSString *)url
         parameters:(NSDictionary *)dict
            success:(void (^)(id json))success
               fail:(void (^)())fail ;

+ (void)POSTWithUrl:(NSString *)url
                hud:(BOOL)hud
         parameters:(NSDictionary *)dict
            success:(void (^)(id json))success
               fail:(void (^)())fail ;

//  sync
+ (ResultParsered *)getResultWithURLstr:(NSString *)urlstr
                                  param:(NSDictionary *)dict
                                   mode:(METHOD_REQUEST)mode ;

+ (ResultParsered *)getResultWithURLstr:(NSString *)urlstr
                                  param:(NSDictionary *)dict
                                   mode:(METHOD_REQUEST)mode
                                    hud:(BOOL)hud ;

+ (id)getJsonObjectWithURLstr:(NSString *)urlstr
                        param:(NSDictionary *)dict
                         mode:(METHOD_REQUEST)mode ;

+ (id)getJsonObjectWithURLstr:(NSString *)urlstr
                        param:(NSDictionary *)dict
                         mode:(METHOD_REQUEST)mode
                          hud:(BOOL)hud ;

@end
