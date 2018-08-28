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
                      fail:(void (^)(void))fail
{
    int random = arc4random() % 100 ;
    NSString *urlStr = [NSString stringWithFormat:@"https://api.douban.com/v2/book/%@",@(1220562+random)] ;
    [XTRequest GETWithUrl:urlStr
               parameters:nil
                  success:^(id json) {
                     if (success) {
                         success(json) ;
                     }
                  } fail:^{
                     if (fail) {
                         fail() ;
                     }
                  }] ;
}


+ (void)zample3_GetMovieListWithStart:(NSInteger)start
                                count:(NSInteger)count
                              success:(void (^)(id json))success
                                 fail:(void (^)(void))fail
{
    XT_GET_PARAM
    [param setObject:@(start)
              forKey:@"start"] ;
    [param setObject:@(count)
              forKey:@"count"] ;
    
    [XTRequest GETWithUrl:@"https://api.douban.com/v2/movie/top250"
               parameters:param
                  success:^(id json) {
                      if(success) success(json) ;
                  } fail:^{
                      if(fail) fail() ;
                  }] ;
}



+ (void)zample6_GetMovieListWithStart:(NSInteger)start
                                count:(NSInteger)count
                           completion:(XTReqSaveJudgment (^)(id json))completion
{
    XT_GET_PARAM
    [param setObject:@(start)
              forKey:@"start"] ;
    [param setObject:@(count)
              forKey:@"count"] ;

    [XTCacheRequest cacheGET:@"https://api.douban.com/v2/movie/top250" header:nil parameters:param judgeResult:completion] ;    
}


+ (void)zample7_request:(int)bookID
                success:(void (^)(id json))success
                   fail:(void (^)(void))fail
{
    NSString *urlStr = [NSString stringWithFormat:@"https://api.douban.com/v2/book/%@",@(bookID)] ;
    [XTRequest GETWithUrl:urlStr
               parameters:nil
                  success:^(id json) {
                      if (success) {
                          success(json) ;
                      }
                  } fail:^{
                      if (fail) {
                          fail() ;
                      }
                  }] ;

}


@end
