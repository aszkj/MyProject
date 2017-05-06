//
//  DateManager.m
//  YilidiSeller
//
//  Created by yld on 16/7/7.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DateManager.h"
#import "NSDate+Utilities.h"

#define kNormalDateFormat @"yyyy-MM-dd HH:mm:ss"

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
    if (isEmpty(basicTime)) {
        return @"--";
    }
    NSDate *basciDate = [self.dateFormatter dateFromString:basicTime];
    NSDate *dateAfterAnHour = [basciDate dateByAddingHours:1];
    return [self.dateFormatter stringFromDate:dateAfterAnHour];
    
}


@end
