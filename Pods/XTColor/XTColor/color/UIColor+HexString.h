//
//  UIColor+HexString.h
//  teason
//
//  Created by teason on 15/8/10.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)

+ (UIColor *)colorWithHexString:(NSString *)color ;
+ (UIColor *)colorWithHexString:(NSString *)color
                          alpha:(float)alpha ;

@end
