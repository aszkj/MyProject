//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopGoodsPhoto.h"

@implementation ShopGoodsPhoto
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"accessory":@"accessory"
             };
}

+(NSValueTransformer *) accessoryTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ShopAccessory class]];
}
@end
