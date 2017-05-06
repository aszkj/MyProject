//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopGoodsType.h"

@implementation ShopGoodsType
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"goodBrandList":@"goodBrandList"
             };
}

+(NSValueTransformer *) goodBrandListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ShopGoodsBrand class]];
}
@end
