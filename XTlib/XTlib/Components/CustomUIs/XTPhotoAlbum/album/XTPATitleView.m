//
//  XTPATitleView.m
//  XTlib
//
//  Created by teason23 on 2019/2/27.
//  Copyright © 2019 teason23. All rights reserved.
//

#import "XTPATitleView.h"

@implementation XTPATitleView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:18] ;
        self.translatesAutoresizingMaskIntoConstraints = false ;
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(200, 40);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    
    NSString *tmpTitle = [@"▼ " stringByAppendingString:title] ;
    [super setTitle:tmpTitle forState:state] ;
}


@end
