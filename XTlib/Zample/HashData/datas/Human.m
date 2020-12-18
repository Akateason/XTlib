//
//  Human.m
//  XTlib
//
//  Created by teason23 on 2020/10/27.
//  Copyright © 2020 teason23. All rights reserved.
//

#import "Human.h"

@implementation Human
+ (instancetype) humanWithName:(NSString *)n {
    Human *human = [[Human alloc] init];
    human.name = n;
    
    return human;
}


- (void)dealloc {
    self.name = nil;
}

@end
