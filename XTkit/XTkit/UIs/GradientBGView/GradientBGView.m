//
//  GradientBGView.m
//  pro
//
//  Created by TuTu on 16/9/18.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "GradientBGView.h"

@interface GradientBGView ()
{
    CGRect _previousRect;
}
@property (weak, nonatomic) CALayer *gradientLayer;
@end

@implementation GradientBGView


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    if (!CGRectEqualToRect(self.bounds, _previousRect)) {
        _previousRect = self.bounds;
        
        if (!_gradientLayer) {
            CAGradientLayer *layer = [CAGradientLayer new];
            layer.colors = @[(__bridge id)_inputColor0.CGColor, (__bridge id)_inputColor1.CGColor];
            layer.startPoint = _inputPoint0;
            layer.endPoint = _inputPoint1;
            layer.frame = self.bounds;
            
            _gradientLayer = layer;
            [self.layer addSublayer:layer];
        }
        
        _gradientLayer.frame = _previousRect;
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
