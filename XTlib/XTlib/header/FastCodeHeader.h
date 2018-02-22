//
//  FastCodeHeader.h
//  XTkit
//
//  Created by teason on 2017/4/19.
//  Copyright © 2017年 teason. All rights reserved.
//

#ifndef FastCodeHeader_h
#define FastCodeHeader_h


//-----------------------------------------------------------------------------//
//
// User Default
//
#define USERDEFAULT_GET_VAL(key) \
[[NSUserDefaults standardUserDefaults] objectForKey:key]

#define USERDEFAULT_SET_VAL(value, key) \
[[NSUserDefaults standardUserDefaults] setObject:value forKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize];

#define USERDEFAULT_DELTE_VAL(key) \
[[NSUserDefaults standardUserDefaults] removeObjectForKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize];
//-----------------------------------------------------------------------------//
//
// WEAK STRONG SELF
//
#define WEAK_SELF       __weak      typeof(self) weakSelf = self        ;
#define STRONG_SELF     __strong    typeof(weakSelf) self = weakSelf    ;
//
//-----------------------------------------------------------------------------//
//
// string format
//
#define STR_FORMAT(format, ...)         [NSString stringWithFormat:(format), ##__VA_ARGS__]
//
//-----------------------------------------------------------------------------//
//
// SINGLETON
//
// .h
//
#undef  XT_SINGLETON_H
#define XT_SINGLETON_H(__class)                                             \
+ (__class *)sharedInstance ;                                               \

// .m
//
#undef  XT_SINGLETON_M
#define XT_SINGLETON_M(__class)                                             \
static __class *__singleton__ = nil ;                                       \
+ (__class *)sharedInstance {                                               \
static dispatch_once_t once;                                            \
dispatch_once(&once, ^{ __singleton__ = [[__class alloc] init]; });     \
return __singleton__;                                                   \
}                                                                           \
+ (instancetype)allocWithZone:(struct _NSZone *)zone {                      \
static dispatch_once_t once ;                                           \
dispatch_once(&once, ^{ __singleton__ = [super allocWithZone:zone];});  \
return __singleton__;                                                   \
}                                                                           \
- (instancetype)init {                                                      \
static dispatch_once_t onceToken;                                       \
dispatch_once(&onceToken, ^{                                            \
__singleton__ = [super init];                                       \
});                                                                     \
return __singleton__;                                                   \
}                                                                           \
- (id)copyWithZone:(NSZone *)zone {                                         \
return  __singleton__;                                                  \
}                                                                           \
+ (id)copyWithZone:(struct _NSZone *)zone {                                 \
return  __singleton__;                                                  \
}                                                                           \
+ (id)mutableCopyWithZone:(struct _NSZone *)zone {                          \
return __singleton__;                                                   \
}                                                                           \
- (id)mutableCopyWithZone:(NSZone *)zone {                                  \
return __singleton__;                                                   \
}                                                                           \
//-----------------------------------------------------------------------------//



#endif /* FastCodeHeader_h */
