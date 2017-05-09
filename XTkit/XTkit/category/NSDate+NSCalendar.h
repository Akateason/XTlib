//
//  NSDate+NSCalendar.h
//  XTkit
//
//  Created by teason23 on 2017/5/9.
//  Copyright © 2017年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (NSCalendar)
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
