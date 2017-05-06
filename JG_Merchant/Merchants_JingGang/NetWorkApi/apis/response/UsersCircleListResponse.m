//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UsersCircleListResponse.h"

@implementation UsersCircleListResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"circle":@"circle",
			@"circleInfo":@"circleInfo"
             };
}

+(NSValueTransformer *) circleTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Circle class]];
}
+(NSValueTransformer *) circleInfoTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Circle class]];
}
@end
