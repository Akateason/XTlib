//
//  FastCodeHeader.h
//  XTkit
//
//  Created by teason on 2017/4/19.
//  Copyright © 2017年 teason. All rights reserved.
//

#ifndef FastCodeHeader_h
#define FastCodeHeader_h
//
//// WEAK STRONG SELF
#define WEAK_SELF       __weak typeof(self) weakSelf = self
#define STRONG_SELF     __strong typeof(weakSelf) self = weakSelf
//


// SINGLETON
// .h
#undef AS_SINGLETON
#define AS_SINGLETON(__class)                                               \
+(__class *)sharedInstance;

// .m
#undef DEF_SINGLETON
#define DEF_SINGLETON(__class)                                              \
+(__class *)sharedInstance                                                  \
{                                                                           \
static dispatch_once_t once;                                                \
static __class *__singleton__;                                              \
dispatch_once(&once, ^{ __singleton__ = [[__class alloc] init]; });         \
return __singleton__;                                                       \
}


// string format
#define STR_FORMAT(format, ...)         [NSString stringWithFormat:(format), ##__VA_ARGS__]

#endif /* FastCodeHeader_h */
