//
//  XTSearchHandler.h
//  GroupBuying
//
//  Created by TuTu on 16/10/14.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BlockSearchTaskComplete)(NSURLSessionDataTask *task, id responseObject) ;

@interface XTSearchHandler : NSObject

- (void)searchWithText:(NSString *)searchText
                 order:(NSString *)order
                  sort:(NSString *)sort
              searchBy:(NSString *)searchBy
                  page:(int)page
                  size:(int)size
        searchComplete:(BlockSearchTaskComplete)searchComplete
                  fail:(void (^)(NSURLSessionDataTask *task, NSError *error))fail ;

@end
