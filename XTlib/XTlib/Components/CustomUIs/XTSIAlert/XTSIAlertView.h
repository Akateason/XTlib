//
//  XTSIAlertView.h
//  XTlib
//
//  Created by teason23 on 2018/3/14.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XTColor/XTColor.h>

// bt bg color
#define kColorDefaultBt UIColorHex(@"EDE5E2")
#define kColorDestructiveBt UIColorHex(@"EA3556")
#define kColorCancelBt UIColorHex(@"61D2D6")
// bt title color
#define kTitleColorDefaultBt UIColorHex(@"808080")
#define kTitleColorDestructiveBt [UIColor whiteColor]
#define kTitleColorCancelBt [UIColor whiteColor]
// bt title color hightlight
#define kHIGHLIGHT_TitleColorDefaultBt [UIColor whiteColor]
#define kHIGHLIGHT_TitleColorDestructiveBt [UIColor whiteColor]
#define kHIGHLIGHT_TitleColorCancelBt [UIColor whiteColor]
// title color
#define kMainTitleFont [UIFont boldSystemFontOfSize:16]
#define kSubTitleFont [UIFont systemFontOfSize:14]
#define kMainSubTitleColor [UIColor blackColor]
// bg color
#define kBGBackColor [UIColor colorWithWhite:0.3 alpha:.7]
#define kAlertBgColor [UIColor whiteColor]

extern NSString *const XTSIAlertViewWillShowNotification;
extern NSString *const XTSIAlertViewDidShowNotification;
extern NSString *const XTSIAlertViewWillDismissNotification;
extern NSString *const XTSIAlertViewDidDismissNotification;

typedef NS_ENUM(NSInteger, XTSIAlertViewButtonType) {
    XTSIAlertViewButtonTypeDefault = 0,
    XTSIAlertViewButtonTypeDestructive,
    XTSIAlertViewButtonTypeCancel
};

typedef NS_ENUM(NSInteger, XTSIAlertViewBackgroundStyle) {
    XTSIAlertViewBackgroundStyleGradient = 0,
    XTSIAlertViewBackgroundStyleSolid,
};

typedef NS_ENUM(NSInteger, XTSIAlertViewTransitionStyle) {
    XTSIAlertViewTransitionStyleSlideFromBottom = 0,
    XTSIAlertViewTransitionStyleSlideFromTop,
    XTSIAlertViewTransitionStyleFade,
    XTSIAlertViewTransitionStyleBounce,
    XTSIAlertViewTransitionStyleDropDown
};

typedef NS_ENUM(NSInteger, XTSIAlertPositionStyle) {
    XTSIAlertViewPositionMiddle = 0,
    XTSIAlertViewPositionBottom
};

@class XTSIAlertView;
typedef void (^XTSIAlertViewHandler)(XTSIAlertView *alertView);


@interface XTSIAlertView : UIView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) XTSIAlertViewTransitionStyle transitionStyle; // default is XTSIAlertViewTransitionStyleSlideFromBottom
@property (nonatomic, assign) XTSIAlertViewBackgroundStyle backgroundStyle; // default is XTSIAlertViewButtonTypeGradient
@property (nonatomic, assign) XTSIAlertPositionStyle positionStyle;         // default is middle ; @ADD BY TEASON


@property (nonatomic, copy) XTSIAlertViewHandler willShowHandler;
@property (nonatomic, copy) XTSIAlertViewHandler didShowHandler;
@property (nonatomic, copy) XTSIAlertViewHandler willDismissHandler;
@property (nonatomic, copy) XTSIAlertViewHandler didDismissHandler;

@property (nonatomic, readonly, getter=isVisible) BOOL visible;

@property (nonatomic, strong) UIColor *viewBackgroundColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *titleColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *messageColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *titleFont NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *messageFont NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *buttonFont NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat cornerRadius NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR; // default is 2.0
@property (nonatomic, assign) CGFloat shadowRadius NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR; // default is 8.0


/**
 standard alertView
 */
+ (void)alertWithTitle:(NSString *)title
              subTitle:(NSString *)subTitle
         normalBtTitle:(NSString *)normalBtTitle
                normal:(XTSIAlertViewHandler)normalHandler
         cancelBtTitle:(NSString *)cancelBtTitle
                cancel:(XTSIAlertViewHandler)cancelHandler;

- (id)initWithTitle:(NSString *)title andMessage:(NSString *)message;
- (void)addButtonWithTitle:(NSString *)title type:(XTSIAlertViewButtonType)type handler:(XTSIAlertViewHandler)handler;

- (void)show;
- (void)dismissAnimated:(BOOL)animated;

@end
