//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "CheckResultHistory.h"

@implementation CheckResultHistory
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"groupTitle":@"groupTitle",
			@"resultDesc":@"resultDesc",
			@"createTime":@"createTime",
			@"desc":@"desc",
			@"score":@"score",
			@"groupId":@"groupId",
			@"imgUrl":@"imgUrl"
             };
}

@end
