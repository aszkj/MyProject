//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "PhysicalSaveResponse.h"

@implementation PhysicalSaveResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"physical":@"physical",
			@"physicalArr":@"physicalArr"
             };
}

+(NSValueTransformer *) physicalTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[PhysicalResult class]];
}
+(NSValueTransformer *) physicalArrTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[PhysicalResult class]];
}
@end
