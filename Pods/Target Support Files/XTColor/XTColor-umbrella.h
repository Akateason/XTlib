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

#import "UIColor+AllColors.h"
#import "UIColor+HexString.h"
#import "XTColor.h"
#import "XTColorFetcher.h"

FOUNDATION_EXPORT double XTColorVersionNumber;
FOUNDATION_EXPORT const unsigned char XTColorVersionString[];

