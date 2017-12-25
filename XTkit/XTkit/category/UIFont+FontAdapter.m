//
//  UIFont+FontAdapter.h
//  XTkit
//
//  Created by teason23 on 2017/8/23.
//  Copyright © 2017年 teason. All rights reserved.

#import "UIFont+FontAdapter.h"
#import <objc/runtime.h>

#define IS_IPHONE_6 ([[UIScreen mainScreen] bounds].size.height == 667.0f)
#define IS_IPHONE_6_PLUS ([[UIScreen mainScreen] bounds].size.height == 736.0f)

// 这里设置iPhone6Plus放大的字号数（现在是放大3号，也就是iPhone4s和iPhone5上字体为15时，iPhone6上字号为18）
#define IPHONE6PLUS_INCREMENT 0
#define IPHONE6BLOW_REDUCE 2

@implementation UIFont (FontAdapter)

- (void)adjustFont:(CGFloat)fontSize {
    float tmpSize = 0. ;
    if (IS_IPHONE_6) {
        tmpSize = fontSize ;
    }
    else if (IS_IPHONE_6_PLUS){
        tmpSize = fontSize + IPHONE6PLUS_INCREMENT ;
    }
    else {
        if (fontSize <= 12) {
            tmpSize = fontSize ;
        }
        else {
            tmpSize = fontSize - IPHONE6BLOW_REDUCE ;
        }
    }
    [self fontWithSize:tmpSize] ;
}

@end
