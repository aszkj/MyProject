//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UsersMyselfInvitationListResponse.h"

@implementation UsersMyselfInvitationListResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"invitations":@"invitations",
			@"totalCount":@"totalCount"
             };
}

+(NSValueTransformer *) invitationsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[CircleInvitation class]];
}
@end
