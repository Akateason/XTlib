//
//  RootCustomView.m
//  XTlib
//
//  Created by teason23 on 2018/6/6.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "RootCustomView.h"
#import "NSObject+Runtime.h"

@implementation UIView (XTRootCustom)

- (void)setXt_completeRound:(BOOL)xt_completeRound {
    self.layer.cornerRadius = CGRectGetWidth(self.bounds) / 2.f ;
    self.layer.masksToBounds = YES ;
}

- (BOOL)xt_completeRound {
    return self.xt_completeRound ;
}

- (void)setXt_cornerRadius:(float)xt_cornerRadius {
    self.layer.cornerRadius = xt_cornerRadius ;
}

- (float)xt_cornerRadius {
    return self.xt_cornerRadius ;
}

- (void)setXt_borderWidth:(float)xt_borderWidth {
    self.layer.borderWidth = xt_borderWidth ;
}

- (float)xt_borderWidth {
    return self.xt_borderWidth ;
}

- (void)setXt_borderColor:(UIColor *)xt_borderColor {
    self.layer.borderColor = xt_borderColor.CGColor ;
}

- (UIColor *)xt_borderColor {
    return self.xt_borderColor ;
}

- (void)setXt_maskToBounds:(BOOL)xt_maskToBounds {
    self.layer.masksToBounds = xt_maskToBounds ;
}

- (BOOL)xt_maskToBounds {
    return self.xt_maskToBounds ;
}

@end



@implementation RootCustomView
@end

@implementation RootCustomImageView
@end

@implementation RootCustomButton
@end

@implementation RootCustomLabel
@end

@implementation RootCustomTextField
@end

@implementation RootCustomTextView
@end

