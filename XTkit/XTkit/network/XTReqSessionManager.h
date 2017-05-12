//
//  XTReqSessionManager.h
//  XTkit
//
//  Created by teason23 on 2017/5/12.
//  Copyright © 2017年 teason. All rights reserved.
//
// global request timeout
static const float kTIMEOUT = 15.f ;

#import <AFNetworking/AFNetworking.h>

@interface XTReqSessionManager : AFHTTPSessionManager

+ (instancetype)shareInstance ;

@end
