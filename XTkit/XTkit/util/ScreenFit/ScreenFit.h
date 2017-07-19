//
//  ScreenFit.h
//  XTkit
//
//  Created by teason23 on 2017/7/19.
//  Copyright © 2017年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FastCodeHeader.h"

@interface ScreenFit : NSObject
AS_SINGLETON(ScreenFit)
- (int)getScreenHeightscale ;
- (int)getScreenWidthscale  ;

@end
