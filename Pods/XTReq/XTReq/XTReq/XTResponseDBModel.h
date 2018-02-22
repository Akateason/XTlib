//
//  XTResponseDBModel.h
//  XTkit
//
//  Created by teason23 on 2017/5/10.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "XTDBModel.h"

typedef NS_ENUM(NSUInteger, XTResponseCachePolicy) {
    XTResponseCachePolicyNeverUseCache      , // DEFAULT
    XTResponseCachePolicyAlwaysCache        ,
    
    XTResponseCachePolicyTimeout      = 20  ,
} ;



@interface XTResponseDBModel : XTDBModel

@property (nonatomic,copy) NSString     *requestUrl     ; // as UNIQUE KEY
@property (nonatomic,copy) NSString     *response       ; // response string
/*
 ***XTResponseCacheType***
 *  XTResponseCachePolicyNeverUseCache  从不缓存适合每次都实时的数据流.
 *  XTResponseCachePolicyAlwaysCache    总是获取缓存的数据.不再更新.
 *  XTResponseCachePolicyTimeout        规定时间内.返回缓存.超时则更新数据. 需设置timeout时间. timeout默认1小时
 */
@property (nonatomic)      NSUInteger   cachePolicy     ; // XTResponseCachePolicy
@property (nonatomic)      int          timeout         ; // 超时时间(秒数)  默认1小时

// new a Default Model
+ (instancetype)newDefaultModelWithKey:(NSString *)urlStr
                                   val:(NSString *)respStr;

+ (instancetype)newDefaultModelWithKey:(NSString *)urlStr
                                   val:(NSString *)respStr
                                policy:(int)policy
                               timeout:(int)timeout ;
// is timeout ?
- (BOOL)isAlreadyTimeout ;

// decode Response
- (NSString *)decodeResponse ; // 如果插入时经过单引号转义. 获取时用这个方法获得Response .

@end






