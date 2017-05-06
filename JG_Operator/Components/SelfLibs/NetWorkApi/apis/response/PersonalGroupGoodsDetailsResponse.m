//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "PersonalGroupGoodsDetailsResponse.h"

@implementation PersonalGroupGoodsDetailsResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"areaBO":@"areaBO",
			@"groupGoodsBOs":@"groupGoodsBOs",
			@"hotCityList":@"hotCityList",
			@"storeInfo":@"storeInfo"
             };
}

+(NSValueTransformer *) areaBOTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupArea class]];
}
+(NSValueTransformer *) groupGoodsBOsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[PGroupGoods class]];
}
+(NSValueTransformer *) hotCityListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupArea class]];
}
+(NSValueTransformer *) storeInfoTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[PGroup class]];
}
@end
