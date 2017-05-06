//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "PersonalAreaParentListResponse.h"

@implementation PersonalAreaParentListResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"areaListBos":@"areaListBos",
			@"searchStoreList":@"searchStoreList",
			@"keyWordList":@"keyWordList",
			@"areaList":@"areaList",
			@"isEvaluation":@"isEvaluation",
			@"service":@"service",
			@"favaStoreList":@"favaStoreList",
			@"recommStoreInfo":@"recommStoreInfo",
			@"awayStoreList":@"awayStoreList",
			@"youLike":@"youLike",
			@"favaList":@"favaList",
			@"hotSearch":@"hotSearch"
             };
}

+(NSValueTransformer *) areaListBosTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupArea class]];
}
+(NSValueTransformer *) searchStoreListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[StoreSearch class]];
}
+(NSValueTransformer *) keyWordListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[StoreSearch class]];
}
+(NSValueTransformer *) areaListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupArea class]];
}
+(NSValueTransformer *) serviceTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupService class]];
}
+(NSValueTransformer *) favaStoreListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupStoreFava class]];
}
+(NSValueTransformer *) recommStoreInfoTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[RecommStoreInfo class]];
}
+(NSValueTransformer *) awayStoreListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AwayStore class]];
}
+(NSValueTransformer *) youLikeTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupGoods class]];
}
+(NSValueTransformer *) favaListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[FavaGroupGoods class]];
}
@end
