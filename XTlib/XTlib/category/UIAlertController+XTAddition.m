//
//  UIAlertController+XTAddition.m
//  XTlib
//
//  Created by teason23 on 2018/7/2.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "UIAlertController+XTAddition.h"
#import "AppDelegate.h"

@implementation UIAlertController (XTAddition)

+ (void)showAlertCntrollerWithViewController:(UIViewController *)viewController
                        alertControllerStyle:(UIAlertControllerStyle)alertControllerStyle
                                       title:(NSString *)title
                                     message:(NSString *)message
                           otherButtonTitles:(NSArray<NSString *> *)otherBtnTitles
                           cancelButtonTitle:(NSString *)cancelBtnTitle
                      destructiveButtonTitle:(NSString *)destructiveBtnTitle
                               CallBackBlock:(void(^)(NSInteger btnIndex))block
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:alertControllerStyle];
    
    if (cancelBtnTitle.length) {
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            block(0);
        }];
        [alertController addAction:cancelAction];
    }
    if (destructiveBtnTitle.length) {
        UIAlertAction * destructiveAction = [UIAlertAction actionWithTitle:destructiveBtnTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            block(1);
        }];
        [alertController addAction:destructiveAction];
    }
    if (otherBtnTitles.count) {
        [otherBtnTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull otherTitleStr, NSUInteger idx, BOOL * _Nonnull stop) {
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:otherTitleStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                block(2+idx) ;
            }];
            [alertController addAction:cancelAction];
        }] ;
    }
    [viewController presentViewController:alertController animated:YES completion:nil];
}

+ (void)showAlertCntrollerWithStyle:(UIAlertControllerStyle)alertControllerStyle
                              title:(NSString *)title
                            message:(NSString *)message
                  otherButtonTitles:(NSArray<NSString *> *)otherBtnTitles
                  cancelButtonTitle:(NSString *)cancelBtnTitle
             destructiveButtonTitle:(NSString *)destructiveBtnTitle
                      CallBackBlock:(void(^)(NSInteger btnIndex))block ;
{
    AppDelegate *aDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate ;
    [self showAlertCntrollerWithViewController:aDelegate.window.rootViewController alertControllerStyle:alertControllerStyle title:title message:message otherButtonTitles:otherBtnTitles cancelButtonTitle:cancelBtnTitle destructiveButtonTitle:destructiveBtnTitle CallBackBlock:block] ;
}

@end
