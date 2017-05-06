//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Circle.h"

@implementation Circle
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"addTime":@"addTime",
			@"attentionCount":@"attentionCount",
			@"classId":@"classId",
			@"className":@"className",
			@"invitationCount":@"invitationCount",
			@"recommend":@"recommend",
			@"title":@"title",
			@"userName":@"userName",
			@"content":@"content",
			@"photoInfo":@"photoInfo"
             };
}

@end
