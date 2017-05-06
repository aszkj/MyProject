//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IntegralListBO.h"

@implementation IntegralListBO
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"igGoodsIntegral":@"igGoodsIntegral",
			@"igGoodsName":@"igGoodsName",
			@"igGoodsImg":@"igGoodsImg"
             };
}

@end
