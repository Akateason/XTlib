//
//  GradientButton.m
//  SwiftCall
//
//  Created by teason23 on 2018/3/27.
//  Copyright © 2018年 weyl. All rights reserved.
//

#import "GradientButton.h"


@interface GradientButton ()
@property (strong, nonatomic) CAGradientLayer *gradientLayer;
@end


@implementation GradientButton

- (void)addColors:(NSArray *)colors bounds:(CGRect)bounds {
    if (self.gradientLayer.superlayer) [self.gradientLayer removeFromSuperlayer];
    if (self.gradientLayer) self.gradientLayer = nil;

    if ([[colors firstObject] isKindOfClass:[UIColor class]]) {
        NSMutableArray *tmpColorList = [@[] mutableCopy];
        [colors enumerateObjectsUsingBlock:^(UIColor *obj, NSUInteger idx, BOOL *_Nonnull stop) {
            [tmpColorList addObject:(__bridge id)obj.CGColor];
        }];
        colors = [tmpColorList copy];
    }

    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors           = colors;
    gradientLayer.locations        = @[ @0, @1.0 ];
    gradientLayer.startPoint       = CGPointMake(0, 0);
    gradientLayer.endPoint         = CGPointMake(1.0, 0);
    gradientLayer.frame            = bounds;
    gradientLayer.cornerRadius     = bounds.size.height / 2.;
    self.gradientLayer             = gradientLayer;
    [self.layer insertSublayer:self.gradientLayer below:self.titleLabel.layer];
}

- (void)addColors:(NSArray *)colors {
    [self addColors:colors bounds:self.bounds];
}

@end
