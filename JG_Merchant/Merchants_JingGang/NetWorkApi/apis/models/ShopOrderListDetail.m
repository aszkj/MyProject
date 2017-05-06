//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopOrderListDetail.h"

@implementation ShopOrderListDetail
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"shopUserAddress":@"shopUserAddress",
			@"orderList":@"orderList"
             };
}

+(NSValueTransformer *) shopUserAddressTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ShopUserAddress class]];
}
+(NSValueTransformer *) orderListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ShopOrderList class]];
}
@end
