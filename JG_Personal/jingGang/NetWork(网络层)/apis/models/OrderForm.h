//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"
#import "GoodsInfo.h"

@interface OrderForm : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//商品总价格
	@property (nonatomic, readonly, copy) NSNumber *goodsAmount;
	//订单种类 0为商家，1为自营商品订单
	@property (nonatomic, readonly, copy) NSNumber *orderForm;
	//订单号
	@property (nonatomic, readonly, copy) NSString *orderId;
	//订单状态
	@property (nonatomic, readonly, copy) NSNumber *orderStatus;
	//订单对应店铺名称
	@property (nonatomic, readonly, copy) NSString *storeName;
	//订单对应店铺id
	@property (nonatomic, readonly, copy) NSString *storeId;
	//订单总价格
	@property (nonatomic, readonly, copy) NSNumber *totalPrice;
	//订单商品信息对象
	@property (nonatomic, readonly, copy) NSArray *infoList;
	
@end
