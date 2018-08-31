//
//  ApplicationEvent.m
//  PatchBoard
//
//  Created by teason23 on 2017/7/6.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "ApplicationEvent.h"
#import <UIKit/UIKit.h>
#import "NSDate+XTTick.h"
#import "UniqueKeyMaker.h"
#import "UIView+XTAddition.h"
#import "ValetManager.h"

@implementation ApplicationEvent

- (instancetype)initWithSEL:(SEL)sel
                         to:(id)target
                       from:(id)sender
                   forEvent:(UIEvent *)event
{
    self = [super init];
    if (self) {
        
        self.action = NSStringFromSelector(sel) ;
        self.target = NSStringFromClass(((NSObject *)target).class) ;
        self.sender = NSStringFromClass(((NSObject *)sender).class) ;
        self.event = event.description ;
        NSDate *now = [NSDate date] ;
        self.time = [now xt_getTick] ;
        self.dateStr = [now xt_getStr] ;
        if ([sender isKindOfClass:[UIResponder class]]) {
            self.tree = [sender xt_chainInfo] ;
        }
        
        self.uploaded = 0 ;
        self.kindOfKey = [UniqueKeyMaker makeUniqueKey:@[self.action?:@"",self.target?:@"",self.sender?:@"",self.event?:@""]] ;
        self.UUID = [[ValetManager sharedInstance] UUID] ;
    }
    return self;
}

@end
