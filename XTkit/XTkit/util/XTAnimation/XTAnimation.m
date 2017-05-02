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


// in cell small big ;
+ (CABasicAnimation *)smallBigBestInCell
{
    CATransform3D tran = CATransform3DMakeScale(0.96, 0.96, 1) ;
    CABasicAnimation* animation ;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"] ;
    animation.toValue= [NSValue valueWithCATransform3D:tran] ;
    animation.duration= 0.25 ;
    animation.autoreverses = YES ;
    animation.cumulative = YES ;
    animation.removedOnCompletion = YES ;
    animation.fillMode = kCAFillModeForwards ;
    animation.repeatCount= 1 ;
    
    return animation ;
}

+ (void)smallBigBestInCell:(UIView *)view
{
    CATransform3D tran = CATransform3DMakeScale(0.98, 0.98, 1) ;
    CABasicAnimation* animation ;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"] ;
    animation.toValue= [NSValue valueWithCATransform3D:tran] ;
    animation.duration= 0.25 ;
    animation.autoreverses = YES ;
    animation.cumulative = YES ;
    animation.removedOnCompletion = YES ;
    animation.fillMode = kCAFillModeForwards ;
    animation.repeatCount= 1 ;
    
    [view.layer addAnimation:animation forKey:@"smallbigAnimat"] ;
}


//几个可以用来实现热门APP应用PATH中menu效果的几个方法

+ (CABasicAnimation *)opacityForever_Animation:(float)time //永久闪烁的动画

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    
    animation.toValue=[NSNumber numberWithFloat:0.7];
    
    animation.autoreverses=YES;
    
    animation.duration = time;
    
    animation.repeatCount = FLT_MAX;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}



+ (CABasicAnimation *)opacityTimes_Animation:(float)repeatTimes durTimes:(float)time //有闪烁次数的动画

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    
    animation.toValue=[NSNumber numberWithFloat:0.4];
    
    animation.repeatCount=repeatTimes;
    
    animation.duration=time;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    animation.autoreverses=YES;
    
    return  animation;
    
}



+ (CABasicAnimation *)moveX:(float)time X:(NSNumber *)x  //横向移动

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    
    animation.toValue=x;
    
    animation.duration=time;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}



+ (CABasicAnimation *)moveY:(float)time Y:(NSNumber *)y AndWithReciever:(id)reciever      //纵向移动

{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    
    animation.toValue = y;
    
    animation.duration = time;
    
    animation.delegate = reciever ;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    return animation;
    
}



+ (CABasicAnimation *)scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time Rep:(float)repeatTimes     //缩放

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.fromValue = orginMultiple;
    
    animation.toValue = Multiple;
    
    animation.duration = time;
    
    animation.autoreverses = YES;
    
    animation.repeatCount = repeatTimes;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    return animation;
    
}



+ (CAAnimationGroup *)groupAnimation:(NSArray *)animationAry durTimes:(float)time Rep:(float)repeatTimes     //组合动画

{
    
    CAAnimationGroup *animation=[CAAnimationGroup animation];
    
    animation.animations=animationAry;
    
    animation.duration=time;
    
    animation.repeatCount=repeatTimes;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}



+ (CAKeyframeAnimation *)keyframeAniamtion:(CGRect)pathRect durTimes:(float)time Rep:(float)repeatTimes    //路径动画

{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, pathRect);
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    animation.path = path;
    
    CGPathRelease(path) ;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn] ;
    
    animation.autoreverses = NO ;
    
    animation.duration = time;
    
    animation.repeatCount = repeatTimes;
    
    return animation ;
    
}



+ (CABasicAnimation *)movepoint:(CGPoint )point  //点移动

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation"];
    
    animation.toValue=[NSValue valueWithCGPoint:point];
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}


//垂直旋转
+ (CABasicAnimation *)verticalRotationWithDuration:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount

