//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "PhysicalListSelectCodeResponse.h"

@implementation PhysicalListSelectCodeResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"physicalSeven":@"physicalSeven",
			@"physicalAll":@"physicalAll"
             };
}

+(NSValueTransformer *) physicalSevenTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[PhysicalResult class]];
}
+(NSValueTransformer *) physicalAllTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[PhysicalResult class]];
}
@end
