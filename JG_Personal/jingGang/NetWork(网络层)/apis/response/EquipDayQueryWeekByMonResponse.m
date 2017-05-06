//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "EquipDayQueryWeekByMonResponse.h"

@implementation EquipDayQueryWeekByMonResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"stepNumber":@"stepNumber",
			@"calories":@"calories",
			@"distance":@"distance",
			@"weekStep":@"weekStep",
			@"weekOfMonDataList":@"weekOfMonDataList",
			@"totalStepNumber":@"totalStepNumber",
			@"totalCalories":@"totalCalories",
			@"totalDistance":@"totalDistance",
			@"rangeSteps":@"rangeSteps"
             };
}

+(NSValueTransformer *) weekStepTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[StepRecord class]];
}
+(NSValueTransformer *) weekOfMonDataListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[StepRecord class]];
}
+(NSValueTransformer *) rangeStepsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[StepRecord class]];
}
@end
