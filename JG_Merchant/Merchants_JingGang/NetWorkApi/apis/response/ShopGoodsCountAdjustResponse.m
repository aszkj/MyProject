//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopGoodsCountAdjustResponse.h"

@implementation ShopGoodsCountAdjustResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"cartList":@"cartList",
			@"gcId":@"gcId",
			@"totalPrice":@"totalPrice",
			@"orderList":@"orderList",
			@"userAddressAll":@"userAddressAll",
			@"defaultAddress":@"defaultAddress",
			@"trans":@"trans",
			@"shopCartSize":@"shopCartSize"
             };
}

+(NSValueTransformer *) cartListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ShopGoodsCart class]];
}
+(NSValueTransformer *) orderListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ShopOrderListDetail class]];
}
+(NSValueTransformer *) userAddressAllTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ShopUserAddress class]];
}
+(NSValueTransformer *) defaultAddressTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ShopUserAddress class]];
}
+(NSValueTransformer *) transTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Trans class]];
}
@end
