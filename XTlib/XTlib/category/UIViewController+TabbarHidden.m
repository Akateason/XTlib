//
//  UIViewController+TabbarHidden.m
//  XTkit
//
//  Created by teason on 2017/4/24.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "UIViewController+TabbarHidden.h"
#import "ScreenHeader.h"

@implementation UIViewController (TabbarHidden)


- (void)makeTabBarHidden:(BOOL)hide
{
    [self makeTabBarHidden:hide animated:NO] ;
}

- (void)makeTabBarHidden:(BOOL)hide animated:(BOOL)animated
{
    if ( [self.tabBarController.view.subviews count] < 2 ) return ;
    self.tabBarController.tabBar.hidden = hide ;
    UIView *contentView ;
    if ( [[self.tabBarController.view.subviews firstObject] isKindOfClass:[UITabBar class]] )
    {
        contentView = [self.tabBarController.view.subviews objectAtIndex:1] ;
    }
    else
    {
        contentView = [self.tabBarController.view.subviews firstObject] ;
    }
    CGRect newFrame ;
    if ( hide )
    {
        newFrame = APPFRAME ;
    }
    else
    {
        newFrame = CGRectMake(APPFRAME.origin.x,
                              APPFRAME.origin.y,
                              APP_WIDTH,
                              APP_HEIGHT - APP_TABBAR_HEIGHT) ;
    }
    if (animated)
    {
        [UIView animateWithDuration:0.35f animations:^{
            contentView.frame = newFrame ;
        }] ;
    }
    else
    {
        contentView.frame = newFrame ;
    }
}



@end