{
    degree = ( degree * M_PI ) / 180 ;
    
    CATransform3D rotationTransform  = CATransform3DMakeRotation(degree, 0, direction ,0);
    //CATransform3DMakeRotation(degree, 0, 0,direction);
    
    CABasicAnimation* animation;
    
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    animation.toValue= [NSValue valueWithCATransform3D:rotationTransform];
    
    animation.duration= dur;
    
    animation.autoreverses = YES;
    
    animation.cumulative = YES;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    animation.repeatCount= repeatCount;
    
    animation.delegate= self;
    
    return animation;
    
}

//水平旋转
+ (CABasicAnimation *)horizonRotationWithDuration:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount

{
    degree = ( degree * M_PI ) / 180 ;
    
    CATransform3D rotationTransform  = CATransform3DMakeRotation(degree, 0, 0 ,direction);
    //CATransform3DMakeRotation(degree, 0, 0,direction);
    
    CABasicAnimation* animation;
    
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    animation.toValue= [NSValue valueWithCATransform3D:rotationTransform];
    
    animation.duration= dur;
    
//    animation.autoreverses = YES;
    
    animation.cumulative = YES;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    animation.repeatCount= repeatCount;
    
    animation.delegate= self;
    
    
    
    return animation;
    
}



+ (CAAnimationGroup *)addShopCarAnimation
{
    
    CAKeyframeAnimation *pathAnimate = [XTAnimation keyframeAniamtion:CGRectMake(0, APPFRAME.size.height, 50, 50) durTimes:0.65f Rep:3] ;
    CABasicAnimation    *pointMovAni = [XTAnimation movepoint:CGPointMake(320 - 50, - APPFRAME.size.height - 50)] ;
//    CABasicAnimation    *scaleAni    = [TeaAnimation scale:@0.05 orgin:@1.0 durTimes:sumTime Rep:1] ;
//    CAAnimationGroup    *groupAnimate = [TeaAnimation groupAnimation:@[pathAnimate,pointMovAni,scaleAni] durTimes:sumTime Rep:1] ;

    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI) * 2];
    rotationAnimation.duration = 0.35 ;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.05];
    scaleAnimation.duration = TIME_ADD_CART ;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = TIME_ADD_CART;
//    animationGroup.autoreverses = YES;
    animationGroup.repeatCount = 1;
    animationGroup.animations = [NSArray arrayWithObjects:pathAnimate,pointMovAni,rotationAnimation, scaleAnimation, nil];
    
    return animationGroup ;
}

// 放大缩小闪烁
+ (void)animationTransformWithView:(UIView *)theview
                AndWithRepeatCount:(float)repeatCount
{
    CAKeyframeAnimation *k = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    k.values    = @[@(0.1),@(1.5),@(1.0)];
    k.keyTimes  = @[@(0.0),@(0.5),@(0.8),@(1.0)];
    k.calculationMode = kCAAnimationLinear;
    k.repeatCount = repeatCount ;
    [theview.layer addAnimation:k forKey:@"SHOWbigsmall_view"];
}


+ (void)animationTransformWithLayer:(CALayer *)layer
{
    CAKeyframeAnimation *k = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    k.values    = @[@(1.0),@(0.95),@(1.05),@(1.0)];
    k.keyTimes  = @[@(0.0),@(0.33),@(0.66),@(1.0)];
    k.calculationMode = kCAAnimationLinear;
    k.repeatCount = FLT_MAX ;
    k.duration = 1.25f ;
    [layer addAnimation:k forKey:@"SHOWbigsmall_layer"];
}


static NSString * const kAFViewShakerAnimationKey = @"kAFViewShakerAnimationKey";

+ (void)shakeRandomDirectionWithDuration:(NSTimeInterval)duration AndWithView:(UIView *)view
{
    int randomNum = arc4random()%100 ;
    if (randomNum >= 50)
    {
        CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        CGFloat currentTx = view.transform.tx;
//        animation.delegate = self;
        animation.duration = duration;
        animation.values = @[ @(currentTx), @(currentTx + 8), @(currentTx-6), @(currentTx + 6), @(currentTx - 3), @(currentTx + 3), @(currentTx) ];
        animation.keyTimes = @[ @(0), @(0.225), @(0.425), @(0.6), @(0.75), @(0.875), @(1) ];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        
        [view.layer addAnimation:animation forKey:kAFViewShakerAnimationKey];
    }
    else
    {
        CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
        CGFloat currentTy = view.transform.ty;
//        animation.delegate = self;
        animation.duration = duration;
        animation.values = @[ @(currentTy), @(currentTy + 8), @(currentTy-6), @(currentTy + 6), @(currentTy - 3), @(currentTy + 3), @(currentTy) ];
        animation.keyTimes = @[ @(0), @(0.225), @(0.425), @(0.6), @(0.75), @(0.875), @(1) ];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
        [view.layer addAnimation:animation forKey:kAFViewShakerAnimationKey];
    }
    

}


