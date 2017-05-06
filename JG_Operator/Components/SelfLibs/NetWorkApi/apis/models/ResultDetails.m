//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ResultDetails.h"

@implementation ResultDetails
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"physicalName":@"physicalName",
			@"minVale":@"minVale",
			@"maxValue":@"maxValue",
			@"referenceValue":@"referenceValue",
			@"positive":@"positive",
			@"unit":@"unit",
			@"result":@"result",
			@"value":@"value",
			@"type":@"type"
             };
}

@end
