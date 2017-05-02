//
//  UILabel+Badges.h
//  SuBaoJiang
//
//  Created by apple on 15/6/17.
//  Copyright (c) 2015年 teason. All rights reserved.
//


//    UIButton *customButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    [customButton addTarget:self action:@selector(showMyOrderView:) forControlEvents:UIControlEventTouchUpInside];
//    [customButton setImage:[UIImage imageNamed:@"ico-to-do-list"] forState:UIControlStateNormal];
//    BBBadgeBarButtonItem *barButton = [[BBBadgeBarButtonItem alloc] initWithCustomUIButton:customButton];
//    // Set a value for the badge
//    barButton.badgeOriginX = 13;
//    barButton.badgeOriginY = -9;
//    barButton.shouldHideBadgeAtZero = YES;//0则不显
//    self.navigationItem.leftBarButtonItem = barButton;



#import <UIKit/UIKit.h>

@interface UILabel (Badges)

@property (strong, nonatomic) UILabel *badge;

// Badge value to be display
@property (nonatomic) NSString *badgeValue;
// Badge background color
@property (nonatomic) UIColor *badgeBGColor;
// Badge text color
@property (nonatomic) UIColor *badgeTextColor;
// Badge font
@property (nonatomic) UIFont *badgeFont;
// Padding value for the badge
@property (nonatomic) CGFloat badgePadding;
// Minimum size badge to small
@property (nonatomic) CGFloat badgeMinSize;
// Values for offseting the badge over the BarButtonItem you picked
@property (nonatomic) CGFloat badgeOriginX;
@property (nonatomic) CGFloat badgeOriginY;
// In case of numbers, remove the badge when reaching zero
@property BOOL shouldHideBadgeAtZero;
// Badge has a bounce animation when value changes
@property BOOL shouldAnimateBadge;


@end