#pragma mark --
/**
 *  首先推荐一个不错的网站.   http://www.raywenderlich.com
 */

#pragma mark - Custom Animation

+ (void)showAnimationType:(NSString *)type
              withSubType:(NSString *)subType
                 duration:(CFTimeInterval)duration
           timingFunction:(NSString *)timingFunction
                     view:(UIView *)theView
{
    /** CATransition
     *
     *  @see http://www.dreamingwish.com/dream-2012/the-concept-of-coreanimation-programming-
     
     guide.html
     *  @see http://geeklu.com/2012/09/animation-in-ios/
     *
     *  CATransition 常用设置及属性注解如下:
     */
    
    CATransition *animation = [CATransition animation];
    
    /** delegate
     *
     *  动画的代理,如果你想在动画开始和结束的时候做一些事,可以设置此属性,它会自动回调两个代理方法.
     *
     *  @see CAAnimationDelegate    (按下command键点击)
     */
    
    animation.delegate = self;
    
    /** duration
     *
     *  动画持续时间
     */
    
    animation.duration = duration;
    
    /** timingFunction
     *
     *  用于变化起点和终点之间的插值计算,形象点说它决定了动画运行的节奏,比如是均匀变化(相同时间变
     
     化量相同)还是
     *  先快后慢,先慢后快还是先慢再快再慢.
     *
     *  动画的开始与结束的快慢,有五个预置分别为(下同):
     *  kCAMediaTimingFunctionLinear            线性,即匀速
     *  kCAMediaTimingFunctionEaseIn            先慢后快
     *  kCAMediaTimingFunctionEaseOut           先快后慢
     *  kCAMediaTimingFunctionEaseInEaseOut     先慢后快再慢
     *  kCAMediaTimingFunctionDefault           实际效果是动画中间比较快.
     */
    
    /** timingFunction
     *
     *  当上面的预置不能满足你的需求的时候,你可以使用下面的两个方法来自定义你的timingFunction
     *  具体参见下面的URL
     *
     *  @see
     
     http://developer.apple.com/library/ios/#documentation/Cocoa/Reference/CAMediaTimingFunction_class/
     
     Introduction/Introduction.html
     *
     *  + (id)functionWithControlPoints:(float)c1x :(float)c1y :(float)c2x :(float)c2y;
     *
     *  - (id)initWithControlPoints:(float)c1x :(float)c1y :(float)c2x :(float)c2y;
     */
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timingFunction];
    
    /** fillMode
     *
     *  决定当前对象过了非active时间段的行为,比如动画开始之前,动画结束之后.
     *  预置为:
     *  kCAFillModeRemoved   默认,当动画开始前和动画结束后,动画对layer都没有影响,动画结束后,layer
     
     会恢复到之前的状态
     *  kCAFillModeForwards  当动画结束后,layer会一直保持着动画最后的状态
     *  kCAFillModeBackwards 和kCAFillModeForwards相对,具体参考上面的URL
     *  kCAFillModeBoth      kCAFillModeForwards和kCAFillModeBackwards在一起的效果
     */
    
    animation.fillMode = kCAFillModeForwards;
    
    /** removedOnCompletion
     *
     *  这个属性默认为YES.一般情况下,不需要设置这个属性.
     *
     *  但如果是CAAnimation动画,并且需要设置 fillMode 属性,那么需要将 removedOnCompletion 设置为
     
     NO,否则
     *  fillMode无效
     */
    
    //    animation.removedOnCompletion = NO;
    
    /** type
     *
     *  各种动画效果  其中除了'fade', `moveIn', `push' , `reveal' ,其他属于似有的API(我是这么认为
     
     的,可以点进去看下注释).
     *  ↑↑↑上面四个可以分别使用'kCATransitionFade', 'kCATransitionMoveIn', 'kCATransitionPush',
     
     'kCATransitionReveal'来调用.
     *  @"cube"                     立方体翻滚效果
     *  @"moveIn"                   新视图移到旧视图上面
     *  @"reveal"                   显露效果(将旧视图移开,显示下面的新视图)
     *  @"fade"                     交叉淡化过渡(不支持过渡方向)             (默认为此效果)
     *  @"pageCurl"                 向上翻一页
     *  @"pageUnCurl"               向下翻一页
     *  @"suckEffect"               收缩效果，类似系统最小化窗口时的神奇效果(不支持过渡方向)
     *  @"rippleEffect"             滴水效果,(不支持过渡方向)
     *  @"oglFlip"                  上下左右翻转效果
     *  @"rotate"                   旋转效果
     *  @"push"
     *  @"cameraIrisHollowOpen"     相机镜头打开效果(不支持过渡方向)
     *  @"cameraIrisHollowClose"    相机镜头关上效果(不支持过渡方向)
     */
    
    /** type
     *
     *  kCATransitionFade            交叉淡化过渡
     *  kCATransitionMoveIn          新视图移到旧视图上面
     *  kCATransitionPush            新视图把旧视图推出去
     *  kCATransitionReveal          将旧视图移开,显示下面的新视图
     */
    
    animation.type = type;
    
    /** subtype
     *
     *  各种动画方向
     *
     *  kCATransitionFromRight;      同字面意思(下同)
     *  kCATransitionFromLeft;
     *  kCATransitionFromTop;
     *  kCATransitionFromBottom;
     */
    
    /** subtype
     *
     *  当type为@"rotate"(旋转)的时候,它也有几个对应的subtype,分别为:
     *  90cw    逆时针旋转90°
     *  90ccw   顺时针旋转90°
     *  180cw   逆时针旋转180°
     *  180ccw  顺时针旋转180°
     */
    
    /**
     *  type与subtype的对应关系(必看),如果对应错误,动画不会显现.
     *
     *  @see http://iphonedevwiki.net/index.php/CATransition
     */
    
    animation.subtype = subType;
    
    /**
     *  所有核心动画和特效都是基于CAAnimation,而CAAnimation是作用于CALayer的.所以把动画添加到layer
     
     上.
     *  forKey  可以是任意字符串.
     */
    
    [theView.layer addAnimation:animation forKey:nil];
}

