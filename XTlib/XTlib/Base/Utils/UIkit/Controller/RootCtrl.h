//
//  RootCtrl.h
//  Teason
//
//  Created by ; on 14-8-21.
//  Copyright (c) 2014年 TEASON. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Masonry.h"
#import "YYModel.h"
#import "SVProgressHUD.h"
#import "XTlib.h"
#import <ReactiveObjC/ReactiveObjC.h>


@interface RootCtrl : UIViewController

@property (copy, nonatomic) NSString *myStatTitle ; // title for stat if needed.

- (void)prepare ;
- (void)prepareUI ;

@end
