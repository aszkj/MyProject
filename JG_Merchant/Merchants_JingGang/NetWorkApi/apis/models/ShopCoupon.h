//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ShopCoupon : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//优惠券金额
	@property (nonatomic, readonly, copy) NSNumber *couponAmount;
	//优惠券发行数量
	@property (nonatomic, readonly, copy) NSNumber *couponCount;
	//优惠券名称
	@property (nonatomic, readonly, copy) NSString *couponName;
	//优惠券使用的订单金额，订单满足该金额时才可以使用该优惠券
	@property (nonatomic, readonly, copy) NSNumber *couponOrderAmount;
	
@end
