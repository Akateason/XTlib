//
//  XTSearchHandler.m
//  GroupBuying
//
//  Created by TuTu on 16/10/14.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "XTSearchHandler.h"
#import "AFNetworking.h"
#import "ServerRequest.h"

@interface XTSearchHandler ()

@property (nonatomic,strong) NSMutableArray *arrayOfTasks ;
@property (nonatomic,strong) AFHTTPSessionManager *manager ;

@end

@implementation XTSearchHandler

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.manager = [[AFHTTPSessionManager alloc] init] ;
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer] ;
        self.arrayOfTasks = [NSMutableArray new] ;
    }
    return self;
}

- (void)searchWithText:(NSString *)searchText
                 order:(NSString *)order
                  sort:(NSString *)sort
              searchBy:(NSString *)searchBy
                  page:(int)page
                  size:(int)size
        searchComplete:(BlockSearchTaskComplete)searchComplete
                  fail:(void (^)(NSURLSessionDataTask *task, NSError *error))fail
{
    {
        // cancel all previous tasks
        [self.arrayOfTasks enumerateObjectsUsingBlock:^(NSURLSessionDataTask *taskObj, NSUInteger idx, BOOL *stop) {
            [taskObj cancel] ; /// when sending cancel to the task failure: block is going to be called
        }];
        
        // empty the arraOfTasks
        [self.arrayOfTasks removeAllObjects];
        
        // init new task
//        NSURLSessionDataTask *task = [ServerRequest searchContentsByKeyword:searchText
//                                                                      order:order
//                                                                       sort:sort
//                                                                   searchBy:searchBy
//                                                                       page:page
//                                                                       size:size
//                                                                    manager:self.manager
//                                                                    success:^(NSURLSessionDataTask *task, id responseObject) {
//                                                                        
//                                                                        searchComplete(task,responseObject) ;
//                                                                        
//                                                                    } fail:^(NSURLSessionDataTask *task, NSError *error) {
//                                                                        if (fail) {
//                                                                            fail(task,error) ;
//                                                                        }
//                                                                    }] ;
        
        

        
        // add the task to our arrayOfTasks
//        [self.arrayOfTasks addObject:task] ;
    }
}


@end
