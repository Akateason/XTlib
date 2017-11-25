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
    if ([self receiveHandleChain:identifier sender:sender info:nil] && self.nextResponder) [self.nextResponder sendChainHandler:identifier sender:sender info:nil] ;
}

- (void)sendChainHandler:(NSString *)identifier sender:(id)sender info:(id)info {
    if ([self receiveHandleChain:identifier sender:sender info:info] && self.nextResponder) [self.nextResponder sendChainHandler:identifier sender:sender info:info] ;
}

- (BOOL)receiveHandleChain:(NSString *)identifier sender:(id)sender info:(id)info {
    return YES ;
}

@end
