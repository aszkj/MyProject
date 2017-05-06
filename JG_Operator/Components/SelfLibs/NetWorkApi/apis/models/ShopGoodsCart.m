//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopGoodsCart.h"

@implementation ShopGoodsCart
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"subtotalPrice":@"subtotalPrice",
			@"storeSecondDomain":@"storeSecondDomain",
			@"specInfo":@"specInfo",
			@"goods":@"goods",
			@"count":@"count",
			@"price":@"price",
			@"whetherChooseGift":@"whetherChooseGift",
			@"exchangeIntegral":@"exchangeIntegral",
			@"goodsIntegralPrice":@"goodsIntegralPrice",
			@"goodsMobilePrice":@"goodsMobilePrice",
			@"selfAddPrice":@"selfAddPrice",
			@"goodsStoreId":@"goodsStoreId",
			@"storeName":@"storeName"
             };
}

+(NSValueTransformer *) goodsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Goods class]];
}
@end
