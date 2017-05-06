//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Search.h"

@implementation Search
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"searchGoodsList":@"searchGoodsList",
			@"classBO":@"classBO",
			@"shopgoodsProperty":@"shopgoodsProperty"
             };
}

+(NSValueTransformer *) searchGoodsListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ShopSearchGoods class]];
}
+(NSValueTransformer *) classBOTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ShopGoodsClass class]];
}
+(NSValueTransformer *) shopgoodsPropertyTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ShopGoodsTypeProperty class]];
}
@end
