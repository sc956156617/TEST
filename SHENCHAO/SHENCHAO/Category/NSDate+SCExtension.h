//
//  NSDate+SCExtension.h
//  SCCateGory
//
//  Created by cb on 2017/7/7.
//  Copyright © 2017年 SC. All rights reserved.
//



//   tips ：工具方法家伙是哪个sc描述。 ，通用方法没有
#import <Foundation/Foundation.h>


#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

@interface NSDate (SCExtension)

//时间戳  同最下面的分类方法
/*
 *   服务器返回的时间戳单位是毫秒(默认),Client使用的时间戳单位是秒
 * */
- (double)SC_timeIntervalSince1970InMilliSecond;

//通过毫秒的时间戳转date

+ (NSDate *)SC_dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;
/*
 * 过去时间距离当前时间的时间间隔的描述,本方法返回长字符串
 * 时间格式为,支持多语言:
 * 1、当天的消息直接显示: HH:MM
 * 2、昨天的消息显示为:  昨天 HH:MM
 * 3、本周内的消息显示为: 星期几 HH:MM ~ Friday HH:MM
 * 4、超过一周的消息显示为: 2016年7月1日 19:20 ~ Jul 12 2016 11:47
 * */
- (NSString *)SC_timeIntervalBeforeNowLongDescription;
/*
 * 过去时间距离当前时间的时间间隔的描述, 本方法返回短字符串
 * 时间格式为:
 * 1、当天的消息直接显示:  HH:MM
 * 2、昨天的消息显示为:    昨天
 * 3、本周内的消息显示为:  星期几 ~ Friday
 * 4、超过一周的消息显示为: 6/16/16
 * */
- (NSString *)SC_timeIntervalBeforeNowShortDescription;

+ (NSCalendar *) currentCalendar; // avoid bottlenecks

// 获取日期
+ (NSDate *) dateTomorrow;
+ (NSDate *) dateYesterday;
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes;

// 格式集合
- (NSString *) stringWithDateStyle: (NSDateFormatterStyle) dateStyle timeStyle: (NSDateFormatterStyle) timeStyle;
- (NSString *) stringWithFormat: (NSString *) format;
@property (nonatomic, readonly) NSString *shortString;
@property (nonatomic, readonly) NSString *shortDateString;
@property (nonatomic, readonly) NSString *shortTimeString;
@property (nonatomic, readonly) NSString *mediumString;
@property (nonatomic, readonly) NSString *mediumDateString;
@property (nonatomic, readonly) NSString *mediumTimeString;
@property (nonatomic, readonly) NSString *longString;
@property (nonatomic, readonly) NSString *longDateString;
@property (nonatomic, readonly) NSString *longTimeString;

/***比较时间是不是**/
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;

- (BOOL) isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;

- (BOOL) isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) isThisWeek;
- (BOOL) isNextWeek;
- (BOOL) isLastWeek;

- (BOOL) isSameMonthAsDate: (NSDate *) aDate;
- (BOOL) isThisMonth;
- (BOOL) isNextMonth;
- (BOOL) isLastMonth;

- (BOOL) isSameYearAsDate: (NSDate *) aDate;
- (BOOL) isThisYear;
- (BOOL) isNextYear;
- (BOOL) isLastYear;

- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isLaterThanDate: (NSDate *) aDate;

- (BOOL) isInFuture;
- (BOOL) isInPast;

// Date roles
- (BOOL) isTypicallyWorkday;
- (BOOL) isTypicallyWeekend;

// Adjusting dates
- (NSDate *) dateByAddingYears: (NSInteger) dYears;
- (NSDate *) dateBySubtractingYears: (NSInteger) dYears;
- (NSDate *) dateByAddingMonths: (NSInteger) dMonths;
- (NSDate *) dateBySubtractingMonths: (NSInteger) dMonths;
- (NSDate *) dateByAddingDays: (NSInteger) dDays;
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *) dateByAddingHours: (NSInteger) dHours;
- (NSDate *) dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes;

// Date extremes
- (NSDate *) dateAtStartOfDay;
- (NSDate *) dateAtEndOfDay;

// Retrieving intervals
- (NSInteger) minutesAfterDate: (NSDate *) aDate;
- (NSInteger) minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) hoursAfterDate: (NSDate *) aDate;
- (NSInteger) hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) daysAfterDate: (NSDate *) aDate;
- (NSInteger) daysBeforeDate: (NSDate *) aDate;
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate;

// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

//是星期几
- (NSString *)dayFromWeekday;
+ (NSString *)dayFromWeekday:(NSDate *)date;
@end


@interface NSString (SCDate)
//默认格式为 yyyy-MM-dd HH:mm:ss
-(NSDate *)SC_dateFromString;
//默认时间戳格式。@"1287879863267";  秒的概念
-(NSDate *)SC_dateFromTimeInterval;

@end
