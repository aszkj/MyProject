//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "SelfEvaluateListResponse.h"

@implementation SelfEvaluateListResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"orderList":@"orderList",
			@"selfOrder":@"selfOrder",
			@"selfEvaluate":@"selfEvaluate",
			@"selfFavaGoodsList":@"selfFavaGoodsList",
			@"selfStroeList":@"selfStroeList"
             };
}

+(NSValueTransformer *) orderListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[SelfOrder class]];
}
+(NSValueTransformer *) selfOrderTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OrderForfDetail class]];
}
+(NSValueTransformer *) selfEvaluateTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[EvaluatePage class]];
}
+(NSValueTransformer *) selfFavaGoodsListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Goods class]];
}
+(NSValueTransformer *) selfStroeListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[FavaStore class]];
}
@end
