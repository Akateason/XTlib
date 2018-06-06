//
//  RootCustomView.h
//  XTlib
//
//  Created by teason23 on 2018/6/6.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface UIView (XTRootCustom)

@property (nonatomic, assign) IBInspectable BOOL      xt_completeRound ;
@property (nonatomic, assign) IBInspectable float     xt_cornerRadius ;
@property (nonatomic, assign) IBInspectable float     xt_borderWidth ;
@property (nonatomic, strong) IBInspectable UIColor   *xt_borderColor ;
@property (nonatomic, assign) IBInspectable BOOL      xt_maskToBounds ;

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


