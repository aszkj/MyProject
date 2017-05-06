//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "OpNotices.h"

@implementation OpNotices
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"addTime":@"addTime",
			@"ntStatus":@"ntStatus",
			@"ntTitle":@"ntTitle",
			@"ntContent":@"ntContent",
			@"operatorName":@"operatorName"
             };
}

@end
