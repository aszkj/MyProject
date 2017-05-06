//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "EquipSleepQueryByRangeResponse.h"

@implementation EquipSleepQueryByRangeResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"sleepRecordBO":@"sleepRecordBO",
			@"sleeps":@"sleeps"
             };
}

+(NSValueTransformer *) sleepRecordBOTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[SleepRecord class]];
}
+(NSValueTransformer *) sleepsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[SleepRecord class]];
}
@end
