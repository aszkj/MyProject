//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "EquipDayQueryByRangeResponse.h"

@implementation EquipDayQueryByRangeResponse
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
			@"totalStepNumber":@"totalStepNumber",
			@"totalCalories":@"totalCalories",
			@"totalDistance":@"totalDistance"
             };
}

+(NSValueTransformer *) weekStepTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[StepRecord class]];
}
@end
