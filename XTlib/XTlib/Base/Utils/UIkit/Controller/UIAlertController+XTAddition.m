//
//  UIAlertController+XTAddition.m
//  XTlib
//
//  Created by teason23 on 2018/7/2.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "UIAlertController+XTAddition.h"

@implementation UIAlertController (XTAddition)

+ (void)showAlertCntrollerWithViewController:(UIViewController *)viewController
                        alertControllerStyle:(UIAlertControllerStyle)alertControllerStyle
                                       title:(NSString *)title
                                     message:(NSString *)message
                           cancelButtonTitle:(NSString *)cancelBtnTitle
                      destructiveButtonTitle:(NSString *)destructiveBtnTitle
                           otherButtonTitles:(NSArray<NSString *> *)otherBtnTitles
                               CallBackBlock:(void(^)(NSInteger btnIndex))block {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:alertControllerStyle] ;
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
        int oldIdx = (cancelBtnTitle != nil) + (destructiveBtnTitle != nil) ;
        [otherBtnTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull otherTitleStr, NSUInteger idx, BOOL * _Nonnull stop) {
            UIAlertAction * otherAction = [UIAlertAction actionWithTitle:otherTitleStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                block(oldIdx + idx) ;
            }];
            [alertController addAction:otherAction] ;
        }] ;
    }
    [viewController presentViewController:alertController animated:YES completion:nil];
}


+ (void)showAlertCntrollerWithAlertControllerStyle:(UIAlertControllerStyle)alertControllerStyle
                                             title:(NSString *)title
                                           message:(NSString *)message
                                 cancelButtonTitle:(NSString *)cancelBtnTitle
                            destructiveButtonTitle:(NSString *)destructiveBtnTitle
                                 otherButtonTitles:(NSArray<NSString *> *)otherBtnTitles
                                     CallBackBlock:(void(^)(NSInteger btnIndex))block {
    
//    ((AppDelegate *)appDelegate).window.rootViewController
    id appDelegate = [UIApplication sharedApplication].delegate ;
    UIViewController *rootCtrller = [appDelegate valueForKeyPath:@"window.rootViewController"] ;
    [self showAlertCntrollerWithViewController:rootCtrller alertControllerStyle:alertControllerStyle title:title message:message cancelButtonTitle:cancelBtnTitle destructiveButtonTitle:destructiveBtnTitle otherButtonTitles:otherBtnTitles CallBackBlock:block] ;
}


@end
