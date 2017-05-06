//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopCoupon.h"

@implementation ShopCoupon
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"couponAmount":@"couponAmount",
			@"couponCount":@"couponCount",
			@"couponName":@"couponName",
			@"couponOrderAmount":@"couponOrderAmount",
			@"couponStatus":@"couponStatus",
			@"couponType":@"couponType",
			@"couponBeginTime":@"couponBeginTime",
			@"couponEndTime":@"couponEndTime",
			@"storeName":@"storeName"
             };
}

@end
