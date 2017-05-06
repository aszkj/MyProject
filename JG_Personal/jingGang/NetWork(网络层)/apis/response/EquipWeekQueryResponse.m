//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "EquipWeekQueryResponse.h"

@implementation EquipWeekQueryResponse
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
			@"rangeSteps":@"rangeSteps",
			@"monthRecordList":@"monthRecordList"
             };
}

+(NSValueTransformer *) weekStepTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[StepRecordBO class]];
}
+(NSValueTransformer *) weekOfMonDataListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[WeekOfMonthRecordBO class]];
}
+(NSValueTransformer *) rangeStepsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[StepRecordBO class]];
}
+(NSValueTransformer *) monthRecordListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[StepRecordBO class]];
}
@end
