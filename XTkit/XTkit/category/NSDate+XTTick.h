//
//  NSDate+XTTick.h
//  XTkit
//
//  Created by teason23 on 2017/5/9.
//  Copyright © 2017年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>


static NSString * const TIME_STR_FORMAT_1 =      @"yyyy 年 MM 月 dd 日" ;
static NSString * const TIME_STR_FORMAT_2 =      @"yyyy年MM月dd日" ;
static NSString * const TIME_STR_FORMAT_3 =      @"YYYY-MM-dd HH:mm:ss" ;
static NSString * const TIME_STR_FORMAT_4 =      @"YYYYMMddHHmmss" ;
static NSString * const TIME_STR_FORMAT_5 =      @"YYYY-MM-dd" ;
static NSString * const TIME_STR_FORMAT_6 =      @"YYYY-MM-dd HH:mm" ;
static NSString * const TIME_STR_FORMAT_7 =      @"MM-dd" ;
static NSString * const TIME_STR_FORMAT_8 =      @"MM-dd HH:mm" ;
static const float  TICK_S_OR_SS_1 = 1000.0 ;
static const float  TICK_S_OR_SS_2 = 1.0 ;


@interface NSDate (XTTick)

//now
+ (long long)xt_getTickFromNow ;
//转tick
+ (long long)xt_getTickWithDate:(NSDate *)_date;
//转tick,转出string
+ (NSString *)xt_getDateWithTick:(long long)_tick AndWithFormart:(NSString *)formatStr;
//转tick,转出NsDate
+ (NSDate *)xt_getNSDateWithTick:(long long)_tick;
//转str变NSdate
+ (NSDate *)xt_getNSDateWithDateStr:(NSString *)dateStr AndWithFormat:(NSString *)format;
//转nsdate变str
+ (NSString *)xt_getStrWithNSDate:(NSDate *)date AndWithFormat:(NSString *)format;

//x分钟前/x小时前/昨天/x天前/x个月前/x年前
+ (NSString *)xt_timeInfoWithDate:(NSDate *)date ;
+ (NSString *)xt_getMMDDWithDate:(NSDate *)date ;

// compare
- (NSComparisonResult)xt_compareTick:(long long)tick1 and:(long long)tick2 ;


@end
