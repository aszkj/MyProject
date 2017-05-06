//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "SleepRecord.h"

@implementation SleepRecord
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"uid":@"uid",
			@"sleepSecond":@"sleepSecond",
			@"deepSleepSecond":@"deepSleepSecond",
			@"shallowSleepSecond":@"shallowSleepSecond",
			@"week":@"week",
			@"startDate":@"startDate",
			@"endDate":@"endDate"
             };
}

@end
