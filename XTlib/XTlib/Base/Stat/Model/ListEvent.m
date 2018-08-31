//
//  ListEvent.m
//  PatchBoard
//
//  Created by teason23 on 2017/7/7.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "ListEvent.h"
#import "NSDate+XTTick.h"
#import "UniqueKeyMaker.h"
#import "ValetManager.h"

@implementation ListEvent

- (instancetype)initWithRow:(int)row
                    section:(int)section
                       from:(NSString *)from
                   listType:(NSString *)listType
{
    self = [super init];
    if (self)
    {
        self.row = row ;
        self.section = section ;
        self.fromDelegate = from ;
        self.listType = listType ;
        NSDate *now = [NSDate date] ;
        self.time = [now xt_getTick] ;
        self.dateStr = [now xt_getStr] ;
        self.uploaded = 0 ;
        self.kindOfKey = [UniqueKeyMaker makeUniqueKey:@[@(self.row),@(self.section),self.fromDelegate]] ;
        self.UUID = [[ValetManager sharedInstance] UUID] ;
    }
    return self;
}

@end
