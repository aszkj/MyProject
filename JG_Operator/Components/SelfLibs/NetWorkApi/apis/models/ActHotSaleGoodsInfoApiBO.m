//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ActHotSaleGoodsInfoApiBO.h"

@implementation ActHotSaleGoodsInfoApiBO
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"goodsMobilePrice":@"goodsMobilePrice",
			@"goodsCurrentPrice":@"goodsCurrentPrice",
			@"goodsPrice":@"goodsPrice",
			@"adTitle":@"adTitle",
			@"adImgPath":@"adImgPath",
			@"goodsSalenum":@"goodsSalenum",
			@"goodsInventory":@"goodsInventory"
             };
}

@end
