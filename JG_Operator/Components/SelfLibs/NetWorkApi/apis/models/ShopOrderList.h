//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "ShopTransPort.h"
#import "ShopStore.h"
#import "ShopCouponInfo.h"
#import "ShopGoodsCart.h"

@interface ShopOrderList : MTLModel <MTLJSONSerializing>

	//商品商铺对象
	@property (nonatomic, readonly, copy) ShopStore *shopStore;
	//商品列表
	@property (nonatomic, readonly, copy) NSArray *goodsCartList;
	//是否支持货到付款|true支持，false不支持
	@property (nonatomic, readonly, copy) NSNumber *goodsCod;
	//默认可以开具增值税发票|1可以
	@property (nonatomic, readonly, copy) NSNumber *taxInvoice;
	//运送方式
	@property (nonatomic, readonly, copy) NSArray *transList;
	//优惠券
	@property (nonatomic, readonly, copy) NSArray *couponInfoList;
	
@end
