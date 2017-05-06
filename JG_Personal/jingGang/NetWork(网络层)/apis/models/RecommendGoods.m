//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "RecommendGoods.h"

@implementation RecommendGoods
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"mainPhotoUrl":@"mainPhotoUrl",
			@"photosUrl":@"photosUrl",
			@"title":@"title",
			@"content":@"content",
			@"type":@"type",
			@"goodsSalenum":@"goodsSalenum",
			@"goodsCollect":@"goodsCollect",
			@"wellEvaluate":@"wellEvaluate",
			@"storePrice":@"storePrice",
			@"goodsInventory":@"goodsInventory",
			@"goodsType":@"goodsType",
			@"goodsEvas":@"goodsEvas",
			@"goodsBrandname":@"goodsBrandname",
			@"goodsCod":@"goodsCod",
			@"goodsTransfee":@"goodsTransfee",
			@"hasMobilePrice":@"hasMobilePrice",
			@"hasExchangeIntegral":@"hasExchangeIntegral",
			@"mobilePrice":@"mobilePrice"
             };
}

@end
