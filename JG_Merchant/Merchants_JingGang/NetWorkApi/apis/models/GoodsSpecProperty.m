//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "GoodsSpecProperty.h"

@implementation GoodsSpecProperty
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"spec":@"spec",
			@"apiId":@"id",
			@"specId":@"specId",
			@"specImageId":@"specImageId",
			@"value":@"value"
             };
}

+(NSValueTransformer *) specTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GoodsSpecification class]];
}
@end
