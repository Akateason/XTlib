//
//  XTColorFetcher.h
//  pro
//
//  Created by TuTu on 16/8/16.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>


#define XTCOLOR                         return [[XTColorFetcher sharedInstance] xt_colorWithKey:NSStringFromSelector(_cmd)] ;

@interface XTColorFetcher : NSObject
+ (instancetype)sharedInstance ;
- (void)configurePlist:(NSString *)plist ;
- (UIColor *)xt_colorWithKey:(NSString *)key ;
@end
