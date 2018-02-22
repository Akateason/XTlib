//
//  CtrllerEvent.h
//  PatchBoard
//
//  Created by teason23 on 2017/7/6.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "XTDBModel.h"

@class UIViewController ;

@interface CtrllerEvent : XTDBModel
@property (nonatomic,copy)      NSString     *UUID          ;
@property (nonatomic,copy)      NSString     *kindOfKey     ;

@property (nonatomic,copy)      NSString     *name          ; // class name
@property (nonatomic,copy)      NSString     *title         ; // nav title
@property (nonatomic,copy)      NSString     *action        ; // viewDidLoad,viewWillAppear,viewWillDisappear,dealloc

@property (nonatomic)           long long    time           ; // occur time
@property (nonatomic,copy)      NSString     *dateStr       ; // occut time str
@property (nonatomic,copy)      NSString     *tree          ; // tree
@property (nonatomic)           int          uploaded       ; // default 0 not upload

- (instancetype)initWithName:(NSString *)name
                       title:(NSString *)title
                      action:(NSString *)action
                     ctrller:(UIViewController *)ctrller ;

@end
