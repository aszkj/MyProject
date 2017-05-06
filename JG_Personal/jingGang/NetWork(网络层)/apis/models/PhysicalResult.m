//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "PhysicalResult.h"

@implementation PhysicalResult
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"uid":@"uid",
			@"minValue":@"minValue",
			@"maxValue":@"maxValue",
			@"time":@"time",
			@"itemCode":@"itemCode",
			@"middleValue":@"middleValue"
             };
}

@end
