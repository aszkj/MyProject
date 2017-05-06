//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "AddressListBO.h"

@implementation AddressListBO
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"areaInfo":@"areaInfo",
			@"defaultVal":@"defaultVal",
			@"mobile":@"mobile",
			@"trueName":@"trueName",
			@"areaName":@"areaName"
             };
}

@end
