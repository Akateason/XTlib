#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSDate+XTFMDB_Tick.h"
#import "NSObject+XTFMDB.h"
#import "NSObject+XTFMDB_Reflection.h"
#import "XTDBModel+autoSql.h"
#import "XTDBModel.h"
#import "XTDBVersion.h"
#import "XTFMDB.h"
#import "XTFMDBBase.h"
#import "XTFMDBConst.h"

FOUNDATION_EXPORT double XTFMDBVersionNumber;
FOUNDATION_EXPORT const unsigned char XTFMDBVersionString[];

