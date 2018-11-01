//
//  XTlibConst.h
//  XTlib
//
//  Created by teason23 on 2018/10/18.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "XTlibConfig.h"

#ifndef XTlibConst_h
#define XTlibConst_h

#define NSLog(format, ...)                                                                                                                    \
    if ([XTlibConfig sharedInstance].isDebug) {                                                                                               \
        do {                                                                                                                                  \
            fprintf(stderr, "\n<---🏀🏀🏀🏀🏀\n");                                                                                                 \
            fprintf(stderr, "<%s : %d> %s\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __func__); \
            (NSLog)((format), ##__VA_ARGS__);                                                                                                 \
            fprintf(stderr, "🏀🏀🏀🏀🏀--->\n\n");                                                                                                 \
        } while (0);                                                                                                                          \
    }                                                                                                                                         \
    else {                                                                                                                                    \
        (NSLog)((format), ##__VA_ARGS__);                                                                                                     \
    }


#endif /* XTlibConst_h */
