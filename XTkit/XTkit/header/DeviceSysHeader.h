//
//  DeviceSysHeader.h
//  XTkit
//
//  Created by teason on 2017/4/19.
//  Copyright © 2017年 teason. All rights reserved.
//

#ifndef DeviceSysHeader_h
#define DeviceSysHeader_h



//  SCALE
#define WIDTH_SCALE            [CommonFunc getScreenWidthscale]
#define HEIGHT_SCALE           [CommonFunc getScreenHightscale]

/*
 * >= VERSION ?
 * X -> float
 */
#define IS_IOS_VERSION(FLOAT_X)         ([[[UIDevice currentDevice] systemVersion] floatValue] >= FLOAT_X)

/*
 * < VERSION
 * X -> float
 */
#define UNDER_IOS_VERSION(FLOAT_X)      ([[[UIDevice currentDevice] systemVersion] floatValue] < FLOAT_X)

/*
 * > iPhone5
 */
#define DEVICE_IS_IPHONE5               ([[UIScreen mainScreen] bounds].size.height >= 568)



#define iphone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iphone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iphone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define iphone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)







#endif /* DeviceSysHeader_h */
