//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "CircleInvitationReply.h"

@implementation CircleInvitationReply
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"uid":@"uid",
			@"addTime":@"addTime",
			@"levelCount":@"levelCount",
			@"deleteStatus":@"deleteStatus",
			@"invitationId":@"invitationId",
			@"parentId":@"parentId",
			@"replyCount":@"replyCount",
			@"userId":@"userId",
			@"userName":@"userName",
			@"userPhoto":@"userPhoto",
			@"content":@"content"
             };
}

@end
