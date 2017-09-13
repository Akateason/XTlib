//
//  TCase2.m
//  XTkit
//
//  Created by teason23 on 2017/7/31.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "TCase2.h"

@interface TCase2 ()
{
    int times ;
}


@end

@implementation TCase2

- (void)dealloc
{
    NSLog(@"TCase2 dealloc") ;

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.timer = [NSTimer timerWithTimeInterval:1
                                             target:self
                                           selector:@selector(loopAction)
                                           userInfo:nil
                                            repeats:YES] ;
        [[NSRunLoop currentRunLoop] addTimer:self.timer
                                     forMode:NSRunLoopCommonModes] ;
    }
    return self;
}

- (void)loopAction
{
    times ++ ;
    if (times == 10) {
        [self.timer invalidate] ;
    }
    NSLog(@"23233223") ;
}

@end
