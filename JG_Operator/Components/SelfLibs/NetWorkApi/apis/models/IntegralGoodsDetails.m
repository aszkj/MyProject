//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IntegralGoodsDetails.h"

@implementation IntegralGoodsDetails
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"igBeginTime":@"igBeginTime",
			@"igEndTime":@"igEndTime",
			@"igExchangeCount":@"igExchangeCount",
			@"igGoodsCount":@"igGoodsCount",
			@"igGoodsIntegral":@"igGoodsIntegral",
			@"igGoodsName":@"igGoodsName",
			@"igGoodsPrice":@"igGoodsPrice",
			@"igGoodsSn":@"igGoodsSn",
			@"igTransfee":@"igTransfee",
			@"igTransfeeType":@"igTransfeeType",
			@"igUserLevel":@"igUserLevel",
			@"igGoodsImg":@"igGoodsImg",
			@"igContent":@"igContent",
			@"igTimeType":@"igTimeType"
             };
}

@end
