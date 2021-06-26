//
//  RespoderChainViewController.m
//  XTkit
//
//  Created by teason23 on 2017/11/25.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "RespoderChainViewController.h"
#import <XTBase/XTBase.h>
#import "RCSubView.h"
#import "XTlib.h"


@interface RespoderChainViewController ()
@end


@implementation RespoderChainViewController

- (void)xt_messageOnChain:(NSString *)name param:(NSDictionary *)param {
    if ([name isEqualToString:@"name21"]) {
        NSLog([param yy_modelToJSONString]);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.stringOnlyInSuper = @"string only in super";
    
    
    self.view.tag = 1;
    int flex = 10;
    for (int i = 1; i <= 20; i++) {
        RCSubView *aView         = [RCSubView new];
        aView.tag = i+1;
        aView.backgroundColor = [[XTColorFetcher sharedInstance] randomColor];
        [[self.view viewWithTag:i] addSubview:aView];
        [aView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(APP_WIDTH - flex * i, APP_HEIGHT - flex * i));
            make.center.equalTo(self.view);
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
