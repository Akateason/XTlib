//
//  DeviceSysHeader.h
//  XTkit
//
//  Created by teason on 2017/4/19.
//  Copyright © 2017年 teason. All rights reserved.
//

#ifndef DeviceSysHeader_h
#define DeviceSysHeader_h

/*
 * is iphone
 * ios 11
 * iphone X
 */
#define XT_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define XT_IS_IOS_11 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.f)

#define XT_IS_IPHONE_X (XT_IS_IOS_11 && XT_IS_IPHONE && (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) == 375 && MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) == 812))

/*
 * >= VERSION ?
 * X -> float
 */
#define IS_IOS_VERSION(FLOAT_X) ([[[UIDevice currentDevice] systemVersion] floatValue] >= FLOAT_X)

/*
 * < VERSION
 * X -> float
 */
#define UNDER_IOS_VERSION(FLOAT_X) ([[[UIDevice currentDevice] systemVersion] floatValue] < FLOAT_X)

/*
 * > iPhone5
 */
#define DEVICE_IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height >= 568)


/**
 * iphone device type
 */
#undef iphone4
#define iphone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#undef iphone5
#define iphone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#undef iphone6
#define iphone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#undef iphone6plus
#define iphone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)


#endif /* DeviceSysHeader_h */
