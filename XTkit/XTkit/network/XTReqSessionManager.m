//
//  XTReqSessionManager.m
//  XTkit
//
//  Created by teason23 on 2017/5/12.
//  Copyright © 2017年 teason. All rights reserved.
//

#define ACCEPTABLE_CONTENT_TYPES                    @"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain"



#import "XTReqSessionManager.h"

@implementation XTReqSessionManager

+ (instancetype)shareInstance
{
    static XTReqSessionManager *_sharedClient = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[XTReqSessionManager alloc] initWithBaseURL:nil] ;
        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer] ;
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer] ;
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:ACCEPTABLE_CONTENT_TYPES,nil] ;
        _sharedClient.requestSerializer.timeoutInterval = kTIMEOUT ;
    });
    
    return _sharedClient ;
}

@end
