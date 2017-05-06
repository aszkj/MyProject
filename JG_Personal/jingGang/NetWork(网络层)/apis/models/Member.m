//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Member.h"

@implementation Member
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"uid":@"uid",
			@"nickName":@"nickName",
			@"mobile":@"mobile",
			@"addTime":@"addTime",
			@"source":@"source"
             };
}

@end
