//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface PayPage : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//云币余额
	@property (nonatomic, readonly, copy) NSNumber *availableBalance;
	//服务名称
	@property (nonatomic, readonly, copy) NSString *goodsName;
	//订单总价
	@property (nonatomic, readonly, copy) NSNumber *totalPrice;
	//订单号
	@property (nonatomic, readonly, copy) NSString *orderId;
	
@end
