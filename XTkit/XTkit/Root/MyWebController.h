//
//  MyWebController.h
//  JGB
//
//  Created by JGBMACMINI01 on 14-9-10.
//  Copyright (c) 2014年 JGBMACMINI01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootCtrl.h"

@interface MyWebController : RootCtrl

@property (nonatomic,copy) NSString *urlStr ;
@property (strong, nonatomic) UIWebView *webView ;

- (void)startLoadingWebview ;

@end
