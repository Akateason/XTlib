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

+ (void)cacheGET:(NSString *)url
      parameters:(NSDictionary *)param
      completion:(void (^)(id json))completion ;

+ (void)cacheGET:(NSString *)url
      parameters:(NSDictionary *)param
          policy:(XTResponseCachePolicy)cachePolicy
   timeoutIfNeed:(int)timeoutIfNeed
      completion:(void (^)(id json))completion ;

+ (void)cacheGET:(NSString *)url
      parameters:(NSDictionary *)param
             hud:(BOOL)hud
          policy:(XTResponseCachePolicy)cachePolicy
   timeoutIfNeed:(int)timeoutIfNeed
      completion:(void (^)(id json))completion ;


+ (void)cachePOST:(NSString *)url
       parameters:(NSDictionary *)param
       completion:(void (^)(id json))completion ;

+ (void)cachePOST:(NSString *)url
       parameters:(NSDictionary *)param
           policy:(XTResponseCachePolicy)cachePolicy
    timeoutIfNeed:(int)timeoutIfNeed
       completion:(void (^)(id json))completion ;

+ (void)cachePOST:(NSString *)url
       parameters:(NSDictionary *)param
              hud:(BOOL)hud
           policy:(XTResponseCachePolicy)cachePolicy
    timeoutIfNeed:(int)timeoutIfNeed
       completion:(void (^)(id json))completion ;

@end