#pragma mark - Preset Animation


+ (void)animationRevealFromBottom:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromBottom];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  
                                  functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationRevealFromTop:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromTop];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  
                                  functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationRevealFromLeft:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationRevealFromRight:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromRight];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [view.layer addAnimation:animation forKey:nil];
}


+ (void)animationEaseIn:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setType:kCATransitionFade];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  
                                  functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationEaseOut:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.15f];
    [animation setType:kCATransitionFade];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  
                                  functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    [view.layer addAnimation:animation forKey:nil];
}


/**
 *  UIViewAnimation
 *
 *  @see    http://www.cocoachina.com/bbs/read.php?tid=110168
 *
 *  @brief  UIView动画应该是最简单便捷创建动画的方式了,详解请猛戳URL.
 *
 *  @method beginAnimations:context 第一个参数用来作为动画的标识,第二个参数给代理代理传递消息.至于
 
 为什么一个使用
 *                                  nil而另外一个使用NULL,是因为第一个参数是一个对象指针,而第二个
 
 参数是基本数据类型.
 *  @method setAnimationCurve:      设置动画的加速或减速的方式(速度)
 *  @method setAnimationDuration:   动画持续时间
 *  @method setAnimationTransition:forView:cache:   第一个参数定义动画类型，第二个参数是当前视图对
 
 象，第三个参数是是否使用缓冲区
 *  @method commitAnimations        动画结束
 */

