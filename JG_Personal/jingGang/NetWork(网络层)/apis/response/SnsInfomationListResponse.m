//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "SnsInfomationListResponse.h"

@implementation SnsInfomationListResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"invitation":@"invitation"
             };
}

+(NSValueTransformer *) invitationTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[InfomationBO class]];
}
@end
