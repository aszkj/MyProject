//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "StepRecord.h"

@implementation StepRecord
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"uid":@"uid",
			@"stepNumber":@"stepNumber",
			@"recordDate":@"recordDate",
			@"totalKm":@"totalKm",
			@"calories":@"calories",
			@"week":@"week",
			@"startDate":@"startDate",
			@"endDate":@"endDate"
             };
}

@end
