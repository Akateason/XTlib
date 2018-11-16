//
//  ServerRequest.h
//  XTkit
//
//  Created by teason on 14-8-12.
//  Copyright (c) 2014年 teason. All rights reserved.
//


#import "ServerRequest.h"


@implementation ServerRequest


+ (void)zample2WithSuccess:(void (^)(id json))success
                      fail:(void (^)(void))fail {
    int random       = arc4random() % 100;
    NSString *urlStr = [NSString stringWithFormat:@"https://api.douban.com/v2/book/%@", @(1220562 + random)];

    [XTRequest reqWithUrl:urlStr mode:XTRequestMode_GET_MODE header:nil parameters:nil rawBody:nil hud:NO success:^(id json, NSURLResponse *response) {
        if (success) {
            success(json);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (fail) {
            fail();
        }
    }];
}


+ (void)zample3_GetMovieListWithStart:(NSInteger)start
                                count:(NSInteger)count
                              success:(void (^)(id json))success
                                 fail:(void (^)(void))fail {
    XT_GET_PARAM
        [param setObject:@(start)
                  forKey:@"start"];
    [param setObject:@(count)
              forKey:@"count"];

    [XTRequest reqWithUrl:@"https://api.douban.com/v2/movie/top250" mode:XTRequestMode_GET_MODE header:nil parameters:param rawBody:nil hud:NO success:^(id json, NSURLResponse *response) {
        if (success) success(json);

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (fail) fail();

    }];
}


+ (void)zample6_GetMovieListWithStart:(NSInteger)start
                                count:(NSInteger)count
                           completion:(XTReqSaveJudgment (^)(id json))completion {
    XT_GET_PARAM
        [param setObject:@(start)
                  forKey:@"start"];
    [param setObject:@(count)
              forKey:@"count"];

    [XTCacheRequest cachedReq:XTRequestMode_GET_MODE url:@"https://api.douban.com/v2/movie/top250" hud:NO header:nil param:param body:nil policy:XTReqPolicy_NeverCache_WaitReturn overTimeIfNeed:0 completion:^(BOOL isNewest, id json) {
        completion(json);
    }];
}


+ (void)zample7_request:(int)bookID
                success:(void (^)(id json))success
                   fail:(void (^)(void))fail {
    NSString *urlStr = [NSString stringWithFormat:@"https://api.douban.com/v2/book/%@", @(bookID)];
    [XTRequest reqWithUrl:urlStr mode:XTRequestMode_GET_MODE header:nil parameters:nil rawBody:nil hud:NO success:^(id json, NSURLResponse *response) {
        if (success) success(json);

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (fail) fail();

    }];
}


@end
