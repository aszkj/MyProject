//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UserCustomerCouponResponse.h"

@implementation UserCustomerCouponResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"couponInfos":@"couponInfos",
			@"userCouponCount":@"userCouponCount"
             };
}

+(NSValueTransformer *) couponInfosTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ShopCouponInfo class]];
}
@end
