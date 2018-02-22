//
//  XTReqSessionManager.h
//  XTkit
//
//  Created by teason23 on 2017/5/12.
//  Copyright © 2017年 teason. All rights reserved.
//
// global request timeout



#import "AFNetworking.h"

static const float kTIMEOUT = 15.f ;

@interface XTReqSessionManager : AFHTTPSessionManager

+ (instancetype)shareInstance ;

- (void)reset ;

@end
