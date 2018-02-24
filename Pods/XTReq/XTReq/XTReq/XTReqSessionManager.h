//
//  XTReqSessionManager.h
//  XTlib
//
//  Created by teason23 on 2017/5/12.
//  Copyright © 2017年 teason. All rights reserved.
//
// Singleton of AFHTTPSessionManager
//

// Global contentTypes
#define ACCEPTABLE_CONTENT_TYPES                    @"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain"
// Global timeout
static const float kTIMEOUT = 15.f ;


#import "AFNetworking.h"

@interface XTReqSessionManager : AFHTTPSessionManager

+ (instancetype)shareInstance ;

- (void)reset ;

@end
