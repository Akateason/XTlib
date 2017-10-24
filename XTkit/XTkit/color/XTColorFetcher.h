//
//  XTColorFetcher.h
//  pro
//
//  Created by TuTu on 16/8/16.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorWithKey(__name__)        [[XTColorFetcher sharedInstance] xt_colorWithKey:(__name__)]


@interface XTColorFetcher : NSObject
+ (instancetype)sharedInstance ;
@property (nonatomic,strong,readonly) NSDictionary *dicData   ;
- (void)configurePlist:(NSString *)plist ;
- (UIColor *)xt_colorWithKey:(NSString *)key ;
@end
