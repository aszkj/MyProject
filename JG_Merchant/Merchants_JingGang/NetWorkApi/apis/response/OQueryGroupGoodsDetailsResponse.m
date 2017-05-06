//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "OQueryGroupGoodsDetailsResponse.h"

@implementation OQueryGroupGoodsDetailsResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"merchant":@"merchant",
			@"groupOrderList":@"groupOrderList",
			@"groupOrderBO":@"groupOrderBO",
			@"groupGoodsBOs":@"groupGoodsBOs"
             };
}

+(NSValueTransformer *) merchantTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Merchant class]];
}
+(NSValueTransformer *) groupOrderListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupOrder class]];
}
+(NSValueTransformer *) groupOrderBOTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupOrder class]];
}
+(NSValueTransformer *) groupGoodsBOsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupGoods class]];
}
@end
