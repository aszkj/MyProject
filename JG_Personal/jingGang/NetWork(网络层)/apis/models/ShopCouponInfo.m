//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopCouponInfo.h"

@implementation ShopCouponInfo
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"coupon":@"coupon"
             };
}

+(NSValueTransformer *) couponTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ShopCoupon class]];
}
@end
