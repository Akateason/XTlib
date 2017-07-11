//
//  ListEvent.m
//  PatchBoard
//
//  Created by teason23 on 2017/7/7.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "ListEvent.h"
#import "NSDate+XTTick.h"

@implementation ListEvent

- (instancetype)initWithRow:(int)row
                    section:(int)section
                       from:(NSString *)from
{
    self = [super init];
    if (self)
    {
        self.row = row ;
        self.section = section ;
        self.fromDelegate = from ;
        NSDate *now = [NSDate date] ;
        self.time = [now xt_getTick] ;
        self.dateStr = [now xt_getStr] ;
        self.uploaded = 0 ;
    }
    return self;
}

@end
