//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "SnsRecommenGoodsAndStoreListResponse.h"

@implementation SnsRecommenGoodsAndStoreListResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"groupId":@"groupId",
			@"checkResult":@"checkResult",
			@"integral":@"integral",
			@"recommedGoodsList":@"recommedGoodsList",
			@"recommedStoreList":@"recommedStoreList",
			@"resultId":@"resultId",
			@"getDayIntegralFlag":@"getDayIntegralFlag"
             };
}

+(NSValueTransformer *) recommedGoodsListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[RecommendGoods class]];
}
+(NSValueTransformer *) recommedStoreListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[RecommendStore class]];
}
@end
