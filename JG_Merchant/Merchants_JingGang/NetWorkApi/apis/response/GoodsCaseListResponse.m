//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "GoodsCaseListResponse.h"

@implementation GoodsCaseListResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"goodsCaseList":@"goodsCaseList",
			@"goodsList":@"goodsList",
			@"goodsClassList":@"goodsClassList",
			@"goodsLikeList":@"goodsLikeList",
			@"totalSize":@"totalSize",
			@"storeInfo":@"storeInfo",
			@"youLikelist":@"youLikelist"
             };
}

+(NSValueTransformer *) goodsCaseListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GoodsCase class]];
}
+(NSValueTransformer *) goodsListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Goods class]];
}
+(NSValueTransformer *) goodsClassListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GoodsClass class]];
}
+(NSValueTransformer *) goodsLikeListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Goods class]];
}
+(NSValueTransformer *) storeInfoTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ShopStore class]];
}
+(NSValueTransformer *) youLikelistTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Goods class]];
}
@end
