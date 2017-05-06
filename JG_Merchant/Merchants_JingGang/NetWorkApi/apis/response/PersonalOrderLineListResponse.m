//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "PersonalOrderLineListResponse.h"

@implementation PersonalOrderLineListResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"areaBO":@"areaBO",
			@"groupGoodsBOs":@"groupGoodsBOs",
			@"hotCityList":@"hotCityList",
			@"storeInfo":@"storeInfo",
			@"youLikeGoods":@"youLikeGoods",
			@"myselfOrderList":@"myselfOrderList",
			@"myselfOrderLineList":@"myselfOrderLineList",
			@"orderDetails":@"orderDetails",
			@"groupGoods":@"groupGoods",
			@"payPage":@"payPage"
             };
}

+(NSValueTransformer *) areaBOTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupArea class]];
}
+(NSValueTransformer *) groupGoodsBOsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[PGroupGoods class]];
}
+(NSValueTransformer *) hotCityListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupArea class]];
}
+(NSValueTransformer *) storeInfoTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[PGroup class]];
}
+(NSValueTransformer *) youLikeGoodsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupGoods class]];
}
+(NSValueTransformer *) myselfOrderListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[MyselfGroupOrder class]];
}
+(NSValueTransformer *) myselfOrderLineListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[MyselfGroupOrderLine class]];
}
+(NSValueTransformer *) orderDetailsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[POrderDetails class]];
}
+(NSValueTransformer *) groupGoodsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[PGroupGoods class]];
}
+(NSValueTransformer *) payPageTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[PayPage class]];
}
@end
