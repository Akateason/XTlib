//
//  Father.m
//  XTkit
//
//  Created by teason23 on 2017/10/25.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "Father.h"

@interface Father () <BasketballFatherProtocol>
@end

@implementation Father
- (void)playBasketballLike:(NSString *)ballerName {
    NSLog(@"playBasketballLike \"%@\"",ballerName) ;
}
@end
