//
//  IsFirstTime.h
//  PatchBoard
//
//  Created by teason23 on 2017/7/19.
//  Copyright © 2017年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IsFirstTime : NSObject

+ (BOOL)isFirstLoad ;
+ (BOOL)isFirstHomePage ;
+ (BOOL)isFirstDetailPage ;
+ (BOOL)isFirstPostSinglePage ;
+ (BOOL)isFirstMultyEditPage ;

//write obj in userDefaults
+ (BOOL)userDefaultsInCurrentVersionForKey:(NSString *)key ;


@end
