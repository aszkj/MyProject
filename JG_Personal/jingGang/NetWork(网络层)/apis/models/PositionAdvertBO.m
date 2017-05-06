//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "PositionAdvertBO.h"

@implementation PositionAdvertBO
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"itemId":@"itemId",
			@"adText":@"adText",
			@"adTitle":@"adTitle",
			@"adUrl":@"adUrl",
			@"adType":@"adType",
			@"adImgPath":@"adImgPath",
			@"timeStamp":@"timeStamp",
			@"invitation":@"invitation",
			@"information":@"information",
			@"shopGoods":@"shopGoods",
			@"shopStore":@"shopStore",
			@"pGroupGoods":@"pGroupGoods",
			@"pStoreInfo":@"pStoreInfo",
			@"nativeType":@"nativeType",
			@"goodsCurrentPrice":@"goodsCurrentPrice",
			@"goodsMobilePrice":@"goodsMobilePrice",
			@"goodsName":@"goodsName",
			@"hasMobilePrice":@"hasMobilePrice"
             };
}

+(NSValueTransformer *) invitationTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[CircleInvitation class]];
}
+(NSValueTransformer *) informationTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[InformationBO class]];
}
+(NSValueTransformer *) shopGoodsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Goods class]];
}
+(NSValueTransformer *) shopStoreTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ShopStore class]];
}
+(NSValueTransformer *) pGroupGoodsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[PGroupGoods class]];
}
+(NSValueTransformer *) pStoreInfoTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[PStoreInfo class]];
}
@end
