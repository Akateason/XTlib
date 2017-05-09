//
//  ServerRequest.h
//  XTkit
//
//  Created by teason on 14-8-12.
//  Copyright (c) 2014年 teason. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "XTRequest.h"
#import "XTReqResonse.h"
#import "PublicEnum.h"


@interface ServerRequest : XTRequest

+ (void)zample2WithSuccess:(void (^)(id json))success
                      fail:(void (^)(void))fail ;

+ (void)zample3_GetMovieListWithStart:(NSInteger)start
                                count:(NSInteger)count
                              success:(void (^)(id json))success
                                 fail:(void (^)(void))fail ;
@end





