//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "SalePromotionActivityAdGoodsInfoListResponse.h"

@implementation SalePromotionActivityAdGoodsInfoListResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"goodsList":@"goodsList"
             };
}

+(NSValueTransformer *) goodsListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ActHotSaleGoodsInfoApiBO class]];
}
@end
