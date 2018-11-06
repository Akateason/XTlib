//
//  RootCtrl.h
//  Teason
//
//  Created by ; on 14-8-21.
//  Copyright (c) 2014年 TEASON. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Masonry/Masonry.h>
#import <YYModel/YYModel.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <ReactiveObjC/ReactiveObjC.h>


@interface RootCtrl : UIViewController

@property (copy, nonatomic) NSString *myStatTitle; // title for stat if needed.

- (void)prepare;
- (void)prepareUI;

@end
