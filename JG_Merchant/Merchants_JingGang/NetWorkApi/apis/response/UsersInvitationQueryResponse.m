//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UsersInvitationQueryResponse.h"

@implementation UsersInvitationQueryResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"circle":@"circle",
			@"totalCount":@"totalCount",
			@"times":@"times"
             };
}

+(NSValueTransformer *) circleTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[CircleInvitation class]];
}
@end
