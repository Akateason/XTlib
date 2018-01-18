//
//  UIButton+ExtendTouchRect.m
//  XTkit
//
//  Created by teason23 on 2017/6/20.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "UIButton+ExtendTouchRect.h"
#import <objc/runtime.h>

@implementation UIButton (ExtendTouchRect)

void Swizzle(Class c, SEL orig, SEL new)
{
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    if (class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))){
        class_replaceMethod(c, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, newMethod);
    }
}

+ (void)load {
    Swizzle(self, @selector(pointInside:withEvent:), @selector(myPointInside:withEvent:));
}

- (BOOL)myPointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (UIEdgeInsetsEqualToEdgeInsets(self.touchExtendInset, UIEdgeInsetsZero) || self.hidden ||
        ([self isKindOfClass:UIControl.class] && !((UIControl *)self).enabled))
    {
        return [self myPointInside:point withEvent:event]; // original implementation
    }
    
    CGRect hitFrame = UIEdgeInsetsInsetRect(self.bounds, self.touchExtendInset);
    hitFrame.size.width = MAX(hitFrame.size.width, 0); // don't allow negative sizes
    hitFrame.size.height = MAX(hitFrame.size.height, 0);
    return CGRectContainsPoint(hitFrame, point);
}

static char touchExtendInsetKey ;
- (void)setTouchExtendInset:(UIEdgeInsets)touchExtendInset {
    objc_setAssociatedObject(self, &touchExtendInsetKey, [NSValue valueWithUIEdgeInsets:touchExtendInset],
                             OBJC_ASSOCIATION_RETAIN) ;
}

- (UIEdgeInsets)touchExtendInset {
    return [objc_getAssociatedObject(self, &touchExtendInsetKey) UIEdgeInsetsValue] ;
}


// enlarge e.g. UIEdgeInsetsMake(-15, -15, -15, -15) ;
- (void)xt_enlargeButtonsTouchArea {
    self.touchExtendInset = UIEdgeInsetsMake(-kDefaultEnlargeFlex, -kDefaultEnlargeFlex, -kDefaultEnlargeFlex, -kDefaultEnlargeFlex) ;
}

@end
