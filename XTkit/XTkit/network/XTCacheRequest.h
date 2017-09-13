//
//  XTCacheRequest.h
//  XTkit
//
//  Created by teason23 on 2017/5/8.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "XTRequest.h"
#import "XTResponseDBModel.h"


@interface XTCacheRequest : XTRequest

#pragma mark - get

+ (void)cacheGET:(NSString *)url
      parameters:(NSDictionary *)param
      completion:(void(^)(id json))completion ;

+ (void)cacheGET:(NSString *)url
      parameters:(NSDictionary *)param
     judgeResult:(BOOL(^)(id json))completion ;

+ (void)cacheGET:(NSString *)url
          header:(NSDictionary *)header
      parameters:(NSDictionary *)param
      completion:(void(^)(id json))completion ;

+ (void)cacheGET:(NSString *)url
          header:(NSDictionary *)header
      parameters:(NSDictionary *)param
     judgeResult:(BOOL(^)(id json))completion ;

/**
 cacheGET completion
 
 @param url             NSString
 @param header          NSDictionary
 @param param           NSDictionary
 @param hud             BOOL
 @param cachePolicy     XTResponseCachePolicy
 @param timeoutIfNeed   int
 @param completion      void(^)(id json)            RESULT WILL BE CACHED IN ANY CASE .
 */
+ (void)cacheGET:(NSString *)url
          header:(NSDictionary *)header
      parameters:(NSDictionary *)param
             hud:(BOOL)hud
          policy:(XTResponseCachePolicy)cachePolicy
   timeoutIfNeed:(int)timeoutIfNeed
      completion:(void(^)(id json))completion ;

/**
 cacheGET judgeResult
 
 @param url             NSString
 @param header          NSDictionary
 @param param           NSDictionary
 @param hud             BOOL
 @param cachePolicy     XTResponseCachePolicy
 @param timeoutIfNeed   int
 @param completion      BOOL(^)(id json)            JUDGE RESULT ;  RETURN 'YES' IF RESULT NEEDN'T CACHE . RETURN 'NO' IF WILL CACHE .
 */
+ (void)cacheGET:(NSString *)url
          header:(NSDictionary *)header
      parameters:(NSDictionary *)param
             hud:(BOOL)hud
          policy:(XTResponseCachePolicy)cachePolicy
   timeoutIfNeed:(int)timeoutIfNeed
     judgeResult:(BOOL(^)(id json))completion ;



#pragma mark - post

+ (void)cachePOST:(NSString *)url
       parameters:(NSDictionary *)param
       completion:(void(^)(id json))completion ;

+ (void)cachePOST:(NSString *)url
       parameters:(NSDictionary *)param
      judgeResult:(BOOL(^)(id json))completion ;

+ (void)cachePOST:(NSString *)url
           header:(NSDictionary *)header
       parameters:(NSDictionary *)param
       completion:(void(^)(id json))completion ;

+ (void)cachePOST:(NSString *)url
           header:(NSDictionary *)header
       parameters:(NSDictionary *)param
      judgeResult:(BOOL(^)(id json))completion ;


/**
 cachePOST completion
 
 @param url             NSString
 @param header          NSDictionary
 @param param           NSDictionary
 @param hud             BOOL
 @param cachePolicy     XTResponseCachePolicy
 @param timeoutIfNeed   int
 @param completion      void(^)(id json)            RESULT WILL BE CACHED IN ANY CASE .
 */
+ (void)cachePOST:(NSString *)url
           header:(NSDictionary *)header
       parameters:(NSDictionary *)param
              hud:(BOOL)hud
           policy:(XTResponseCachePolicy)cachePolicy
    timeoutIfNeed:(int)timeoutIfNeed
       completion:(void(^)(id json))completion;

/**
 cachePOST judgeResult
 
 @param url             NSString
 @param header          NSDictionary
 @param param           NSDictionary
 @param hud             BOOL
 @param cachePolicy     XTResponseCachePolicy
 @param timeoutIfNeed   int
 @param completion      BOOL(^)(id json)            JUDGE RESULT ;  RETURN 'YES' IF RESULT NEEDN'T CACHE . RETURN 'NO' IF WILL CACHE .
 */
+ (void)cachePOST:(NSString *)url
           header:(NSDictionary *)header
       parameters:(NSDictionary *)param
              hud:(BOOL)hud
           policy:(XTResponseCachePolicy)cachePolicy
    timeoutIfNeed:(int)timeoutIfNeed
      judgeResult:(BOOL(^)(id json))completion;

@end









