//
//  NSDate+JACoder.m
//  Daily_modules
//
//  Created by Jason on 13/01/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "NSDate+JACoder.h"

@implementation NSDate (JACoder)

static NSDateFormatter *dateFormatter;

+ (NSDateFormatter *)ja_defaultFormatter {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        // http://www.skyfox.org/ios-formatter-daylight-saving-time.html
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        // NSTimeZone* timeZone = [NSTimeZone timeZoneForSecondsFromGMT:3600*8];
        [dateFormatter setTimeZone:timeZone];
    });
    return dateFormatter;
}

+ (NSDate *)ja_dateFromString:(NSString *)timeStr
                       format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [NSDate ja_defaultFormatter];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:timeStr];
    return date;
}

+ (NSInteger)ja_cTimestampFromDate:(NSDate *)date{
    return (long)[date timeIntervalSince1970];
}

+ (NSInteger)ja_cTimestampFromString:(NSString *)timeStr
                           format:(NSString *)format
{
    NSDate *date = [NSDate ja_dateFromString:timeStr format:format];
    return [NSDate ja_cTimestampFromDate:date];
}

+ (NSString *)ja_dateStrFromCStampTime:(NSInteger)timeStamp
                        withDateFormat:(NSString *)format
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    return [NSDate ja_datestrFromDate:date withDateFormat:format];
}

+ (NSString *)ja_datestrFromDate:(NSDate *)date
               withDateFormat:(NSString *)format
{
    NSDateFormatter* dateFormat = [NSDate ja_defaultFormatter];
    [dateFormat setDateFormat:format];
    return [dateFormat stringFromDate:date];
}

+ (NSDateComponents *)ja_currentComponents {
    NSDate *now = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    cal.timeZone = timeZone;
    return [cal components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:now];
}

+ (NSTimeInterval)ja_zeroOfCStampTime{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    
    NSTimeInterval ts = (double)(int)[[calendar dateFromComponents:components] timeIntervalSince1970];
    
    return ts;
}

+ (NSTimeInterval)ja_zeroOfCStampTimeWithDay:(NSInteger)day
                                       month:(NSInteger)month {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    components.month = month;
    components.day = day;
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    
    NSTimeInterval ts = (double)(int)[[calendar dateFromComponents:components] timeIntervalSince1970];
    return ts;
}

+ (NSData *)ja_dataWithHexString:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    
    return hexData;
}

+ (BOOL)ja_isDiffDay {
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    // http://www.skyfox.org/ios-formatter-daylight-saving-time.html
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    // NSTimeZone* timeZone = [NSTimeZone timeZoneForSecondsFromGMT:3600*8];
    [formater setTimeZone:timeZone];
    
    // 获取当前日期
    NSDate *curDate = [NSDate date];
    [formater setDateFormat:@"yyyy-MM-dd"];
    NSString * curTime = [formater stringFromDate:curDate];
    
//    NSString *bid = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleIdentifier"];
    NSString *currentDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentDate"];
    
    // 首次
    if (currentDate == nil) {
        NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
        [standardDefaults setObject:curTime forKey:@"currentDate"];
        [standardDefaults synchronize];
    }
    
    // 是同一天
    if ([curTime isEqualToString:currentDate]) {
        return false;
    }
    
    return true;
}

+ (BOOL)ja_isDiffMonth {
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    // http://www.skyfox.org/ios-formatter-daylight-saving-time.html
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    // NSTimeZone* timeZone = [NSTimeZone timeZoneForSecondsFromGMT:3600*8];
    [formater setTimeZone:timeZone];
    
    // 获取当前日期
    NSDate *curDate = [NSDate date];
    [formater setDateFormat:@"yyyy-MM"];
    NSString * curTime = [formater stringFromDate:curDate];
    
    //    NSString *bid = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleIdentifier"];
    NSString *currentDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentMonth"];
    
    // 首次
    if (currentDate == nil) {
        NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
        [standardDefaults setObject:curTime forKey:@"currentMonth"];
        [standardDefaults synchronize];
    }
    
    // 是同一月
    if ([curTime isEqualToString:currentDate]) {
        return false;
    }
    
    return true;
}

+ (NSString *)ja_stringFromDate:(NSDate *)date
                 withDateFormat:(NSString *)format {
    
    NSDateFormatter *dateFromat = [NSDate ja_defaultFormatter];
    [dateFromat setDateFormat:format];
    NSString *dateStringFormat = [dateFromat stringFromDate:date];
    return dateStringFormat;
}

+ (NSString *)ja_readableWithTimeStamp:(NSInteger)timestamp {
    NSString *r = @"";
    if (timestamp >= 60) {
        NSInteger min = timestamp / 60;
        r = [r stringByAppendingString:@(min).stringValue];
        [r stringByAppendingString:@":"];
    }
    
    NSInteger second = timestamp % 60;
    return nil;
}

@end
