//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ReportResultDetailsResponse.h"

@implementation ReportResultDetailsResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"circle":@"circle",
			@"totalCount":@"totalCount",
			@"resultGroupBOs":@"resultGroupBOs",
			@"usingResultItemBOs":@"usingResultItemBOs",
			@"resultItemBOs":@"resultItemBOs",
			@"resultItem":@"resultItem",
			@"report":@"report",
			@"userDetails":@"userDetails"
             };
}

+(NSValueTransformer *) circleTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[CheckReport class]];
}
+(NSValueTransformer *) resultGroupBOsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ResultGroup class]];
}
+(NSValueTransformer *) usingResultItemBOsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ResultItem class]];
}
+(NSValueTransformer *) resultItemBOsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ResultItem class]];
}
+(NSValueTransformer *) resultItemTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ResultItem class]];
}
+(NSValueTransformer *) reportTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[CheckReport class]];
}
+(NSValueTransformer *) userDetailsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ResultDetails class]];
}
@end
