//
//  XTSIAlertView.m
//  XTlib
//
//  Created by teason23 on 2018/3/14.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "XTSIAlertView.h"
#import <QuartzCore/QuartzCore.h>
#import "ScreenHeader.h"


NSString *const XTSIAlertViewWillShowNotification    = @"XTSIAlertViewWillShowNotification";
NSString *const XTSIAlertViewDidShowNotification     = @"XTSIAlertViewDidShowNotification";
NSString *const XTSIAlertViewWillDismissNotification = @"XTSIAlertViewWillDismissNotification";
NSString *const XTSIAlertViewDidDismissNotification  = @"XTSIAlertViewDidDismissNotification";

#define DEBUG_LAYOUT 0

#define MESSAGE_MIN_LINE_COUNT 1
#define MESSAGE_MAX_LINE_COUNT 5
#define GAP 5
#define CANCEL_BUTTON_PADDING_TOP 25
#define CONTENT_PADDING_LEFT 10
#define CONTENT_PADDING_TOP 15
#define CONTENT_PADDING_BOTTOM 10
#define BUTTON_HEIGHT 44
#define CONTAINER_WIDTH 300
#define kMY_CONTENT_PADDING_LEFT ((self.positionStyle == XTSIAlertViewPositionBottom) ? 25.0f : CONTENT_PADDING_LEFT)


const UIWindowLevel UIWindowLevelXTSIAlert           = 1999.0; // don't overlap system's alert
const UIWindowLevel UIWindowLevelXTSIAlertBackground = 1998.0; // below the alert window

@class XTSIAlertBackgroundWindow;

static NSMutableArray *__si_alert_queue;
static BOOL __si_alert_animating;
static XTSIAlertBackgroundWindow *__si_alert_background_window;
static XTSIAlertView *__si_alert_current_view;


@interface XTSIAlertView () <CAAnimationDelegate>

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) UIWindow *alertWindow;
@property (nonatomic, assign, getter=isVisible) BOOL visible;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) NSMutableArray *buttons;

@property (nonatomic, assign, getter=isLayoutDirty) BOOL layoutDirty;

+ (NSMutableArray *)sharedQueue;
+ (XTSIAlertView *)currentAlertView;

+ (BOOL)isAnimating;
+ (void)setAnimating:(BOOL)animating;

+ (void)showBackground;
+ (void)hideBackgroundAnimated:(BOOL)animated;

- (void)setup;
- (void)invaliadateLayout;
- (void)resetTransition;

@end

#pragma mark - SIBackgroundWindow


@interface XTSIAlertBackgroundWindow : UIWindow

@end


@interface XTSIAlertBackgroundWindow ()

@property (nonatomic, assign) XTSIAlertViewBackgroundStyle style;

@end


@implementation XTSIAlertBackgroundWindow

- (id)initWithFrame:(CGRect)frame andStyle:(XTSIAlertViewBackgroundStyle)style {
    self = [super initWithFrame:frame];
    if (self) {
        self.style            = style;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.opaque           = NO;
        self.windowLevel      = UIWindowLevelXTSIAlertBackground;
        self.backgroundColor  = kBGBackColor;
    }
    return self;
}

@end

#pragma mark - XTSIAlertItem


@interface XTSIAlertItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) XTSIAlertViewButtonType type;
@property (nonatomic, copy) XTSIAlertViewHandler action;

@end


@implementation XTSIAlertItem

@end

#pragma mark - XTSIAlertViewController


@interface XTSIAlertViewController : UIViewController

@property (nonatomic, strong) XTSIAlertView *alertView;

@end


@implementation XTSIAlertViewController

#pragma mark - View life cycle

- (void)loadView {
    self.view = self.alertView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.alertView setup];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self.alertView resetTransition];
    [self.alertView invaliadateLayout];
}

@end

#pragma mark - XTSIAlert


@implementation XTSIAlertView

+ (void)alertWithTitle:(NSString *)title
              subTitle:(NSString *)subTitle
         normalBtTitle:(NSString *)normalBtTitle
                normal:(XTSIAlertViewHandler)normalHandler
         cancelBtTitle:(NSString *)cancelBtTitle
                cancel:(XTSIAlertViewHandler)cancelHandler {
    XTSIAlertView *alert = [[XTSIAlertView alloc] initWithTitle:title andMessage:subTitle];
    [alert addButtonWithTitle:normalBtTitle
                         type:XTSIAlertViewButtonTypeDefault
                      handler:normalHandler];
    [alert addButtonWithTitle:cancelBtTitle
                         type:XTSIAlertViewButtonTypeCancel
                      handler:cancelHandler];
    [alert show];
}


