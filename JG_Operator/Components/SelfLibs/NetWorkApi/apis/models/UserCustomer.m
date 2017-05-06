//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UserCustomer.h"

@implementation UserCustomer
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"uid":@"uid",
			@"name":@"name",
			@"nickName":@"nickName",
			@"allergicHistory":@"allergicHistory",
			@"sex":@"sex",
			@"height":@"height",
			@"weight":@"weight",
			@"birthdate":@"birthdate",
			@"email":@"email",
			@"mobile":@"mobile",
			@"status":@"status",
			@"transHistory":@"transHistory",
			@"transGenetic":@"transGenetic",
			@"headImgPath":@"headImgPath",
			@"blood":@"blood",
			@"invitationCode":@"invitationCode",
			@"referee":@"referee",
			@"merchant":@"merchant",
			@"isCloudPassword":@"isCloudPassword"
             };
}

@end
