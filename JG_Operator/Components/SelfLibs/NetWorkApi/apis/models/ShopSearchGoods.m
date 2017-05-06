//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopSearchGoods.h"

@implementation ShopSearchGoods
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"goodsName":@"goodsName",
			@"goodsMainPhotoPath":@"goodsMainPhotoPath",
			@"hasExchangeIntegral":@"hasExchangeIntegral",
			@"goodsIntegralPrice":@"goodsIntegralPrice",
			@"hasMobilePrice":@"hasMobilePrice",
			@"goodsMobilePrice":@"goodsMobilePrice",
			@"goodsCurrentPrice":@"goodsCurrentPrice",
			@"exchangeIntegral":@"exchangeIntegral",
			@"goodsShowPrice":@"goodsShowPrice",
			@"mobilePrice":@"mobilePrice"
             };
}

@end
