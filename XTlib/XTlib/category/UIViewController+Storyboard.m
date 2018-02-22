//
//  UIViewController+Storyboard.m
//  XTkit
//
//  Created by teason23 on 2017/5/3.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "UIViewController+Storyboard.h"

@implementation UIViewController (Storyboard)

#pragma mark --
#pragma mark - load from storyboard
+ (UIViewController *)getCtrllerFromStory:(NSString *)storyboard
                     controllerIdentifier:(NSString *)identifier
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:storyboard bundle:nil] ;
    UIViewController *ctrller = [story instantiateViewControllerWithIdentifier:identifier] ;
    return ctrller ;
}


@end
