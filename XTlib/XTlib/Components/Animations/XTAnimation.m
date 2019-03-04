//
//  TeaAnimation.m
//  AnimationPlay
//
//  Created by JGBMACMINI01 on 14-11-21.
//  Copyright (c) 2014年 JGBMACMINI01. All rights reserved.
//

#import "XTAnimation.h"
#import "ScreenHeader.h"


@implementation XTAnimation

static NSString *const kAFViewShakerAnimationKey = @"kAFViewShakerAnimationKey";
+ (void)shakeRandomDirectionWithDuration:(NSTimeInterval)duration AndWithView:(UIView *)view {
    int randomNum = arc4random() % 100;
    if (randomNum >= 50) {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        CGFloat currentTx              = view.transform.tx;
        animation.duration             = duration;
        animation.values               = @[ @(currentTx), @(currentTx + 8), @(currentTx - 6), @(currentTx + 6), @(currentTx - 3), @(currentTx + 3), @(currentTx) ];
        animation.keyTimes             = @[ @(0), @(0.225), @(0.425), @(0.6), @(0.75), @(0.875), @(1) ];
        animation.timingFunction       = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [view.layer addAnimation:animation forKey:kAFViewShakerAnimationKey];
    }
    else {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
        CGFloat currentTy              = view.transform.ty;
        animation.duration             = duration;
        animation.values               = @[ @(currentTy), @(currentTy + 8), @(currentTy - 6), @(currentTy + 6), @(currentTy - 3), @(currentTy + 3), @(currentTy) ];
        animation.keyTimes             = @[ @(0), @(0.225), @(0.425), @(0.6), @(0.75), @(0.875), @(1) ];
        animation.timingFunction       = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [view.layer addAnimation:animation forKey:kAFViewShakerAnimationKey];
    }
}

#pragma mark - Preset Animation


+ (void)animationRevealFromBottom:(UIView *)view duration:(CGFloat)duration {
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromBottom];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationRevealFromTop:(UIView *)view duration:(CGFloat)duration {
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromTop];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationRevealFromLeft:(UIView *)view duration:(CGFloat)duration {
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationRevealFromRight:(UIView *)view duration:(CGFloat)duration {
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromRight];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationFlipFromLeft:(UIView *)view duration:(CGFloat)duration {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:view cache:NO];
    [UIView commitAnimations];
}

+ (void)animationFlipFromRigh:(UIView *)view duration:(CGFloat)duration {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:view cache:NO];
    [UIView commitAnimations];
}

+ (void)animationCurlUp:(UIView *)view duration:(CGFloat)duration {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:view cache:NO];
    [UIView commitAnimations];
}

+ (void)animationCurlDown:(UIView *)view duration:(CGFloat)duration {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:view cache:NO];
    [UIView commitAnimations];
}

+ (void)animationPushUp:(UIView *)view duration:(CGFloat)duration {
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromTop];
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationPushDown:(UIView *)view duration:(CGFloat)duration {
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromBottom];
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationPushLeft:(UIView *)view duration:(CGFloat)duration {
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromLeft];
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationPushRight:(UIView *)view duration:(CGFloat)duration {
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationMoveUp:(UIView *)view duration:(CGFloat)duration {
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromTop];
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationMoveDown:(UIView *)view duration:(CGFloat)duration {
    CATransition *transition  = [CATransition animation];
    transition.duration       = duration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type           = kCATransitionReveal;
    transition.subtype        = kCATransitionFromBottom;
    [view.layer addAnimation:transition forKey:nil];
}

+ (void)animationMoveLeft:(UIView *)view duration:(CGFloat)duration {
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromLeft];
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationMoveRight:(UIView *)view duration:(CGFloat)duration {
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromRight];
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)rotateForever:(UIView *)view once:(CGFloat)once {
    CABasicAnimation *rotationAnimation;
    rotationAnimation                     = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue             = [NSNumber numberWithFloat:M_PI * 2.0];
    rotationAnimation.duration            = once;
    rotationAnimation.cumulative          = YES;
    rotationAnimation.repeatCount         = MAXFLOAT;
    rotationAnimation.removedOnCompletion = NO;
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

+ (void)rotateAndEnlarge:(UIView *)view {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue           = [NSNumber numberWithFloat:(2 * M_PI) * 2];
    rotationAnimation.duration          = 0.55f;
    rotationAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    CABasicAnimation *scaleAnimation    = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue            = [NSNumber numberWithFloat:0.0];
    scaleAnimation.toValue              = [NSNumber numberWithFloat:1.0];
    scaleAnimation.duration             = 0.55f;
    scaleAnimation.timingFunction       = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration          = 0.55f;
    animationGroup.repeatCount       = 1;
    animationGroup.animations        = [NSArray arrayWithObjects:rotationAnimation, scaleAnimation, nil];
    [view.layer addAnimation:animationGroup forKey:@"animationGroup"];
}

+ (void)cradle:(UIView *)theView {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    float tempAngle                = 0 * (M_PI / 2);
    animation.duration             = 10.0f;
    float flex                     = 0.2 * (M_PI / 2);
    animation.values               = @[ @(tempAngle), @(tempAngle - flex), @(tempAngle), @(tempAngle + flex), @(tempAngle) ];
    animation.keyTimes             = @[ @(0), @(0.25), @(0.5), @(0.75), @(1) ];
    animation.timingFunction       = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.repeatCount          = FLT_MAX;
    [theView.layer addAnimation:animation forKey:@"turnRoundBackWithView"];
}

#pragma mark - Private API

+ (void)animationFlipFromTop:(UIView *)view duration:(CGFloat)duration {
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"oglFlip"];
    [animation setSubtype:@"fromTop"];
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationFlipFromBottom:(UIView *)view duration:(CGFloat)duration {
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"oglFlip"];
    [animation setSubtype:@"fromBottom"];
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationCubeFromLeft:(UIView *)view duration:(CGFloat)duration {
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"cube"];
    [animation setSubtype:@"fromLeft"];
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationCubeFromRight:(UIView *)view duration:(CGFloat)duration {
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"cube"];
    [animation setSubtype:@"fromRight"];
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationCubeFromTop:(UIView *)view duration:(CGFloat)duration {
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"cube"];
    [animation setSubtype:@"fromTop"];
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationCubeFromBottom:(UIView *)view duration:(CGFloat)duration {
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"cube"];
    [animation setSubtype:@"fromBottom"];
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationSuckEffect:(UIView *)view duration:(CGFloat)duration {
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"suckEffect"];
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationRippleEffect:(UIView *)view duration:(CGFloat)duration {
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"rippleEffect"];
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationCameraOpen:(UIView *)view duration:(CGFloat)duration {
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"cameraIrisHollowOpen"];
    [animation setSubtype:@"fromRight"];
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationCameraClose:(UIView *)view duration:(CGFloat)duration {
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"cameraIrisHollowClose"];
    [animation setSubtype:@"fromRight"];
    [view.layer addAnimation:animation forKey:nil];
}

@end
