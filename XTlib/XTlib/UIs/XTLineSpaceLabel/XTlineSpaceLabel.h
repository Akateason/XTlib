//
//  XTlineSpaceLabel.h
//  subao
//
//  Created by apple on 15/9/6.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTlineSpaceLabel : UILabel

@property(nonatomic) long linesSpacing ;

+ (int)getAttributedStringHeightWidthValue:(int)width
                                   content:(NSString *)content
                                attributes:(NSDictionary *)attribute ;

@end