+ (void)animationFlipFromLeft:(UIView *)view
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.35f];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:view cache:NO];
    [UIView commitAnimations];
}

+ (void)animationFlipFromRigh:(UIView *)view
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.35f];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:view cache:NO];
    [UIView commitAnimations];
}


+ (void)animationCurlUp:(UIView *)view
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.35f];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:view cache:NO];
    [UIView commitAnimations];
}

+ (void)animationCurlDown:(UIView *)view
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.35f];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:view cache:NO];
    [UIView commitAnimations];
}

+ (void)animationPushUp:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  
                                  functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromTop];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationPushDown:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  
                                  functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromBottom];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationPushLeft:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  
                                  functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromLeft];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationPushRight:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    
    [view.layer addAnimation:animation forKey:nil];
}

// presentModalViewController
+ (void)animationMoveUp:(UIView *)view duration:(CFTimeInterval)duration
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromTop];
    
    [view.layer addAnimation:animation forKey:nil];
}

// dissModalViewController
+ (void)animationMoveDown:(UIView *)view duration:(CFTimeInterval)duration
{
    CATransition *transition = [CATransition animation];
    transition.duration =0.4;
    transition.timingFunction = [CAMediaTimingFunction
                                 
                                 functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    [view.layer addAnimation:transition forKey:nil];
}

+ (void)animationMoveLeft:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  
                                  functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromLeft];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationMoveRight:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  
                                  functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromRight];
    
    [view.layer addAnimation:animation forKey:nil];
}



/** CABasicAnimation
 *
 *  @see
 
 https://developer.apple.com/library/mac/#documentation/cocoa/conceptual/CoreAnimation_guide/Articl
 
 es/KVCAdditions.html
 *
 *  @brief                      便利构造函数 animationWithKeyPath: KeyPath需要一个字符串类型的参数
 
 ,实际上是一个
 *                              键-值编码协议的扩展,参数必须是CALayer的某一项属性,你的代码会对应的
 
 去改变该属性的效果
 *                              具体可以填写什么请参考上面的URL,切勿乱填!
 *                              例如这里填写的是 @"transform.rotation.z" 意思就是围绕z轴旋转,旋转
 
 的单位是弧度.
 *                              这个动画的效果是把view旋转到最小,再旋转回来.
 *                              你也可以填写@"opacity" 去修改透明度...以此类推.修改layer的属性,可
 
 以用这个类.
 *
 *  @param toValue              动画结束的值.CABasicAnimation自己只有三个属性(都很重要)(其他属性是
 
 继承来的),分别为:
 *                              fromValue(开始值), toValue(结束值), byValue(偏移值),
 !                              这三个属性最多只能同时设置两个;
 *                              他们之间的关系如下:
 *                              如果同时设置了fromValue和toValue,那么动画就会从fromValue过渡到
 
 toValue;
 *                              如果同时设置了fromValue和byValue,那么动画就会从fromValue过渡到
 
 fromValue + byValue;
 *                              如果同时设置了byValue  和toValue,那么动画就会从toValue - byValue过
 
 渡到toValue;
 *
 *                              如果只设置了fromValue,那么动画就会从fromValue过渡到当前的value;
 *                              如果只设置了toValue  ,那么动画就会从当前的value过渡到toValue;
 *                              如果只设置了byValue  ,那么动画就会从从当前的value过渡到当前value +
 
 byValue.
 *
 *                              可以这么理解,当你设置了三个中的一个或多个,系统就会根据以上规则使用
 
 插值算法计算出一个时间差并
 *                              同时开启一个Timer.Timer的间隔也就是这个时间差,通过这个Timer去不停
 
 地刷新keyPath的值.
 !                              而实际上,keyPath的值(layer的属性)在动画运行这一过程中,是没有任何变
 
 化的,它只是调用了GPU去
 *                              完成这些显示效果而已.
 *                              在这个动画里,是设置了要旋转到的弧度,根据以上规则,动画将会从它当前
 
 的弧度专旋转到我设置的弧度.
 *
 *  @param duration             动画持续时间
 *
 *  @param timingFunction       动画起点和终点之间的插值计算,也就是说它决定了动画运行的节奏,是快还
 
 是慢,还是先快后慢...
 */

