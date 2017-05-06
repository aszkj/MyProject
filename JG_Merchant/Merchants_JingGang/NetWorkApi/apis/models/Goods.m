//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Goods.h"

@implementation Goods
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"goodsMainPhotoPath":@"goodsMainPhotoPath",
			@"goodsName":@"goodsName",
			@"goodsCurrentPrice":@"goodsCurrentPrice",
			@"storePrice":@"storePrice",
			@"hasExchangeIntegral":@"hasExchangeIntegral",
			@"goodsIntegralPrice":@"goodsIntegralPrice",
			@"hasMobilePrice":@"hasMobilePrice",
			@"goodsMobilePrice":@"goodsMobilePrice",
			@"goodsDetails":@"goodsDetails",
			@"packDetails":@"packDetails",
			@"descriptionEvaluate":@"descriptionEvaluate",
			@"goodsDetailsMobile":@"goodsDetailsMobile",
			@"goodsTransfee":@"goodsTransfee",
			@"goodsType":@"goodsType",
			@"detail":@"detail",
			@"property":@"property",
			@"cationList":@"cationList",
			@"ficPropertyList":@"ficPropertyList",
			@"goodsPhotosList":@"goodsPhotosList",
			@"goodsInventory":@"goodsInventory",
			@"exchangeIntegral":@"exchangeIntegral",
			@"goodsCod":@"goodsCod",
			@"goodsChoiceType":@"goodsChoiceType",
			@"taxInvoice":@"taxInvoice",
			@"goodsStoreId":@"goodsStoreId",
			@"goodsStoreName":@"goodsStoreName",
			@"storePhoto":@"storePhoto",
			@"goodsShowPrice":@"goodsShowPrice",
			@"mobilePrice":@"mobilePrice"
             };
}

+(NSValueTransformer *) detailTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GoodsInventoryDetail class]];
}
+(NSValueTransformer *) propertyTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GoodsProperty class]];
}
+(NSValueTransformer *) cationListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GoodsSpecification class]];
}
+(NSValueTransformer *) ficPropertyListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GoodsSpecProperty class]];
}
+(NSValueTransformer *) goodsPhotosListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ShopGoodsPhoto class]];
}
@end
