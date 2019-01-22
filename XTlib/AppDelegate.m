//
//  AppDelegate.m
//  XTlib
//
//  Created by teason23 on 2018/2/22.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "AppDelegate.h"
#import "Model1.h"
#import "XTlib.h"
#import <SVProgressHUD/SVProgressHUD.h>


@interface AppDelegate ()

@end


@implementation AppDelegate

- (void)navStyle {
    //    UIImage *backButtonBackgroundImage = [UIImage imageNamed:@"backArrowBlack"] ;
    //    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[GBNavigationViewController class]]];
    //    [navigationBar setBackIndicatorImage:backButtonBackgroundImage] ;
    //    [navigationBar setBackIndicatorTransitionMaskImage:backButtonBackgroundImage] ;
    //
    //    UIBarButtonItem *buttonItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UINavigationBar class]]] ;
    //    UIOffset offset ;
    //    offset.vertical = -.5 ;
    //    [buttonItem setBackButtonTitlePositionAdjustment:offset forBarMetrics:UIBarMetricsDefault] ;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [XTlibConfig sharedInstance].isDebug = YES;

    NSLog(@"525252343") ;
    
    UIColorHex(@"332211") ;
    UIColorRGB(65, 70, 75) ;
    UIColorRGBA(65, 70, 75,.35) ;
    
    // nav
    [self navStyle];

    // SVPHUD style
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear]; //set mask to block usersTaps
    [SVProgressHUD setMaximumDismissTimeInterval:2.];

    // SQLite
    [XTFMDBBase sharedInstance].isDebugMode = YES;
    NSString *path                          = XT_DOCUMENTS_PATH_TRAIL_(@"teason");
    [[XTFMDBBase sharedInstance] configureDBWithPath:path];
    [[XTFMDBBase sharedInstance] dbUpgradeTable:Model1.class
                                      paramsAdd:@[ @"a1", @"a2", @"a3" ]
                                        version:2];

    [[XTFMDBBase sharedInstance] dbUpgradeTable:Model1.class
                                      paramsAdd:@[ @"b1", @"b2", @"b3" ]
                                        version:3];


    // request cache TB
    [XTReqSessionManager shareInstance].isDebug = YES;
    [XTCacheRequest configXTCacheReqWhenAppDidLaunchWithDBPath:path];

    // stat
    //    [[XTStat new] prepare] ;

    //
    [self testFunc];

    return YES;
}

- (void)testFunc {
    //    NSString *str = [[ValetManager sharedInstance] getPwdWithUname:@"xtc"] ;
    //    [[ValetManager sharedInstance] setup] ;
    //    [[ValetManager sharedInstance] saveUserName:@"xtc" pwd:@"324234daaa"] ;
    //    [[ValetManager sharedInstance] UUID] ;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
