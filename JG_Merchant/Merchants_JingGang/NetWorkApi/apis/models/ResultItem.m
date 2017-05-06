//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ResultItem.h"

@implementation ResultItem
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"itemName":@"itemName",
			@"createTime":@"createTime",
			@"groupId":@"groupId",
			@"type":@"type",
			@"usingItem":@"usingItem",
			@"minValue":@"minValue",
			@"maxValue":@"maxValue",
			@"unit":@"unit",
			@"referenceValue":@"referenceValue",
			@"value":@"value"
             };
}

@end
