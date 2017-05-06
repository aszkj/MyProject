//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "SnsInformationAllInfomationListResponse.h"

@implementation SnsInformationAllInfomationListResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"informations":@"informations",
			@"totalCount":@"totalCount"
             };
}

+(NSValueTransformer *) informationsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[InformationBO class]];
}
@end
