//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UsersInvitationAddResponse.h"

@implementation UsersInvitationAddResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"apiId":@"id",
			@"uid":@"uid",
			@"title":@"title",
			@"userName":@"userName"
             };
}

@end
