//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "SearchClassGoodsResponse.h"

@implementation SearchClassGoodsResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"searchGoodsList":@"searchGoodsList",
			@"keywordGoodsList":@"keywordGoodsList",
			@"hotKey":@"hotKey"
             };
}

+(NSValueTransformer *) searchGoodsListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Search class]];
}
+(NSValueTransformer *) keywordGoodsListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ShopLuceneResult class]];
}
@end
