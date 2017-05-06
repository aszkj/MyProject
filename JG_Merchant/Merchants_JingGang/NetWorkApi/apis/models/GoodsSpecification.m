//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "GoodsSpecification.h"

@implementation GoodsSpecification
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"name":@"name",
			@"specType":@"specType",
			@"type":@"type",
			@"goodsClassId":@"goodsClassId",
			@"storeId":@"storeId",
			@"specProperties":@"specProperties",
			@"properties":@"properties"
             };
}

+(NSValueTransformer *) specPropertiesTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GoodsSpecProperty class]];
}
+(NSValueTransformer *) propertiesTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GoodsSpecProperty class]];
}
@end
