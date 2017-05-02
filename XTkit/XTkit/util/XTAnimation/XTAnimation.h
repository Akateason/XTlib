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

#define TIME_ADD_CART       0.3f

@interface XTAnimation : NSObject

// in cell small big ;
+ (CABasicAnimation *)smallBigBestInCell ;
+ (void)smallBigBestInCell:(UIView *)view ;
//永久闪烁的动画
+ (CABasicAnimation *)opacityForever_Animation:(float)time  ;
//有闪烁次数的动画
+ (CABasicAnimation *)opacityTimes_Animation:(float)repeatTimes durTimes:(float)time ;
//横向移动
+ (CABasicAnimation *)moveX:(float)time X:(NSNumber *)x  ;
//纵向移动
+ (CABasicAnimation *)moveY:(float)time Y:(NSNumber *)y AndWithReciever:(id)reciever  ;     //纵向移动
//缩放
+ (CABasicAnimation *)scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time Rep:(float)repeatTimes ;
//组合动画
+ (CAAnimationGroup *)groupAnimation:(NSArray *)animationAry durTimes:(float)time Rep:(float)repeatTimes ;
//路径动画
+ (CAKeyframeAnimation *)keyframeAniamtion:(CGRect)pathRect durTimes:(float)time Rep:(float)repeatTimes ;
//点移动
+ (CABasicAnimation *)movepoint:(CGPoint )point ;

//旋转
//垂直旋转
+ (CABasicAnimation *)verticalRotationWithDuration:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount ;
//水平旋转
+ (CABasicAnimation *)horizonRotationWithDuration:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount ;

//震动
+ (void)shakeRandomDirectionWithDuration:(NSTimeInterval)duration AndWithView:(UIView *)view ;

//jgb加入购物车
+ (CAAnimationGroup *)addShopCarAnimation ;

// 放大缩小闪烁
+ (void)animationTransformWithView:(UIView *)theview
                AndWithRepeatCount:(float)repeatCount ;
+ (void)animationTransformWithLayer:(CALayer *)layer ;


#pragma mark --
#pragma mark - Custom Animation

/**
 *   @brief 快速构建一个你自定义的动画,有以下参数供你设置.
 *
 *   @note  调用系统预置Type需要在调用类引入下句
 *
 *          #import <QuartzCore/QuartzCore.h>
 *
 *   @param type                动画过渡类型
 *   @param subType             动画过渡方向(子类型)
 *   @param duration            动画持续时间
 *   @param timingFunction      动画定时函数属性
 *   @param theView             需要添加动画的view.
 *
 *
 */
+ (void)showAnimationType:(NSString *)type
              withSubType:(NSString *)subType
                 duration:(CFTimeInterval)duration
           timingFunction:(NSString *)timingFunction
                     view:(UIView *)theView;

#pragma mark - Preset Animation

/**
 *  下面是一些常用的动画效果
 */

// reveal
+ (void)animationRevealFromBottom:(UIView *)view;
+ (void)animationRevealFromTop:(UIView *)view;
+ (void)animationRevealFromLeft:(UIView *)view;
+ (void)animationRevealFromRight:(UIView *)view;

// 渐隐渐消
+ (void)animationEaseIn:(UIView *)view;
+ (void)animationEaseOut:(UIView *)view;

// 翻转
+ (void)animationFlipFromLeft:(UIView *)view;
+ (void)animationFlipFromRigh:(UIView *)view;

// 翻页
+ (void)animationCurlUp:(UIView *)view;
+ (void)animationCurlDown:(UIView *)view;

// push
+ (void)animationPushUp:(UIView *)view;
+ (void)animationPushDown:(UIView *)view;
+ (void)animationPushLeft:(UIView *)view;
+ (void)animationPushRight:(UIView *)view;

// move
+ (void)animationMoveUp:(UIView *)view duration:(CFTimeInterval)duration;
+ (void)animationMoveDown:(UIView *)view duration:(CFTimeInterval)duration;
+ (void)animationMoveLeft:(UIView *)view;
+ (void)animationMoveRight:(UIView *)view;

// 旋转缩放z

// 旋转同时缩小放大效果
+ (void)animationRotateAndScaleDownUp:(UIView *)view;

//无尽转向回转
+ (void)turnRoundBackWithView:(UIView *)theView ;

#pragma mark - Private API

/**
 *  下面动画里用到的某些属性在当前API里是不合法的,但是也可以用.
 */
+ (void)animationFlipFromTop:(UIView *)view;
+ (void)animationFlipFromBottom:(UIView *)view;

+ (void)animationCubeFromLeft:(UIView *)view;
+ (void)animationCubeFromRight:(UIView *)view;
+ (void)animationCubeFromTop:(UIView *)view;
+ (void)animationCubeFromBottom:(UIView *)view;

+ (void)animationSuckEffect:(UIView *)view;

+ (void)animationRippleEffect:(UIView *)view;

+ (void)animationCameraOpen:(UIView *)view;
+ (void)animationCameraClose:(UIView *)view;


@end
