//
//  CommonFunc.h
//  SuBaoJiang
//
//  Created by apple on 15/6/18.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface CommonFunc : NSObject

#pragma mark - save images to library

+ (void)saveImageToLibrary:(UIImage *)savedImage
                 albumName:(NSString *)name;

#pragma mark - water mask SubaoJiang

+ (UIImage *)getSuBaoJiangWaterMask:(UIImage *)orgImage;

#pragma mark - current appname / version

+ (NSString *)getAppName;

+ (NSString *)getVersionStrOfMyAPP;

#pragma mark - update the latest version if neccessary .

//+ (void)updateLatestVersion ;

#pragma mark - give app a Score

+ (void)scoringMyAppWithAppStoreID:(NSString *)appstoreID;

#pragma mark - CLLocation  get current location

+ (CLLocationCoordinate2D)getLocation;

#pragma mark - 关闭应用

+ (void)shutDownAppWithCtrller:(UIViewController *)ctrller;

#pragma mark - 设备名
- (NSString *)getDeviceName;

@end
