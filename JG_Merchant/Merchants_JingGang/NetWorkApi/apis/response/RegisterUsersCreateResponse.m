//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "RegisterUsersCreateResponse.h"

@implementation RegisterUsersCreateResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"uid":@"uid",
			@"loginName":@"login_name",
			@"addressbyphone":@"addressbyphone",
			@"invitationCode":@"invitationCode"
             };
}

@end
