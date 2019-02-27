//
//  XTPATitleView.m
//  XTlib
//
//  Created by teason23 on 2019/2/27.
//  Copyright © 2019 teason23. All rights reserved.
//

#import "XTPATitleView.h"


@implementation XTPATitleView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.titleLabel.font                           = [UIFont systemFontOfSize:18];
        self.translatesAutoresizingMaskIntoConstraints = false;
        [self setImage:[UIImage imageNamed:@"ab_t_icon"
                                                inBundle:[NSBundle bundleForClass:self.class]
                           compatibleWithTraitCollection:nil]
              forState:0];
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(200, 40);
}


@end
