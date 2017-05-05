//
//  ResponseDBModel.h
//  XTkit
//
//  Created by teason23 on 2017/5/4.
//  Copyright © 2017年 teason. All rights reserved.
//



//  NSURLRequestUseProtocolCachePolicy // 默认的缓存策略（取决于协议）
//  NSURLRequestReloadIgnoringLocalCacheData // 忽略缓存，重新请求
//  NSURLRequestReturnCacheDataElseLoad// 有缓存就用缓存，没有缓存就重新请求
//  NSURLRequestReturnCacheDataDontLoad// 有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）
//
//-------------
//　　（1）经常更新：不能用缓存！比如股票、彩票数据
//
//　　（2）一成不变：果断用缓存
//
//　　（3）偶尔更新：可以定期更改缓存策略 或者 清除缓存


#import "XTDBModel.h"

typedef NS_ENUM(NSUInteger, XTResponseCacheType) {
    XTResponseCacheTypeTypeNeverCache           , // default
    XTResponseCacheTypeLoadCacheThenRequest     ,
    
    XTResponseCacheTypeTimeout          = 20    ,
} ;

@interface ResponseDBModel : XTDBModel

@property (nonatomic,copy) NSString     *requestUrl     ; // unique     KEY
@property (nonatomic,copy) NSString     *response       ; //            VAL
@property (nonatomic)      NSUInteger   cacheType       ; // XTResponseCacheType
@property (nonatomic)      long long    createTime      ; // tick
@property (nonatomic)      long long    updateTime      ;
@property (nonatomic)      int          isDelete        ;

@end
