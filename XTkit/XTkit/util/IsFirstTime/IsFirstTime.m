//
//  IsFirstTime.m
//  PatchBoard
//
//  Created by teason23 on 2017/7/19.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "IsFirstTime.h"
#import "CommonFunc.h"

@implementation IsFirstTime

#pragma mark -- isFirstLaunch

#define LAST_RUN_VERSION_KEY        @"last_run_version_of_application"
+ (BOOL)isFirstLoad
{
    return [self userDefaultsInCurrentVersionForKey:LAST_RUN_VERSION_KEY] ;
}

#define LAST_HOME_PAGE_KEY          @"LAST_HOME_PAGE_KEY"
+ (BOOL)isFirstHomePage
{
    return [self userDefaultsInCurrentVersionForKey:LAST_HOME_PAGE_KEY] ;
}

#define LAST_DETAIL_PAGE_KEY        @"LAST_DETAIL_PAGE_KEY"
+ (BOOL)isFirstDetailPage
{
    return [self userDefaultsInCurrentVersionForKey:LAST_DETAIL_PAGE_KEY] ;
}

#define LAST_POST_SINGLE_PAGE_KEY   @"LAST_POST_SINGLE_PAGE_KEY"
+ (BOOL)isFirstPostSinglePage
{
    return [self userDefaultsInCurrentVersionForKey:LAST_POST_SINGLE_PAGE_KEY] ;
}

#define LAST_MULTY_EDIT_PAGE_KEY    @"LAST_MULTY_EDIT_PAGE_KEY"
+ (BOOL)isFirstMultyEditPage
{
    return [self userDefaultsInCurrentVersionForKey:LAST_MULTY_EDIT_PAGE_KEY] ;
}

+ (BOOL)userDefaultsInCurrentVersionForKey:(NSString *)key
{
    NSString *currentVersion = [CommonFunc getVersionStrOfMyAPP] ;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults] ;
    NSString *lastRunVersion = [defaults objectForKey:key] ;
    if (!lastRunVersion) {
        [defaults setObject:currentVersion forKey:key] ;
        return YES ;
    }
    else if (![lastRunVersion isEqualToString:currentVersion]) {
        [defaults setObject:currentVersion forKey:key] ;
        return YES;
    }
    return NO;
}

@end
