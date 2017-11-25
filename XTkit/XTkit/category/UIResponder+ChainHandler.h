//
//  UIResponder+ChainHandler.h
//  XTkit
//
//  Created by teason23 on 2017/10/23.
//  Copyright © 2017年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (ChainHandler)

- (void)sendChainHandler:(NSString *)identifier sender:(id)sender ;
- (void)sendChainHandler:(NSString *)identifier sender:(id)sender info:(id)info ;

- (BOOL)receiveHandleChain:(NSString *)identifier sender:(id)sender info:(id)info ;

@end
