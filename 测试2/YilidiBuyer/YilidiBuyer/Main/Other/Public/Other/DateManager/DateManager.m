//
//  DateManager.m
//  YilidiSeller
//
//  Created by yld on 16/7/7.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DateManager.h"
#import "NSDate+Utilities.h"

#define kNormalDateFormat @"HH:mm:ss"

static DateManager *_dateManager = nil;

@interface DateManager()

@property (nonatomic, strong)NSDateFormatter *dateFormatter;

@end

@implementation DateManager

+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _dateManager = [[DateManager alloc] init];
    });
    return _dateManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:kNormalDateFormat];
    }
    return self;
}

- (NSString *)afterAnHourTimeWithTheBasicTime:(NSString *)basicTime {
    
    NSDate *basciDate = [self.dateFormatter dateFromString:basicTime];
    NSDate *dateAfterAnHour = [basciDate dateByAddingHours:1];
    return [self.dateFormatter stringFromDate:dateAfterAnHour];
}

- (NSDate *)dateWithDateStr:(NSString *)dateStr {
    return [self.dateFormatter dateFromString:dateStr];
}

- (NSInteger)currentDateInRangeFromBeginTime:(NSString *)beginTime
                                     endTime:(NSString *)endTime
{
    if (isEmpty(beginTime) || isEmpty(endTime)) {
        return -1000;
    }
    NSDate *beginDate = [self.dateFormatter dateFromString:beginTime];
    NSDate *endDate = [self.dateFormatter dateFromString:endTime];
    NSDate *currentDate = [NSDate date];
    
    NSInteger beginMinute = beginDate.hour * 60 + beginDate.minute;
    NSInteger endMinute = endDate.hour * 60 + endDate.minute;
    NSInteger currentMinute = currentDate.hour * 60 + currentDate.minute;

    if (currentMinute < beginMinute) {
        return -1;
    }else if (currentMinute <= endMinute) {
        return 0;
    }else {
        return 1;
    }
}



@end
