//
//  XTReqSessionManager.h
//  XTkit
//
//  Created by teason23 on 2017/5/12.
//  Copyright © 2017年 teason. All rights reserved.
//
// global request timeout



#import <AFNetworking/AFNetworking.h>

extern const float kTIMEOUT ;

@interface XTReqSessionManager : AFHTTPSessionManager

+ (instancetype)shareInstance ;

- (void)reset ;

@end
