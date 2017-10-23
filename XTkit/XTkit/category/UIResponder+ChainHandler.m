//
//  UIResponder+ChainHandler.m
//  XTkit
//
//  Created by teason23 on 2017/10/23.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "UIResponder+ChainHandler.h"

@implementation UIResponder (ChainHandler)

- (void)sendChainHandler:(NSString *)identifier sender:(id)sender {
    if ([self receiveHandleChain:identifier sender:sender] && self.nextResponder) [self.nextResponder sendChainHandler:identifier sender:sender] ;
}

- (BOOL)receiveHandleChain:(NSString *)identifier sender:(id)sender {
    return YES ;
}

@end
