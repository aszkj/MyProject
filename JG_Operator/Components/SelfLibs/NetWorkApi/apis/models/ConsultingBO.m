//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ConsultingBO.h"

@implementation ConsultingBO
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"expertsUserId":@"expertsUserId",
			@"userId":@"userId",
			@"title":@"title",
			@"images":@"images",
			@"content":@"content"
             };
}

@end
