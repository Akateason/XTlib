//
//  UIViewController+Storyboard.h
//  XTkit
//
//  Created by teason23 on 2017/5/3.
//  Copyright © 2017年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Storyboard)

#pragma mark - load from storyboard
+ (UIViewController *)getCtrllerFromStory:(NSString *)storyboard
                     controllerIdentifier:(NSString *)identifier ;
@end
