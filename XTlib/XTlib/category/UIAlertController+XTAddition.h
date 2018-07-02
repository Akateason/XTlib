//
//  UIAlertController+XTAddition.h
//  XTlib
//
//  Created by teason23 on 2018/7/2.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (XTAddition)

+ (void)showAlertCntrollerWithViewController:(UIViewController *)viewController
                        alertControllerStyle:(UIAlertControllerStyle)alertControllerStyle
                                       title:(NSString *)title
                                     message:(NSString *)message
                           otherButtonTitles:(NSArray<NSString *> *)otherBtnTitles
                           cancelButtonTitle:(NSString *)cancelBtnTitle
                      destructiveButtonTitle:(NSString *)destructiveBtnTitle
                               CallBackBlock:(void(^)(NSInteger btnIndex))block ;

+ (void)showAlertCntrollerWithStyle:(UIAlertControllerStyle)alertControllerStyle
                              title:(NSString *)title
                            message:(NSString *)message
                  otherButtonTitles:(NSArray<NSString *> *)otherBtnTitles
                  cancelButtonTitle:(NSString *)cancelBtnTitle
             destructiveButtonTitle:(NSString *)destructiveBtnTitle
                      CallBackBlock:(void(^)(NSInteger btnIndex))block ;

@end
