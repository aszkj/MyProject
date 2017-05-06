//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UsersInvitationAllListResponse.h"

@implementation UsersInvitationAllListResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"invitation":@"invitation",
			@"totalCount":@"totalCount",
			@"times":@"times"
             };
}

+(NSValueTransformer *) invitationTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[CircleInvitation class]];
}
@end
