//
//  CommonFunc.h
//  SuBaoJiang
//
//  Created by apple on 15/6/18.
//  Copyright (c) 2015年 teason. All rights reserved.
//

// 绑定 模式
typedef enum {
    mode_none       = 0 ,
    mode_weibo      = 1 ,
    mode_weixin
} MODE_bind ;

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface CommonFunc : NSObject

#pragma mark - save images to library
+ (void)saveImageToLibrary:(UIImage *)savedImage
                 albumName:(NSString *)name ;

#pragma mark - water mask SubaoJiang
+ (UIImage *)getSuBaoJiangWaterMask:(UIImage *)orgImage ;

#pragma mark - sandbox
+ (NSString *)getSandBoxPath ;

#pragma mark - current app version
+ (NSString *)getVersionStrOfMyAPP ;

#pragma mark --
#pragma mark - update the latest version if neccessary .
+ (void)updateLatestVersion ;

#pragma mark - give app a Score
+ (void)scoringMyApp ;

#pragma mark - bind
// bind save
+ (void)bindWithBindMode:(MODE_bind)bindMode ;

// bind get , Default is @0, bind nothing .
+ (NSNumber *)getBindMode ;

#pragma mark --
#pragma mark - CLLocation  get current location
//拿 当前 经纬度 位置
+ (CLLocationCoordinate2D)getLocation ;

#pragma mark - 男女切换  0无, 1 男 , 2 女
//男女切换
+ (NSString *)boyGirlNum2Str:(int)num ;
+ (int)boyGirlStr2Num:(NSString *)str ;

#pragma mark --
#pragma mark - 关闭应用
+ (void)shutDownAppWithCtrller:(UIViewController *)ctrller ;




@end
