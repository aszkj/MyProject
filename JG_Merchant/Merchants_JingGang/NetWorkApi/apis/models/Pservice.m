//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Pservice.h"

@implementation Pservice
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"groupAccPath":@"groupAccPath",
			@"groupId":@"groupId",
			@"groupName":@"groupName",
			@"totalPrice":@"totalPrice",
			@"groupSn":@"groupSn",
			@"status":@"status"
             };
}

@end
