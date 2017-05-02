//
//  RootCtrl.h
//  Teason
//
//  Created by ; on 14-8-21.
//  Copyright (c) 2014年 TEASON. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ScreenHeader.h"
#import "DeviceSysHeader.h"

#import "Masonry.h"
#import "YYModel.h"
#import "SVProgressHUD.h"

#import "ShareDigit.h"
#import "ServerRequest.h"
#import "RootTableView.h"
#import "XTNetReloader.h"
#import "XTAnimation.h"


@interface RootCtrl : UIViewController

#pragma mark - load from storyboard
+ (RootCtrl *)getCtrllerFromStory:(NSString *)storyboard
             controllerIdentifier:(NSString *)identifier ;

#pragma mark - title for Umeng Anaylize .
@property (nonatomic,copy) NSString *myTitle ;

#pragma mark - Set No Back BarButton
- (void)deleteAllNavigationBarButtons:(BOOL)isDel ; //  IF YES , delete all bar buttons

#pragma mark - click back button in NavgationBar
- (void)navigationBackButtonOnClick ;

@end






