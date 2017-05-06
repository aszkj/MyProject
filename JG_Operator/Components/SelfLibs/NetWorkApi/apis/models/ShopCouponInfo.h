//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "ShopCoupon.h"

@interface ShopCouponInfo : MTLModel <MTLJSONSerializing>

	//优惠券id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//优惠券信息
	@property (nonatomic, readonly, copy) ShopCoupon *coupon;
	
@end
