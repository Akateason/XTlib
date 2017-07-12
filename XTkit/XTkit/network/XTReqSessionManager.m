//
//  XTReqSessionManager.m
//  XTkit
//
//  Created by teason23 on 2017/5/12.
//  Copyright © 2017年 teason. All rights reserved.
//

#define ACCEPTABLE_CONTENT_TYPES                    @"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain"
static const float kTIMEOUT = 15.f ;

#import "XTReqSessionManager.h"

@implementation XTReqSessionManager

+ (instancetype)shareInstance {
    static XTReqSessionManager *_sharedClient = nil;
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[XTReqSessionManager alloc] initWithBaseURL:nil] ;
        _sharedClient.requestSerializer  = [AFHTTPRequestSerializer serializer] ;
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer] ;
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:ACCEPTABLE_CONTENT_TYPES,nil] ;
        _sharedClient.requestSerializer.timeoutInterval = kTIMEOUT ;
        _sharedClient.completionQueue = NULL ;
    }) ;
    return _sharedClient ;
}

- (void)reset {
    self.requestSerializer  = [AFHTTPRequestSerializer serializer] ;
    self.responseSerializer = [AFJSONResponseSerializer serializer] ;
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:ACCEPTABLE_CONTENT_TYPES,nil] ;
    self.requestSerializer.timeoutInterval = kTIMEOUT ;
    self.completionQueue = NULL ;
}

@end



