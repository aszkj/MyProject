//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "GoodsDetailsResponse.h"

@implementation GoodsDetailsResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"goodsDetails":@"goodsDetails",
			@"shopEvaluateList":@"shopEvaluateList",
			@"goodsConsultList":@"goodsConsultList",
			@"totalSize":@"totalSize"
             };
}

+(NSValueTransformer *) goodsDetailsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Goods class]];
}
+(NSValueTransformer *) shopEvaluateListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ShopEvaluate class]];
}
+(NSValueTransformer *) goodsConsultListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GoodsConsult class]];
}
@end
