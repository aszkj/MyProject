//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopUserAddress.h"

@implementation ShopUserAddress
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"areaName":@"areaName",
			@"areaInfo":@"areaInfo",
			@"trueName":@"trueName",
			@"mobile":@"mobile",
			@"zip":@"zip",
			@"areaId":@"areaId",
			@"defaultVal":@"defaultVal"
             };
}

@end
