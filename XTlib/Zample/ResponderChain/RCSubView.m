//
//  RCSubView.m
//  XTkit
//
//  Created by teason23 on 2017/11/25.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "RCSubView.h"
#import <Masonry/Masonry.h>
#import <XTBase/XTBase.h>
#import "RespoderChainViewController.h"


@implementation RCSubView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.button = [UIButton new];
        [self.button setTitle:@"button" forState:0];
        [self.button setBackgroundColor:[UIColor grayColor]];
        [self.button setTitleColor:[UIColor blueColor] forState:0];
        [self addSubview:self.button];
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(100, 44));
        }];
        [self.button addTarget:self
                        action:@selector(btAction)
              forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)btAction {
    RespoderChainViewController *vc = (RespoderChainViewController *)[self xt_findNext:RespoderChainViewController.class];
    [self xt_messageOnChain:XT_STR_FORMAT(@"name%ld",self.tag) param:@{@"aaal":@23432,@"bb":vc.stringOnlyInSuper}];
}

@end
