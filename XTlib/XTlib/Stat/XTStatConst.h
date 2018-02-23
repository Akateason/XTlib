//
//  XTStatConst.h
//  XTkit
//
//  Created by teason23 on 2017/7/24.
//  Copyright © 2017年 teason. All rights reserved.
//

#ifndef XTStatConst_h
#define XTStatConst_h

#define xtstat_DEBUG    1
#if xtstat_DEBUG
#   define XTSTATLog(...)           NSLog(__VA_ARGS__)
#else
#   define XTSTATLog(...)
#endif

#define xt_Run_Stat    0


#endif /* XTStatConst_h */