/** CAAnimationGroup
 *
 *  @brief                      顾名思义,这是一个动画组,它允许多个动画组合在一起并行显示.比如这里
 
 设置了两个动画,
 *                              把他们加在动画组里,一起显示.例如你有几个动画,在动画执行的过程中需
 
 要同时修改动画的某些属性,
 *                              这时候就可以使用CAAnimationGroup.
 *
 *  @param duration             动画持续时间,值得一提的是,如果添加到group里的子动画不设置此属
 
 性,group里的duration会统一
 *                              设置动画(包括子动画)的duration属性;但是如果子动画设置了duration属
 
 性,那么group的duration属性
 *                              的值不应该小于每个子动画中duration属性的值,否则会造成子动画显示不
 
 全就停止了动画.
 *
 *  @param autoreverses         动画完成后自动重新开始,默认为NO.
 *
 *  @param repeatCount          动画重复次数,默认为0.
 *
 *  @param animations           动画组(数组类型),把需要同时运行的动画加到这个数组里.
 *
 *  @note  addAnimation:forKey  这个方法的forKey参数是一个字符串,这个字符串可以随意设置.
 *
 *  @note                       如果你需要在动画group执行结束后保存动画效果的话,设置 fillMode 属性
 
 ,并且把
 *                              removedOnCompletion 设置为NO;
 */

+ (void)animationRotateAndScaleDownUp:(UIView *)view
{
    CABasicAnimation *rotationAnimation = [CABasicAnimation
                                           
                                           animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI) * 2];
    rotationAnimation.duration = 0.55f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.duration = 0.55f;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation] ;
    animationGroup.duration = 0.55f;
    animationGroup.repeatCount = 1;
    animationGroup.animations =[NSArray arrayWithObjects:rotationAnimation, scaleAnimation, nil];
    [view.layer addAnimation:animationGroup forKey:@"animationGroup"];
}

//无尽转向回转
+ (void)turnRoundBackWithView:(UIView *)theView
{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    float tempAngle = 0 * ( M_PI / 2 ) ;
    
    animation.duration = 10.0f ;
    
    float flex = 0.2 * ( M_PI / 2 ) ;
    
    animation.values = @[ @(tempAngle), @(tempAngle - flex), @(tempAngle),@(tempAngle + flex), @(tempAngle) ];
    
    animation.keyTimes = @[ @(0), @(0.25),@(0.5), @(0.75), @(1) ];
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    animation.repeatCount = FLT_MAX ;
    
    [theView.layer addAnimation:animation forKey:@"turnRoundBackWithView"] ;
}



#pragma mark - Private API

+ (void)animationFlipFromTop:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  
                                  functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"oglFlip"];
    [animation setSubtype:@"fromTop"];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationFlipFromBottom:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  
                                  functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"oglFlip"];
    [animation setSubtype:@"fromBottom"];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationCubeFromLeft:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  
                                  functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"cube"];
    [animation setSubtype:@"fromLeft"];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationCubeFromRight:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  
                                  functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"cube"];
    [animation setSubtype:@"fromRight"];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationCubeFromTop:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  
                                  functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"cube"];
    [animation setSubtype:@"fromTop"];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationCubeFromBottom:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction 
                                  
                                  functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"cube"];
    [animation setSubtype:@"fromBottom"];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationSuckEffect:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction 
                                  
                                  functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"suckEffect"];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationRippleEffect:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.8f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction 
                                  functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"rippleEffect"];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationCameraOpen:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction 
                                  
                                  functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"cameraIrisHollowOpen"];
    [animation setSubtype:@"fromRight"];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationCameraClose:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction 
                                  
                                  functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"cameraIrisHollowClose"];
    [animation setSubtype:@"fromRight"];
    
    [view.layer addAnimation:animation forKey:nil];
}





@end
