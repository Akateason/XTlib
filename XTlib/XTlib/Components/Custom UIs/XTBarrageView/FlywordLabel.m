//
//  FlywordLabel.m
//  SuBaoJiang
//
//  Created by apple on 15/6/4.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import "FlywordLabel.h"

#define FLEX_WIDTHS 5.0f

@implementation FlywordLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


// HIDE BY @TEA 20150609

- (void)drawTextInRect:(CGRect)rect
{
    UIEdgeInsets insets = {0,FLEX_WIDTHS, 0, FLEX_WIDTHS};
    
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}



@end
