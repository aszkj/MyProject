//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "StoreCommonInfo.h"

@implementation StoreCommonInfo
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"className":@"className",
			@"appIcon":@"appIcon",
			@"childs":@"childs"
             };
}

+(NSValueTransformer *) childsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GoodsClass class]];
}
@end
