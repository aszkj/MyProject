//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopGoodsClass.h"

@implementation ShopGoodsClass
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"goodsType":@"goodsType"
             };
}

+(NSValueTransformer *) goodsTypeTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ShopGoodsType class]];
}
@end
