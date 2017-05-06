//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

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
	//优惠券信息状态，默认为0，,使用后为1,-1为过期
	@property (nonatomic, readonly, copy) NSNumber *couponStatus;
	//优惠券类型，0为平台优惠券，抵消自营商品订单金额，1为商家优惠券，抵消订单中该商家商品部分金额
	@property (nonatomic, readonly, copy) NSNumber *couponType;
	//优惠券使用开始时间
	@property (nonatomic, readonly, copy) NSDate *couponBeginTime;
	//优惠券使用结束时间
	@property (nonatomic, readonly, copy) NSDate *couponEndTime;
	//店铺名称
	@property (nonatomic, readonly, copy) NSString *storeName;
	
@end
