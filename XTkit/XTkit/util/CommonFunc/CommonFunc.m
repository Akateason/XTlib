//
//  CommonFunc.m
//  SuBaoJiang
//
//  Created by apple on 15/6/18.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import "CommonFunc.h"
#import "ScreenHeader.h"
#import "DeviceSysHeader.h"
#import "ShareDigit.h"
//#import "ServerRequest.h"
#import "SDImageCache.h"
#import "XTFileManager.h"
//#import "SIAlertView.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "UIImage+AddFunction.h"
#import "NotificationCenterHeader.h"

#define SCORE_STR_LOW       @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@"
#define SCORE_STR_HIGH      @"itms-apps://itunes.apple.com/app/id%@"

NSString *const PATH_TOKEN_SAVE         = @"Documents/tokenArchive.archive" ;
NSString *const PATH_BIND_SAVE          = @"Documents/bindArchive.archive" ;
NSString *const URL_QINIU_HEAD          = @"http://img.subaojiang.com/" ;

extern NSString * APPSTORE_APPID ;


@implementation CommonFunc

#pragma mark -- save images to library
+ (void)saveImageToLibrary:(UIImage *)savedImage albumName:(NSString *)name {
    __block UIImage *imgSave = savedImage ;
    
    dispatch_queue_t queue = dispatch_queue_create("pictureSaveInAlbum", NULL) ;
    dispatch_async(queue, ^{
        imgSave = [self getSuBaoJiangWaterMask:imgSave] ;
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init] ;
        [library saveImage:imgSave
                   toAlbum:name
           completionBlock:^(NSError *error) {
               if (!error) {
                   dispatch_async(dispatch_get_main_queue(), ^{
    //                   [XTHudManager showWordHudWithTitle:WD_HUD_PIC_SAVE_SUCCESS] ;
                   }) ;
               }
       }] ;
        
    }) ;

}

+ (UIImage *)getSuBaoJiangWaterMask:(UIImage *)orgImage {
    orgImage = [orgImage imageCompressWithTargetWidth:640] ;

    CGRect rect = CGRectMake(18, orgImage.size.height - 66 - 8, 44, 66) ;
    orgImage = [orgImage imageWithWaterMask:[UIImage imageNamed:@"waterMask"] inRect:rect] ;
    
    return orgImage ;
}


#pragma mark -- sandbox
+ (NSString *)getDocumentsPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] ;
}

+ (NSString *)getLibraryPath {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject] ;
}

#pragma mark -- version
+ (NSString *)getVersionStrOfMyAPP {
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]  ;
    NSLog(@"version : %@",version) ;
    return version ;
}

+ (NSString *)getAppName {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary] ;
    return [infoDictionary objectForKey:@"CFBundleDisplayName"] ;
}

#pragma mark --
#pragma mark - 自动更新版本
+ (void)updateLatestVersion {
//    if (!G_BOOL_OPEN_APPSTORE) return ;
    
    dispatch_queue_t queue = dispatch_queue_create("versionQueue", NULL) ;
    dispatch_async(queue, ^{
        [self checkVersionRequest] ;
    }) ;
}

+ (void)checkVersionRequest {
    NSString *versionString = [self getVersionStrOfMyAPP] ;
    
    NSString *strUrl = @"http://itunes.apple.com/lookup?id=999705868";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:strUrl]];
    [request setHTTPMethod:@"POST"];
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSString *results = [[NSString alloc] initWithBytes:[recervedData bytes] length:[recervedData length] encoding:NSUTF8StringEncoding];
//    NSLog(@"app : %@",results) ;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[results dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil] ;
    
    NSArray *infoArray = [dic objectForKey:@"results"];
    if ([infoArray count])
    {
        NSDictionary *releaseInfo = [infoArray firstObject];
        NSString *lastVersion = [releaseInfo objectForKey:@"version"];
        
        BOOL bNeedUpdate = ([versionString compare:lastVersion] == NSOrderedAscending) ;
        
        if ( bNeedUpdate )
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *updateUrl = [releaseInfo objectForKey:@"trackViewUrl"] ;
                NSString *releaseNotes = [releaseInfo objectForKey:@"releaseNotes"] ;
                
                /*
                SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"速报酱有新版本"
                                                                 andMessage:releaseNotes] ;
                
                [alertView addButtonWithTitle:@"不去"
                                         type:SIAlertViewButtonTypeDefault
                                      handler:^(SIAlertView *alertView) {
                                      }] ;
                [alertView addButtonWithTitle:@"去更新了"
                                         type:SIAlertViewButtonTypeDestructive
                                      handler:^(SIAlertView *alertView) {
                                          NSURL *url = [NSURL URLWithString:updateUrl];
                                          [[UIApplication sharedApplication]openURL:url];
                                      }] ;
                [alertView show] ;
                */
            }) ;
        }
        else
        {
            NSLog(@"此版本为最新版本") ;
        }
    }
}

#pragma mark - give app a Score
+ (void)scoringMyApp {
//    NSString *str = IS_IOS_VERSION(7.0) ? [NSString stringWithFormat:SCORE_STR_HIGH,APPSTORE_APPID] : [NSString stringWithFormat:SCORE_STR_LOW,APPSTORE_APPID] ;
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}


#pragma mark --
#pragma mark - CLLocation  get current location
+ (CLLocationCoordinate2D)getLocation {
    CLLocationManager *lm = [[CLLocationManager alloc] init];
    [lm setDesiredAccuracy:kCLLocationAccuracyBest];
    lm.distanceFilter = 1000.0f;
    [lm startUpdatingLocation];
    
    CLLocationCoordinate2D orgCoordinate ;
    orgCoordinate.longitude = lm.location.coordinate.longitude;
    orgCoordinate.latitude = lm.location.coordinate.latitude;
    [lm stopUpdatingLocation];
    
    return orgCoordinate;
}

#pragma mark -- 关闭应用
+ (void)shutDownAppWithCtrller:(UIViewController *)ctrller {
    [UIView animateWithDuration:0.65f animations:^{
        ctrller.view.window.alpha = 0;
        ctrller.view.window.frame = CGRectMake(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

@end






