//
//  UIAlertController+XTAddition.h
//  XTlib
//
//  Created by teason23 on 2018/7/2.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (XTAddition)

+ (void)xt_showAlertCntrollerWithAlertControllerStyle:(UIAlertControllerStyle)alertControllerStyle
                                                title:(NSString *)title
                                              message:(NSString *)message
                                    cancelButtonTitle:(NSString *)cancelBtnTitle
                               destructiveButtonTitle:(NSString *)destructiveBtnTitle
                                    otherButtonTitles:(NSArray<NSString *> *)otherBtnTitles
                                        callBackBlock:(void(^)(NSInteger btnIndex))block ;

+ (void)xt_showTextFieldAlertWithTitle:(NSString *)title
                              subtitle:(NSString *)subTitle
                                cancel:(NSString *)cancelStr
                                commit:(NSString *)commitStr
                           placeHolder:(NSString *)placeHolderStr
                              callback:(void(^)(NSString *text))textBlock ;
@end
