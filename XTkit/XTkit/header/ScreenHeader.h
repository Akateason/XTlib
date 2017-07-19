//
//  ScreenHeader.h
//  XTkit
//
//  Created by teason on 2017/4/19.
//  Copyright © 2017年 teason. All rights reserved.





#ifndef ScreenHeader_h
#define ScreenHeader_h

#import "ScreenFit.h"

#define APPFRAME                        [UIScreen mainScreen].bounds
#define APP_WIDTH                       CGRectGetWidth(APPFRAME)
#define APP_HEIGHT                      CGRectGetHeight(APPFRAME)
#define APP_NAVIGATIONBAR_HEIGHT        44.0f
#define APP_STATUSBAR_HEIGHT            20.0f
#define APP_TABBAR_HEIGHT               49.0f
#define ONE_PIXEL_VALUE                 0.5f


#define CORNER_RADIUS_ALL               6.0f

#define UIColorRGBA(r, g, b, a)         [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define Font(F)                         [UIFont systemFontOfSize:(F)]
#define boldFont(F)                     [UIFont boldSystemFontOfSize:(F)]

#define rateH                           [[ScreenFit sharedInstance] getScreenHeightscale]
#define rateW                           [[ScreenFit sharedInstance] getScreenWidthscale]


#endif /* ScreenHeader_h */



