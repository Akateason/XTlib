//
//  XTCacheRequest.h
//  XTlib
//
//  Created by teason23 on 2017/5/8.
//  Copyright © 2017年 teason. All rights reserved.
// XTCacheRequest
//  1. Persistent save the response of requests .
//  2. three policy for how you save requests .
//  3. can control save or not when server crashed or bug .

#import "XTRequest.h"
#import "XTResponseDBModel.h"

typedef enum : NSUInteger {
    XTReqSaveJudgment_willSave      = 0 ,
    XTReqSaveJudgment_NotSave       = 1 ,
} XTReqSaveJudgment ;

@interface XTCacheRequest : XTRequest

#pragma mark - config

+ (void)configXTCacheReqWhenAppDidLaunchWithDBName:(NSString *)dbName ;
    
#pragma mark - get

+ (void)cacheGET:(NSString *)url
      parameters:(NSDictionary *)param
      completion:(void(^)(id json))completion ;

+ (void)cacheGET:(NSString *)url
      parameters:(NSDictionary *)param
     judgeResult:(XTReqSaveJudgment(^)(id json))completion ;

+ (void)cacheGET:(NSString *)url
          header:(NSDictionary *)header
      parameters:(NSDictionary *)param
      completion:(void(^)(id json))completion ;

+ (void)cacheGET:(NSString *)url
          header:(NSDictionary *)header
      parameters:(NSDictionary *)param
     judgeResult:(XTReqSaveJudgment(^)(id json))completion ;

/**
 cacheGET completion
 
 @param url             NSString
 @param header          NSDictionary
 @param param           NSDictionary
 @param hud             BOOL
 @param cachePolicy     XTResponseCachePolicy
 @param timeoutIfNeed   int
 @param completion      void(^)(id json)            RESPONSE WILL BE SAVED IN ANY CASE .
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
 @param completion      XTReqSaveJudgment(^)(id json)            JUDGE RESPONSE RESULT ;  RETURN 'XTReqSaveJudgment_NotSave' IF RESULT NEEDN'T CACHE . RETURN 'XTReqSaveJudgment_willSave' IF WILL SAVE .
 */
+ (void)cacheGET:(NSString *)url
          header:(NSDictionary *)header
      parameters:(NSDictionary *)param
             hud:(BOOL)hud
          policy:(XTResponseCachePolicy)cachePolicy
   timeoutIfNeed:(int)timeoutIfNeed
     judgeResult:(XTReqSaveJudgment (^)(id json))completion ;



#pragma mark - post

+ (void)cachePOST:(NSString *)url
       parameters:(NSDictionary *)param
       completion:(void(^)(id json))completion ;

+ (void)cachePOST:(NSString *)url
       parameters:(NSDictionary *)param
      judgeResult:(XTReqSaveJudgment(^)(id json))completion ;

+ (void)cachePOST:(NSString *)url
           header:(NSDictionary *)header
       parameters:(NSDictionary *)param
       completion:(void(^)(id json))completion ;

+ (void)cachePOST:(NSString *)url
           header:(NSDictionary *)header
       parameters:(NSDictionary *)param
      judgeResult:(XTReqSaveJudgment(^)(id json))completion ;


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
 @param completion      XTReqSaveJudgment(^)(id json)            JUDGE RESPONSE RESULT ;  RETURN 'XTReqSaveJudgment_NotSave' IF RESULT NEEDN'T CACHE . RETURN 'XTReqSaveJudgment_willSave' IF WILL SAVE .
 */
+ (void)cachePOST:(NSString *)url
           header:(NSDictionary *)header
       parameters:(NSDictionary *)param
              hud:(BOOL)hud
           policy:(XTResponseCachePolicy)cachePolicy
    timeoutIfNeed:(int)timeoutIfNeed
      judgeResult:(XTReqSaveJudgment(^)(id json))completion;

@end









