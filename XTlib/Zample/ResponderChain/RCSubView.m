//
//  RCSubView.m
//  XTkit
//
//  Created by teason23 on 2017/11/25.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "RCSubView.h"
#import <Masonry/Masonry.h>
#import "UIResponder+ChainHandler.h"

@implementation RCSubView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.button = [UIButton new] ;
        [self.button setTitle:@"button" forState:0] ;
        [self.button setBackgroundColor:[UIColor grayColor]] ;
        [self.button setTitleColor:[UIColor blueColor] forState:0] ;
        [self addSubview:self.button] ;
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self) ;
            make.size.mas_equalTo(CGSizeMake(100, 44)) ;
        }] ;
        [self.button addTarget:self
                        action:@selector(btAction)
              forControlEvents:UIControlEventTouchUpInside] ;

    }
    return self;
}

- (void)btAction {
    NSLog(@"tap") ;
    [self sendChainHandler:@"a" info:[@(arc4random()%100) stringValue] sender:self] ;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
