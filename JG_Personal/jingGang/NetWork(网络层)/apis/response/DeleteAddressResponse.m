//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "DeleteAddressResponse.h"

@implementation DeleteAddressResponse
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
			@"userAddressAll":@"userAddressAll"
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
@end
