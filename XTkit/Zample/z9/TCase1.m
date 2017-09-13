//
//  TCase1.m
//  XTkit
//
//  Created by teason23 on 2017/7/27.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "TCase1.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface TCase1 ()
@end

@implementation TCase1

- (void)dealloc
{
    NSLog(@"dealloc tcase1") ;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        __block int times = 1 ;
        @weakify(self)
        self.timer1 = [NSTimer timerWithTimeInterval:1
                                            repeats:YES
                                              block:^(NSTimer * _Nonnull timer) {
                                                  @strongify(self)
                                                  times++ ;
                                                  NSLog(@"tcase1") ;
                                                  if (times == 5) {
                                                      [self.timer1 invalidate] ;
                                                  }
                                              }] ;
        [[NSRunLoop currentRunLoop] addTimer:self.timer1
                                     forMode:NSDefaultRunLoopMode] ;
    }
    return self;
}

@end
