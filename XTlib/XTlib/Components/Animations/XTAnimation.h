//
//  TeaAnimation.h
//  AnimationPlay
//
//  Created by JGBMACMINI01 on 14-11-21.
//  Copyright (c) 2014年 JGBMACMINI01. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIGeometry.h>


@interface XTAnimation : NSObject

#pragma mark - Preset Animation

// shake
+ (void)shakeRandomDirectionWithDuration:(NSTimeInterval)duration AndWithView:(UIView *)view;

// rotate forever
+ (void)rotateForever:(UIView *)view once:(CGFloat)once;
// rotate and enlarge
+ (void)rotateAndEnlarge:(UIView *)view;
// cradle
+ (void)cradle:(UIView *)theView;

// reveal
+ (void)animationRevealFromBottom:(UIView *)view duration:(CGFloat)duration;
+ (void)animationRevealFromTop:(UIView *)view duration:(CGFloat)duration;
+ (void)animationRevealFromLeft:(UIView *)view duration:(CGFloat)duration;
+ (void)animationRevealFromRight:(UIView *)view duration:(CGFloat)duration;

// flip
+ (void)animationFlipFromLeft:(UIView *)view duration:(CGFloat)duration;
+ (void)animationFlipFromRigh:(UIView *)view duration:(CGFloat)duration;

// curl
+ (void)animationCurlUp:(UIView *)view duration:(CGFloat)duration;
+ (void)animationCurlDown:(UIView *)view duration:(CGFloat)duration;

// push
+ (void)animationPushUp:(UIView *)view duration:(CGFloat)duration;
+ (void)animationPushDown:(UIView *)view duration:(CGFloat)duration;
+ (void)animationPushLeft:(UIView *)view duration:(CGFloat)duration;
+ (void)animationPushRight:(UIView *)view duration:(CGFloat)duration;

// move
+ (void)animationMoveUp:(UIView *)view duration:(CGFloat)duration;
+ (void)animationMoveDown:(UIView *)view duration:(CGFloat)duration;
+ (void)animationMoveLeft:(UIView *)view duration:(CGFloat)duration;
+ (void)animationMoveRight:(UIView *)view duration:(CGFloat)duration;

#pragma mark - Private API

/**
 *  下面动画里用到的某些属性在当前API里是不合法的,但是也可以用. 有立体感 .
 */
+ (void)animationFlipFromTop:(UIView *)view duration:(CGFloat)duration;
+ (void)animationFlipFromBottom:(UIView *)view duration:(CGFloat)duration;

+ (void)animationCubeFromLeft:(UIView *)view duration:(CGFloat)duration;
+ (void)animationCubeFromRight:(UIView *)view duration:(CGFloat)duration;
+ (void)animationCubeFromTop:(UIView *)view duration:(CGFloat)duration;
+ (void)animationCubeFromBottom:(UIView *)view duration:(CGFloat)duration;

+ (void)animationSuckEffect:(UIView *)view duration:(CGFloat)duration;
+ (void)animationRippleEffect:(UIView *)view duration:(CGFloat)duration;

+ (void)animationCameraOpen:(UIView *)view duration:(CGFloat)duration;
+ (void)animationCameraClose:(UIView *)view duration:(CGFloat)duration;


@end
