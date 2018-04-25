//
//  UILabel+Calculate.h
//  XTlib
//
//  Created by teason23 on 2018/4/25.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Calculate)

//根据宽度求高度  content 计算的内容  width 计算的宽度 font字体大小
+ (CGFloat)getLabelHeightWithText:(NSString *)text
                            width:(CGFloat)width
                             font:(CGFloat)font ;

//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
+ (CGFloat)getLabelWidthWithText:(NSString *)text
                          height:(CGFloat)height
                            font:(CGFloat)font ;

- (CGFloat)getLabelHeightWithWidth:(CGFloat)width ;

- (CGFloat)getWidthWithHeight:(CGFloat)height ;

@end
