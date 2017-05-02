//
//  AlertBackgroundView.m
//  SuBaoJiang
//
//  Created by apple on 15/7/14.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import "AlertBackgroundView.h"
#import "ScreenHeader.h"

@implementation AlertBackgroundView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.frame = APPFRAME ;
        self.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.6] ;
        UIButton *btBack = [[UIButton alloc] init] ;
        btBack.frame = self.frame ;
        [self addSubview:btBack] ;
        [btBack addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside] ;
    }
    
    return self;
}

- (void)clickBack
{
    //    NSLog(@"clickBack") ;
    [self.delegate cancel] ;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
