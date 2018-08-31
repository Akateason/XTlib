//
//  UIButton+ExtendTouchRect.h
//  XTkit
//
//  Created by teason23 on 2017/6/20.
//  Copyright © 2017年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

static const float kDefaultEnlargeFlex = 25. ;

@interface UIButton (ExtendTouchRect)
@property (assign, nonatomic) UIEdgeInsets touchExtendInset ;

// enlarge e.g. UIEdgeInsetsMake(-15, -15, -15, -15) ;
- (void)xt_enlargeButtonsTouchArea ;
@end
