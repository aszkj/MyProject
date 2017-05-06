//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "AwayStore.h"

@implementation AwayStore
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"storeName":@"storeName",
			@"distance":@"distance",
			@"goodsName":@"goodsName",
			@"goodsPath":@"goodsPath",
			@"price":@"price",
			@"sales":@"sales",
			@"goodsId":@"goodsId"
             };
}

@end
