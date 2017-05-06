//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "CircleInvitationVO.h"

@implementation CircleInvitationVO
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"title":@"title",
			@"praiseCount":@"praiseCount",
			@"replyCount":@"replyCount",
			@"replyName":@"replyName",
			@"headImgPath":@"headImgPath",
			@"uid":@"uid"
             };
}

@end
