//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "ShopCouponInfo.h"

@interface UserCustomerCouponResponse :  AbstractResponse
//优惠券列表
@property (nonatomic, readonly, copy) NSArray *couponInfos;
//优惠券列表记录总数
@property (nonatomic, readonly, copy) NSNumber *userCouponCount;
@end
