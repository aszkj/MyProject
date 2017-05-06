//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "GroupService.h"

@implementation GroupService
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"goodsId":@"goodsId",
			@"goodsName":@"goodsName",
			@"goodsEndTime":@"goodsEndTime",
			@"goodBeginTime":@"goodBeginTime",
			@"goodsPrice":@"goodsPrice",
			@"goodsType":@"goodsType",
			@"goodsMainphotoPath":@"goodsMainphotoPath",
			@"goodsTotalPrice":@"goodsTotalPrice",
			@"goodsCount":@"goodsCount"
             };
}

@end
