//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Trans.h"

@implementation Trans
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"storeId":@"storeId",
			@"trans":@"trans"
             };
}

+(NSValueTransformer *) transTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ShopTransPort class]];
}
@end
