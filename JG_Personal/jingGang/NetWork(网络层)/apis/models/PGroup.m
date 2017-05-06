//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "PGroup.h"

@implementation PGroup
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"storeInfoBO":@"storeInfoBO",
			@"packageList":@"packageList",
			@"cashList":@"cashList"
             };
}

+(NSValueTransformer *) storeInfoBOTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[PStoreInfo class]];
}
+(NSValueTransformer *) packageListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[PGroupGoods class]];
}
+(NSValueTransformer *) cashListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[PGroupGoods class]];
}
@end
