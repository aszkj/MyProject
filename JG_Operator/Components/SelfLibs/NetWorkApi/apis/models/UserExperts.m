//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UserExperts.h"

@implementation UserExperts
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"uid":@"uid",
			@"name":@"name",
			@"title":@"title",
			@"sex":@"sex",
			@"description":@"description",
			@"headImgPath":@"headImgPath",
			@"email":@"email",
			@"mobile":@"mobile",
			@"status":@"status",
			@"expertType":@"expertType",
			@"praiseInfo":@"praiseInfo",
			@"praiseCount":@"praiseCount",
			@"favorCount":@"favorCount",
			@"favorInfo":@"favorInfo",
			@"isFavor":@"isFavor",
			@"isPraise":@"isPraise",
			@"desc":@"desc"
             };
}

@end
