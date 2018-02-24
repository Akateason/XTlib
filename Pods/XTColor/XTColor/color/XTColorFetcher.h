//
//  XTColorFetcher.h
//
//  Created by teason on 16/8/16.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorWithKey(__name__)        [[XTColorFetcher sharedInstance] xt_colorWithKey:(__name__)]


@interface XTColorFetcher : NSObject
@property (nonatomic,strong,readonly) NSDictionary *dicData   ;

+ (instancetype)sharedInstance ;
- (void)configurePlist:(NSString *)plist ;
- (UIColor *)xt_colorWithKey:(NSString *)key ;
- (UIColor *)randomColor ;
@end
