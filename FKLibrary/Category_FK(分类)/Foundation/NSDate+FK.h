//
//  NSDate+FK.h
//  FKLibraryExample
//
//  Created by frank on 15/11/2.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (FK)

///**
// *  是否为今天
// */
//- (BOOL)fk_isToday;
///**
// *  是否为昨天
// */
//- (BOOL)fk_isYesterday;
/**
 *  是否为今年
 */
- (BOOL)fk_isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)fk_dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)fk_deltaWithNow;


/** 格式化时间 */
+ (NSString *)fk_dateFormatWithNumber:(NSNumber *)number;


#pragma mark - Component Properties
///=============================================================================
/// @name Component Properties
///=============================================================================

@property (nonatomic, readonly) NSInteger fk_year; ///< Year component
@property (nonatomic, readonly) NSInteger fk_month; ///< Month component (1~12)
@property (nonatomic, readonly) NSInteger fk_day; ///< Day component (1~31)
@property (nonatomic, readonly) NSInteger fk_hour; ///< Hour component (0~23)
@property (nonatomic, readonly) NSInteger fk_minute; ///< Minute component (0~59)
@property (nonatomic, readonly) NSInteger fk_second; ///< Second component (0~59)
@property (nonatomic, readonly) NSInteger fk_nanosecond; ///< Nanosecond component
@property (nonatomic, readonly) NSInteger fk_weekday; ///< Weekday component (1~7, first day is based on user setting)
@property (nonatomic, readonly) NSInteger fk_weekdayOrdinal; ///< WeekdayOrdinal component
@property (nonatomic, readonly) NSInteger fk_weekOfMonth; ///< WeekOfMonth component (1~5)
@property (nonatomic, readonly) NSInteger fk_weekOfYear; ///< WeekOfYear component (1~53)
@property (nonatomic, readonly) NSInteger fk_yearForWeekOfYear; ///< YearForWeekOfYear component
@property (nonatomic, readonly) NSInteger fk_quarter; ///< Quarter component
@property (nonatomic, readonly) BOOL fk_isLeapMonth; ///< Weather the month is leap month
@property (nonatomic, readonly) BOOL fk_isLeapYear; ///< Weather the year is leap year【是否是闰年】
@property (nonatomic, readonly) BOOL fk_isToday; ///< Weather date is today (based on current locale)
@property (nonatomic, readonly) BOOL fk_isYesterday; ///< Weather date is yesterday (based on current locale)

#pragma mark - Date modify
///=============================================================================
/// @name Date modify
///=============================================================================

/**
 Returns a date representing the receiver date shifted later by the provided number of years.
 
 @param years  Number of years to add.
 @return Date modified by the number of desired years.
 */
- (NSDate *)fk_dateByAddingYears:(NSInteger)years;

/**
 Returns a date representing the receiver date shifted later by the provided number of months.
 
 @param months  Number of months to add.
 @return Date modified by the number of desired months.
 */
- (NSDate *)fk_dateByAddingMonths:(NSInteger)months;

/**
 Returns a date representing the receiver date shifted later by the provided number of weeks.
 
 @param weeks  Number of weeks to add.
 @return Date modified by the number of desired weeks.
 */
- (NSDate *)fk_dateByAddingWeeks:(NSInteger)weeks;

/**
 Returns a date representing the receiver date shifted later by the provided number of days.
 
 @param days  Number of days to add.
 @return Date modified by the number of desired days.
 */
- (NSDate *)fk_dateByAddingDays:(NSInteger)days;

/**
 Returns a date representing the receiver date shifted later by the provided number of hours.
 
 @param hours  Number of hours to add.
 @return Date modified by the number of desired hours.
 */
- (NSDate *)fk_dateByAddingHours:(NSInteger)hours;

/**
 Returns a date representing the receiver date shifted later by the provided number of minutes.
 
 @param minutes  Number of minutes to add.
 @return Date modified by the number of desired minutes.
 */
- (NSDate *)fk_dateByAddingMinutes:(NSInteger)minutes;

/**
 Returns a date representing the receiver date shifted later by the provided number of seconds.
 
 @param seconds  Number of seconds to add.
 @return Date modified by the number of desired seconds.
 */
- (NSDate *)fk_dateByAddingSeconds:(NSInteger)seconds;


#pragma mark - Date Format
///=============================================================================
/// @name Date Format
///=============================================================================

/**
 Returns a formatted string representing this date.
 see http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_Patterns
 for format description.
 
 @param format   String representing the desired date format.
 e.g. @"yyyy-MM-dd HH:mm:ss"
 
 @return NSString representing the formatted date string.
 */
- (NSString *)fk_stringWithFormat:(NSString *)format;

/**
 Returns a formatted string representing this date.
 see http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_Patterns
 for format description.
 
 @param format    String representing the desired date format.
 e.g. @"yyyy-MM-dd HH:mm:ss"
 
 @param timeZone  Desired time zone.
 
 @param locale    Desired locale.
 
 @return NSString representing the formatted date string.
 */
- (NSString *)fk_stringWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale;

/**
 Returns a string representing this date in ISO8601 format.
 e.g. "2010-07-09T16:13:30+12:00"
 
 @return NSString representing the formatted date string in ISO8601.
 */
- (NSString *)fk_stringWithISOFormat;

/**
 Returns a date parsed from given string interpreted using the format.
 
 @param dateString The string to parse.
 @param format     The string's date format.
 
 @return A date representation of string interpreted using the format.
 If can not parse the string, returns nil.
 */
+ (NSDate *)fk_dateWithString:(NSString *)dateString format:(NSString *)format;

/**
 Returns a date parsed from given string interpreted using the format.
 
 @param dateString The string to parse.
 @param format     The string's date format.
 @param timeZone   The time zone, can be nil.
 @param locale     The locale, can be nil.
 
 @return A date representation of string interpreted using the format.
 If can not parse the string, returns nil.
 */
+ (NSDate *)fk_dateWithString:(NSString *)dateString format:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale;

/**
 Returns a date parsed from given string interpreted using the ISO8601 format.
 
 @param dateString The date string in ISO8601 format. e.g. "2010-07-09T16:13:30+12:00"
 
 @return A date representation of string interpreted using the format.
 If can not parse the string, returns nil.
 */
+ (NSDate *)fk_dateWithISOFormatString:(NSString *)dateString;


@end
