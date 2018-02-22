# XTReq 
* GET/POST
* 异步/同步
* 缓存自带三种策略
* 可手动控制是否缓存(防止服务器出错的情况)


cocoapods 
```
pod 'XTReq'
```

* 使用方式
#import "XTReq.h"
* 若需要缓存. 需要在APPdelegate配置
```
[XTCacheRequest configXTCacheReqWhenAppDidLaunchWithDBName:@"yourDB"] ;

```

XTRequest
```

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

/**
sync
*/
+ (id)syncWithReqMode:(XTRequestMode)mode
                  url:(NSString *)url
               header:(NSDictionary *)header
           parameters:(NSDictionary *)dict ;


@end

```


XTCacheRequest
```

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


```



