//
//  NSDate+Addition.h
//  SuBaoJiang
//
//  Created by apple on 15/6/5.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Addition)

#pragma mark - NSCalendar
//拿 当前 年月日
- (int)getYear;

- (int)getMonth;

- (int)getDay;

- (int)getHour;

- (int)getMinute;

- (int)getSecond;

//当前月有多少天
+ (int)daysInMonth:(int)imonth year:(int)year ;

@end
