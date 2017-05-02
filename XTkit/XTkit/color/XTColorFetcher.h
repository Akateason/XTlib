//
//  XTColorFetcher.h
//  pro
//
//  Created by TuTu on 16/8/16.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FastCodeHeader.h"


#define XTCOLOR( _colorInPlist_ )     [[XTColorFetcher sharedInstance] xt_colorWithKey:_colorInPlist_]


@interface XTColorFetcher : NSObject

AS_SINGLETON(XTColorFetcher)

- (UIColor *)xt_colorWithKey:(NSString *)key ;

@end
