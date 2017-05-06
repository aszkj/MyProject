//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "WeekOfMonthRecordBO.h"

@implementation WeekOfMonthRecordBO
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"stepNumSumOfWeek":@"stepNumSumOfWeek",
			@"totalKmSumOfWeek":@"totalKmSumOfWeek",
			@"caloriesSumOfWeek":@"caloriesSumOfWeek",
			@"sleepSecondSumOfWeek":@"sleepSecondSumOfWeek",
			@"deepSleepSecondSumOfWeek":@"deepSleepSecondSumOfWeek",
			@"shallowSleepSecondSumOfWeek":@"shallowSleepSecondSumOfWeek"
             };
}

@end
