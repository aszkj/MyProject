//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "CircleInvitation.h"

@implementation CircleInvitation
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"publicTime":@"publicTime",
			@"circleId":@"circleId",
			@"circleName":@"circleName",
			@"invitaionPerfect":@"invitaionPerfect",
			@"praiseCount":@"praiseCount",
			@"replyCount":@"replyCount",
			@"title":@"title",
			@"type":@"type",
			@"userName":@"userName",
			@"circleType":@"circleType",
			@"content":@"content",
			@"itemInfo":@"itemInfo",
			@"photoInfo":@"photoInfo",
			@"praiseInfo":@"praiseInfo",
			@"replyName":@"replyName",
			@"headImgPath":@"headImgPath",
			@"replyTime":@"replyTime",
			@"isPraise":@"isPraise",
			@"isFavo":@"isFavo",
			@"favoritesInfo":@"favoritesInfo",
			@"thumbnail":@"thumbnail"
             };
}

@end
