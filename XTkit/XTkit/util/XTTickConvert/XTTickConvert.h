//
//  MyTick.h
//  JGB
//
//  Created by teason on 14-10-29.
//  Copyright (c) 2014年 JGBMACMINI01. All rights reserved.
//
#import <UIKit/UIKit.h>


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



@interface XTTickConvert : NSObject

+ (long long)getTickFromNow ;
#pragma mark --
//转tick
+ (long long)getTickWithDate:(NSDate *)_date;
//转tick,转出string
+ (NSString *)getDateWithTick:(long long)_tick AndWithFormart:(NSString *)formatStr;
//转tick,转出NsDate
+ (NSDate *)getNSDateWithTick:(long long)_tick;
//转str变NSdate
+ (NSDate *)getNSDateWithDateStr:(NSString *)dateStr AndWithFormat:(NSString *)format;
//转nsdate变str
+ (NSString *)getStrWithNSDate:(NSDate *)date AndWithFormat:(NSString *)format;



#pragma mark --
//x分钟前/x小时前/昨天/x天前/x个月前/x年前
+ (NSString *)timeInfoWithDate:(NSDate *)date ;
+ (NSString *)getMMDDWithDate:(NSDate *)date ;

@end
