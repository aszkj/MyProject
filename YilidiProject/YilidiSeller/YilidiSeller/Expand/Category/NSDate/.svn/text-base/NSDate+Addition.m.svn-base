//
//  NSDate+Addition.m
//  IOS-Categories
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "NSDate+Addition.h"

@implementation NSDate (Addition)
+ (NSString *)currentDateStringWithFormat:(NSString *)format
{
    NSDate *chosenDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *date = [formatter stringFromDate:chosenDate];
    return date;
}
- (NSString *)dateWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *date = [formatter stringFromDate:self];
    return date;
}
+ (NSTimeInterval)subCurrentDateWithDateString:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *beforeTime = [formatter dateFromString:dateStr];
    return -[beforeTime timeIntervalSinceNow];
}

+ (NSDate *)convertFromTaggedDate:(NSDate *)taggedDate
{
    NSTimeInterval timeInterval = [taggedDate timeIntervalSince1970];
    timeInterval /= 1000;
    return [NSDate dateWithTimeIntervalSince1970:timeInterval];
}

@end
