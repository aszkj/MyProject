//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopOrderList.h"

@implementation ShopOrderList
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"shopStore":@"shopStore",
			@"goodsCartList":@"goodsCartList",
			@"goodsCod":@"goodsCod",
			@"taxInvoice":@"taxInvoice",
			@"transList":@"transList",
			@"couponInfoList":@"couponInfoList"
             };
}

+(NSValueTransformer *) shopStoreTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ShopStore class]];
}
+(NSValueTransformer *) goodsCartListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ShopGoodsCart class]];
}
+(NSValueTransformer *) transListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ShopTransPort class]];
}
+(NSValueTransformer *) couponInfoListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ShopCouponInfo class]];
}
@end
