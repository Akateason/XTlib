//
//  RootCustomView.h
//  XTlib
//
//  Created by teason23 on 2018/6/6.
//  Copyright © 2018年 teason23. All rights reserved.

// use in IB / Storyboard . inherit

#import <UIKit/UIKit.h>

IB_DESIGNABLE


@interface UIView (XTRootCustom)
// layer
@property (nonatomic, assign) IBInspectable BOOL xt_completeRound;
@property (nonatomic, assign) IBInspectable float xt_cornerRadius;
@property (nonatomic, assign) IBInspectable float xt_borderWidth;
@property (nonatomic, strong) IBInspectable UIColor *xt_borderColor;
@property (nonatomic, assign) IBInspectable BOOL xt_maskToBounds;

/*
 * gradient layer
 * Both points are
 * defined in a unit coordinate space that is then mapped to the
 * view's bounds rectangle when drawn. (I.e. [0,0] is the top-left
 * corner of the view, [1,1] is the bottom-right corner.) */
@property (nonatomic, assign) IBInspectable CGPoint xt_gradientPt0;
@property (nonatomic, assign) IBInspectable CGPoint xt_gradientPt1;
@property (nonatomic, strong) IBInspectable UIColor *xt_gradientColor0;
@property (nonatomic, strong) IBInspectable UIColor *xt_gradientColor1;

@end


@interface RootCustomView : UIView
@end


@interface RootCustomImageView : UIImageView
@end


@interface RootCustomButton : UIButton
@end


@interface RootCustomLabel : UILabel
@end


@interface RootCustomTextField : UITextField
@end


@interface RootCustomTextView : UITextView
@end