+ (void)initialize {
    if (self != [XTSIAlertView class]) return;

    XTSIAlertView *appearance      = [self appearance];
    appearance.viewBackgroundColor = kAlertBgColor;
    appearance.titleColor          = kMainSubTitleColor;
    appearance.messageColor        = kMainSubTitleColor;
    appearance.titleFont           = kMainTitleFont;
    appearance.messageFont         = kSubTitleFont;
    appearance.buttonFont          = [UIFont systemFontOfSize:[UIFont buttonFontSize]];
    appearance.cornerRadius        = 2;
    appearance.shadowRadius        = 8;
}

- (id)init {
    return [self initWithTitle:nil andMessage:nil];
}

- (id)initWithTitle:(NSString *)title andMessage:(NSString *)message {
    self = [super init];
    if (self) {
        _title     = title;
        _message   = message;
        self.items = [[NSMutableArray alloc] init];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelf:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tapSelf:(UITapGestureRecognizer *)tap {
    if (self.items.count <= 2) return;

    NSLog(@"tap self click hidden ");
    [self dismissAnimated:YES];
}


#pragma mark - Class methods

+ (NSMutableArray *)sharedQueue {
    if (!__si_alert_queue) {
        __si_alert_queue = [NSMutableArray array];
    }
    return __si_alert_queue;
}

+ (XTSIAlertView *)currentAlertView {
    return __si_alert_current_view;
}

+ (void)setCurrentAlertView:(XTSIAlertView *)alertView {
    __si_alert_current_view = alertView;
}

+ (BOOL)isAnimating {
    return __si_alert_animating;
}

+ (void)setAnimating:(BOOL)animating {
    __si_alert_animating = animating;
}

+ (void)showBackground {
    if (!__si_alert_background_window) {
        __si_alert_background_window = [[XTSIAlertBackgroundWindow alloc] initWithFrame:[UIScreen mainScreen].bounds
                                                                               andStyle:[XTSIAlertView currentAlertView].backgroundStyle];
        [__si_alert_background_window makeKeyAndVisible];
        __si_alert_background_window.alpha = 0;
        [UIView animateWithDuration:0.3
                         animations:^{
                             __si_alert_background_window.alpha = 1;
                         }];
    }
}

+ (void)hideBackgroundAnimated:(BOOL)animated {
    if (!animated) {
        [__si_alert_background_window removeFromSuperview];
        __si_alert_background_window = nil;
        return;
    }
    [UIView animateWithDuration:0.3
        animations:^{
            __si_alert_background_window.alpha = 0;
        }
        completion:^(BOOL finished) {
            [__si_alert_background_window removeFromSuperview];
            __si_alert_background_window = nil;
        }];
}

#pragma mark - Setters

- (void)setTitle:(NSString *)title {
    _title = title;
    [self invaliadateLayout];
}

- (void)setMessage:(NSString *)message {
    _message = message;
    [self invaliadateLayout];
}


#pragma mark - Public

- (void)addButtonWithTitle:(NSString *)title type:(XTSIAlertViewButtonType)type handler:(XTSIAlertViewHandler)handler {
    XTSIAlertItem *item = [[XTSIAlertItem alloc] init];
    item.title          = title;
    item.type           = type;
    item.action         = handler;
    [self.items addObject:item];


    self.positionStyle = (self.items.count <= 2) ? XTSIAlertViewPositionMiddle : XTSIAlertViewPositionBottom;
}

- (void)show {
    if (![[XTSIAlertView sharedQueue] containsObject:self]) {
        [[XTSIAlertView sharedQueue] addObject:self];
    }

    if ([XTSIAlertView isAnimating]) {
        return; // wait for next turn
    }

    if (self.isVisible) {
        return;
    }

    if ([XTSIAlertView currentAlertView].isVisible) {
        XTSIAlertView *alert = [XTSIAlertView currentAlertView];
        [alert dismissAnimated:YES cleanup:NO];
        return;
    }

    if (self.willShowHandler) {
        self.willShowHandler(self);
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:XTSIAlertViewWillShowNotification object:self userInfo:nil];

    self.visible = YES;

    [XTSIAlertView setAnimating:YES];
    [XTSIAlertView setCurrentAlertView:self];

    // transition background
    [XTSIAlertView showBackground];

    XTSIAlertViewController *viewController = [[XTSIAlertViewController alloc] initWithNibName:nil bundle:nil];
    viewController.alertView                = self;

    if (!self.alertWindow) {
        UIWindow *window          = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.autoresizingMask   = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        window.opaque             = NO;
        window.windowLevel        = UIWindowLevelXTSIAlert;
        window.rootViewController = viewController;
        self.alertWindow          = window;
    }
    [self.alertWindow makeKeyAndVisible];

    [self validateLayout];

    [self transitionInCompletion:^{
        if (self.didShowHandler) {
            self.didShowHandler(self);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:XTSIAlertViewDidShowNotification object:self userInfo:nil];

        [XTSIAlertView setAnimating:NO];

        NSInteger index = [[XTSIAlertView sharedQueue] indexOfObject:self];
        if (index < [XTSIAlertView sharedQueue].count - 1) {
            [self dismissAnimated:YES cleanup:NO]; // dismiss to show next alert view
        }
    }];
}

- (void)dismissAnimated:(BOOL)animated {
    [self dismissAnimated:animated cleanup:YES];
}

- (void)dismissAnimated:(BOOL)animated cleanup:(BOOL)cleanup {
    BOOL isVisible = self.isVisible;

    if (isVisible) {
        if (self.willDismissHandler) {
            self.willDismissHandler(self);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:XTSIAlertViewWillDismissNotification object:self userInfo:nil];
    }

    void (^dismissComplete)(void) = ^{
        self.visible = NO;

        [self teardown];

        [XTSIAlertView setCurrentAlertView:nil];

        XTSIAlertView *nextAlertView;
        NSInteger index = [[XTSIAlertView sharedQueue] indexOfObject:self];
        if (index != NSNotFound && index < [XTSIAlertView sharedQueue].count - 1) {
            nextAlertView = [XTSIAlertView sharedQueue][index + 1];
        }

        if (cleanup) {
            [[XTSIAlertView sharedQueue] removeObject:self];
        }

        [XTSIAlertView setAnimating:NO];

        if (isVisible) {
            if (self.didDismissHandler) {
                self.didDismissHandler(self);
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:XTSIAlertViewDidDismissNotification object:self userInfo:nil];
        }

        // check if we should show next alert
        if (!isVisible) {
            return;
        }

        if (nextAlertView) {
            [nextAlertView show];
        }
        else {
            // show last alert view
            if ([XTSIAlertView sharedQueue].count > 0) {
                XTSIAlertView *alert = [[XTSIAlertView sharedQueue] lastObject];
                [alert show];
            }
        }
    };

    if (animated && isVisible) {
        [XTSIAlertView setAnimating:YES];
        [self transitionOutCompletion:dismissComplete];

        if ([XTSIAlertView sharedQueue].count == 1) {
            [XTSIAlertView hideBackgroundAnimated:YES];
        }
    }
    else {
        dismissComplete();

        if ([XTSIAlertView sharedQueue].count == 0) {
            [XTSIAlertView hideBackgroundAnimated:YES];
        }
    }
}

#pragma mark - Transitions

- (void)transitionInCompletion:(void (^)(void))completion {
    switch (self.transitionStyle) {
        case XTSIAlertViewTransitionStyleSlideFromBottom: {
            CGRect rect              = self.containerView.frame;
            CGRect originalRect      = rect;
            rect.origin.y            = self.bounds.size.height;
            self.containerView.frame = rect;
            [UIView animateWithDuration:0.3
                animations:^{
                    self.containerView.frame = originalRect;
                }
                completion:^(BOOL finished) {
                    if (completion) {
                        completion();
                    }
                }];
        } break;
        case XTSIAlertViewTransitionStyleSlideFromTop: {
            CGRect rect              = self.containerView.frame;
            CGRect originalRect      = rect;
            rect.origin.y            = -rect.size.height;
            self.containerView.frame = rect;
            [UIView animateWithDuration:0.3
                animations:^{
                    self.containerView.frame = originalRect;
                }
                completion:^(BOOL finished) {
                    if (completion) {
                        completion();
                    }
                }];
        } break;
        case XTSIAlertViewTransitionStyleFade: {
            self.containerView.alpha = 0;
            [UIView animateWithDuration:0.3
                animations:^{
                    self.containerView.alpha = 1;
                }
                completion:^(BOOL finished) {
                    if (completion) {
                        completion();
                    }
                }];
        } break;
        case XTSIAlertViewTransitionStyleBounce: {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            animation.values               = @[ @(0.01), @(1.2), @(0.9), @(1) ];
            animation.keyTimes             = @[ @(0), @(0.4), @(0.6), @(1) ];
            animation.timingFunctions      = @[ [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut] ];
            animation.duration             = 0.5;
            animation.delegate             = self;
            [animation setValue:completion forKey:@"handler"];
            [self.containerView.layer addAnimation:animation forKey:@"bouce"];
        } break;
        case XTSIAlertViewTransitionStyleDropDown: {
            CGFloat y                      = self.containerView.center.y;
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
            animation.values               = @[ @(y - self.bounds.size.height), @(y + 20), @(y - 10), @(y) ];
            animation.keyTimes             = @[ @(0), @(0.5), @(0.75), @(1) ];
            animation.timingFunctions      = @[ [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut] ];
            animation.duration             = 0.4;
            animation.delegate             = self;
            [animation setValue:completion forKey:@"handler"];
            [self.containerView.layer addAnimation:animation forKey:@"dropdown"];
        } break;
        default:
            break;
    }
}

- (void)transitionOutCompletion:(void (^)(void))completion {
    switch (self.transitionStyle) {
        case XTSIAlertViewTransitionStyleSlideFromBottom: {
            CGRect rect   = self.containerView.frame;
            rect.origin.y = self.bounds.size.height;
            [UIView animateWithDuration:0.3
                delay:0
                options:UIViewAnimationOptionCurveEaseIn
                animations:^{
                    self.containerView.frame = rect;
                }
                completion:^(BOOL finished) {
                    if (completion) {
                        completion();
                    }
                }];
        } break;
        case XTSIAlertViewTransitionStyleSlideFromTop: {
            CGRect rect   = self.containerView.frame;
            rect.origin.y = -rect.size.height;
            [UIView animateWithDuration:0.3
                delay:0
                options:UIViewAnimationOptionCurveEaseIn
                animations:^{
                    self.containerView.frame = rect;
                }
                completion:^(BOOL finished) {
                    if (completion) {
                        completion();
                    }
                }];
        } break;
        case XTSIAlertViewTransitionStyleFade: {
            [UIView animateWithDuration:0.25
                animations:^{
                    self.containerView.alpha = 0;
                }
                completion:^(BOOL finished) {
                    if (completion) {
                        completion();
                    }
                }];
        } break;
        case XTSIAlertViewTransitionStyleBounce: {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            animation.values               = @[ @(1), @(1.2), @(0.01) ];
            animation.keyTimes             = @[ @(0), @(0.4), @(1) ];
            animation.timingFunctions      = @[ [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut] ];
            animation.duration             = 0.35;
            animation.delegate             = self;
            [animation setValue:completion forKey:@"handler"];
            [self.containerView.layer addAnimation:animation forKey:@"bounce"];

            self.containerView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        } break;
        case XTSIAlertViewTransitionStyleDropDown: {
            CGPoint point = self.containerView.center;
            point.y += self.bounds.size.height;
            [UIView animateWithDuration:0.3
                delay:0
                options:UIViewAnimationOptionCurveEaseIn
                animations:^{
                    self.containerView.center    = point;
                    CGFloat angle                = ((CGFloat)arc4random_uniform(100) - 50.f) / 100.f;
                    self.containerView.transform = CGAffineTransformMakeRotation(angle);
                }
                completion:^(BOOL finished) {
                    if (completion) {
                        completion();
                    }
                }];
        } break;
        default:
            break;
    }
}

- (void)resetTransition {
    [self.containerView.layer removeAllAnimations];
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    [self validateLayout];
}

- (void)invaliadateLayout {
    self.layoutDirty = YES;
    [self setNeedsLayout];
}

- (void)validateLayout {
    if (!self.isLayoutDirty) {
        return;
    }
    self.layoutDirty = NO;
#if DEBUG_LAYOUT
    NSLog(@"%@, %@", self, NSStringFromSelector(_cmd));
#endif

    CGFloat height = [self preferredHeight];
    CGFloat left   = (self.bounds.size.width - CONTAINER_WIDTH) * 0.5;

    CGFloat top = 0.0;
    switch (self.positionStyle) {
        case XTSIAlertViewPositionMiddle: {
            top = (self.bounds.size.height - height) * 0.5;
        } break;
        case XTSIAlertViewPositionBottom: {
            top = self.bounds.size.height - height;
        } break;
        default:
            break;
    }

    self.containerView.transform = CGAffineTransformIdentity;
    self.containerView.frame     = CGRectMake(left, top, CONTAINER_WIDTH, height);

    if (self.positionStyle == XTSIAlertViewPositionBottom) {
        self.containerView.frame = CGRectMake(0, top - APP_SAFEAREA_TABBAR_FLEX, self.bounds.size.width, height);
    }

    CGFloat paddingLR = kMY_CONTENT_PADDING_LEFT;

    self.containerView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.containerView.bounds cornerRadius:self.containerView.layer.cornerRadius].CGPath;

    CGFloat y = CONTENT_PADDING_TOP;
    if (self.titleLabel) {
        self.titleLabel.text  = self.title;
        CGFloat height        = [self heightForTitleLabel];
        self.titleLabel.frame = CGRectMake(paddingLR, y, self.containerView.bounds.size.width - paddingLR * 2, height);
        y += height;
    }
    if (self.messageLabel) {
        if (y > CONTENT_PADDING_TOP) {
            y += GAP;
        }
        self.messageLabel.text  = self.message;
        CGFloat height          = [self heightForMessageLabel];
        self.messageLabel.frame = CGRectMake(paddingLR, y, self.containerView.bounds.size.width - paddingLR * 2, height);
        y += height;
    }
    if (self.items.count > 0) {
        if (y > CONTENT_PADDING_TOP) {
            y += GAP;
        }
        if (self.items.count == 2 && self.positionStyle == XTSIAlertViewPositionMiddle) {
            CGFloat width    = (self.containerView.bounds.size.width - paddingLR * 2 - GAP) * 0.5;
            UIButton *button = self.buttons[0];
            button.frame     = CGRectMake(paddingLR, y, width, BUTTON_HEIGHT);
            button           = self.buttons[1];
            button.frame     = CGRectMake(paddingLR + width + GAP, y, width, BUTTON_HEIGHT);
        }
        else {
            for (NSUInteger i = 0; i < self.buttons.count; i++) {
                UIButton *button = self.buttons[i];
                button.frame     = CGRectMake(paddingLR, y, self.containerView.bounds.size.width - paddingLR * 2, BUTTON_HEIGHT);
                if (self.buttons.count > 1) {
                    if (i == self.buttons.count - 1 && ((XTSIAlertItem *)self.items[i]).type == XTSIAlertViewButtonTypeCancel) {
                        CGRect rect = button.frame;
                        rect.origin.y += CANCEL_BUTTON_PADDING_TOP;
                        button.frame = rect;
                    }
                    y += BUTTON_HEIGHT + GAP;
                }
            }
        }
    }
}

- (CGFloat)preferredHeight {
    CGFloat height = CONTENT_PADDING_TOP;
    if (self.title) {
        height += [self heightForTitleLabel];
    }
    if (self.message) {
        if (height > CONTENT_PADDING_TOP) {
            height += GAP;
        }
        height += [self heightForMessageLabel];
    }
    if (self.items.count > 0) {
        if (height > CONTENT_PADDING_TOP) {
            height += GAP;
        }

        if (self.items.count <= 2 && self.positionStyle == 0) {
            height += BUTTON_HEIGHT;
        }
        else {
            height += (BUTTON_HEIGHT + GAP) * self.items.count - GAP;
            if (self.positionStyle == 1 && ((XTSIAlertItem *)[self.items lastObject]).type == XTSIAlertViewButtonTypeCancel) {
                height += CANCEL_BUTTON_PADDING_TOP;
            }
        }
    }

    height += CONTENT_PADDING_BOTTOM;
    return height;
}

- (CGFloat)heightForTitleLabel {
    if (self.titleLabel) {
        NSAttributedString *attributedText =
            [[NSAttributedString alloc] initWithString:self.title
                                            attributes:@{NSFontAttributeName : self.titleLabel.font}];
        CGRect rect = [attributedText boundingRectWithSize:(CGSize) { CONTAINER_WIDTH - kMY_CONTENT_PADDING_LEFT * 2, 200 }
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
        CGSize size = rect.size;
        return size.height;
    }
    return 0;
}

- (CGFloat)heightForMessageLabel {
    CGFloat minHeight = MESSAGE_MIN_LINE_COUNT * self.messageLabel.font.lineHeight;
    if (self.messageLabel) {
        NSAttributedString *attributedText =
            [[NSAttributedString alloc] initWithString:self.message
                                            attributes:@{NSFontAttributeName : self.messageLabel.font}];
        CGRect rect = [attributedText boundingRectWithSize:(CGSize) { CONTAINER_WIDTH - kMY_CONTENT_PADDING_LEFT * 2, 200 }
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
        CGSize size = rect.size;
        return MAX(minHeight, size.height);
    }
    return minHeight;
}

#pragma mark - Setup

- (void)setup {
    [self setupContainerView];
    [self updateTitleLabel];
    [self updateMessageLabel];
    [self setupButtons];
    [self invaliadateLayout];
}

- (void)teardown {
    [self.containerView removeFromSuperview];
    self.containerView = nil;
    self.titleLabel    = nil;
    self.messageLabel  = nil;
    [self.buttons removeAllObjects];
    [self.alertWindow removeFromSuperview];
    self.alertWindow = nil;
}

- (void)setupContainerView {
    self.containerView                     = [[UIView alloc] initWithFrame:self.bounds];
    self.containerView.backgroundColor     = [UIColor whiteColor];
    self.containerView.layer.cornerRadius  = self.cornerRadius;
    self.containerView.layer.shadowOffset  = CGSizeZero;
    self.containerView.layer.shadowRadius  = self.shadowRadius;
    self.containerView.layer.shadowOpacity = 0.5;
    [self addSubview:self.containerView];
}

- (void)updateTitleLabel {
    if (self.title) {
        if (!self.titleLabel) {
            self.titleLabel                           = [[UILabel alloc] initWithFrame:self.bounds];
            self.titleLabel.textAlignment             = NSTextAlignmentCenter;
            self.titleLabel.backgroundColor           = [UIColor clearColor];
            self.titleLabel.font                      = self.titleFont;
            self.titleLabel.textColor                 = self.titleColor;
            self.titleLabel.adjustsFontSizeToFitWidth = YES;
#ifndef __IPHONE_6_0
            self.titleLabel.minimumScaleFactor = 0.75;
#else
            self.titleLabel.minimumFontSize = self.titleLabel.font.pointSize * 0.75;
#endif
            [self.containerView addSubview:self.titleLabel];
#if DEBUG_LAYOUT
            self.titleLabel.backgroundColor = [UIColor redColor];
#endif
        }
        self.titleLabel.text = self.title;
    }
    else {
        [self.titleLabel removeFromSuperview];
        self.titleLabel = nil;
    }
    [self invaliadateLayout];
}

- (void)updateMessageLabel {
    if (self.message) {
        if (!self.messageLabel) {
            self.messageLabel                 = [[UILabel alloc] initWithFrame:self.bounds];
            self.messageLabel.textAlignment   = NSTextAlignmentCenter;
            self.messageLabel.backgroundColor = [UIColor clearColor];
            self.messageLabel.font            = self.messageFont;
            self.messageLabel.textColor       = self.messageColor;
            self.messageLabel.numberOfLines   = MESSAGE_MAX_LINE_COUNT;
            [self.containerView addSubview:self.messageLabel];
#if DEBUG_LAYOUT
            self.messageLabel.backgroundColor = [UIColor redColor];
#endif
        }
        self.messageLabel.text = self.message;
    }
    else {
        [self.messageLabel removeFromSuperview];
        self.messageLabel = nil;
    }
    [self invaliadateLayout];
}

- (void)setupButtons {
    self.buttons = [[NSMutableArray alloc] initWithCapacity:self.items.count];
    for (NSUInteger i = 0; i < self.items.count; i++) {
        UIButton *button = [self buttonForItemIndex:i];
        [self.buttons addObject:button];
        [self.containerView addSubview:button];
    }
}

- (UIButton *)buttonForItemIndex:(NSUInteger)index {
    XTSIAlertItem *item     = self.items[index];
    UIButton *button        = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag              = index;
    button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    button.titleLabel.font  = self.buttonFont;
    [button setTitle:item.title forState:UIControlStateNormal];
    //    UIImage *normalImage = nil;
    //    UIImage *highlightedImage = nil;
    UIColor *color;

    switch (item.type) {
        case XTSIAlertViewButtonTypeCancel:
            //            normalImage = [UIImage imageNamed:@"XTSIAlertView.bundle/button-cancel"];
            //            highlightedImage = [UIImage imageNamed:@"XTSIAlertView.bundle/button-cancel-d"];
            color = kColorCancelBt;
            [button setTitleColor:kTitleColorCancelBt forState:UIControlStateNormal];
            [button setTitleColor:kHIGHLIGHT_TitleColorCancelBt forState:UIControlStateHighlighted];
            break;
        case XTSIAlertViewButtonTypeDestructive:
            //            normalImage = [UIImage imageNamed:@"XTSIAlertView.bundle/button-destructive"];
            //            highlightedImage = [UIImage imageNamed:@"XTSIAlertView.bundle/button-destructive-d"];
            color = kColorDestructiveBt;
            [button setTitleColor:kTitleColorDestructiveBt forState:UIControlStateNormal];
            [button setTitleColor:kHIGHLIGHT_TitleColorDestructiveBt forState:UIControlStateHighlighted];
            break;
        case XTSIAlertViewButtonTypeDefault:
        default:
            //            normalImage = [UIImage imageNamed:@"XTSIAlertView.bundle/button-default"];
            //            highlightedImage = [UIImage imageNamed:@"XTSIAlertView.bundle/button-default-d"];
            color = kColorDefaultBt;
            [button setTitleColor:kTitleColorDefaultBt forState:UIControlStateNormal];
            [button setTitleColor:kHIGHLIGHT_TitleColorDefaultBt forState:UIControlStateHighlighted];
            break;
    }

    [button setBackgroundColor:color];
    [button.layer setCornerRadius:2.0f];

    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

    return button;
}

#pragma mark - Actions

- (void)buttonAction:(UIButton *)button {
    [XTSIAlertView setAnimating:YES]; // set this flag to YES in order to prevent showing another alert in action block
    XTSIAlertItem *item = self.items[button.tag];
    if (item.action) {
        item.action(self);
    }
    [self dismissAnimated:YES];
}

#pragma mark - CAAnimation delegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    void (^completion)(void) = [anim valueForKey:@"handler"];
    if (completion) {
        completion();
    }
}

#pragma mark - UIAppearance setters

- (void)setViewBackgroundColor:(UIColor *)viewBackgroundColor {
    if (_viewBackgroundColor == viewBackgroundColor) {
        return;
    }
    _viewBackgroundColor               = viewBackgroundColor;
    self.containerView.backgroundColor = viewBackgroundColor;
}

- (void)setTitleFont:(UIFont *)titleFont {
    if (_titleFont == titleFont) {
        return;
    }
    _titleFont           = titleFont;
    self.titleLabel.font = titleFont;
    [self invaliadateLayout];
}

- (void)setMessageFont:(UIFont *)messageFont {
    if (_messageFont == messageFont) {
        return;
    }
    _messageFont           = messageFont;
    self.messageLabel.font = messageFont;
    [self invaliadateLayout];
}

- (void)setTitleColor:(UIColor *)titleColor {
    if (_titleColor == titleColor) {
        return;
    }
    _titleColor               = titleColor;
    self.titleLabel.textColor = titleColor;
}

- (void)setMessageColor:(UIColor *)messageColor {
    if (_messageColor == messageColor) {
        return;
    }
    _messageColor               = messageColor;
    self.messageLabel.textColor = messageColor;
}

- (void)setButtonFont:(UIFont *)buttonFont {
    if (_buttonFont == buttonFont) {
        return;
    }
    _buttonFont = buttonFont;
    for (UIButton *button in self.buttons) {
        button.titleLabel.font = buttonFont;
    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    if (_cornerRadius == cornerRadius) {
        return;
    }
    _cornerRadius                         = cornerRadius;
    self.containerView.layer.cornerRadius = cornerRadius;
}

- (void)setShadowRadius:(CGFloat)shadowRadius {
    if (_shadowRadius == shadowRadius) {
        return;
    }
    _shadowRadius                         = shadowRadius;
    self.containerView.layer.shadowRadius = shadowRadius;
}

@end
