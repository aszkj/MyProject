//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface OperatorProfit : MTLModel <MTLJSONSerializing>

	//注册返润收益|辖区返润收益|隶属返润收益|支付手续收益
	@property (nonatomic, readonly, copy) NSNumber *profitAmount;
	//推荐运营商|本辖本消|本隶本消|隶属支付
	@property (nonatomic, readonly, copy) NSNumber *recommedAmount;
	//推荐商户|本辖外销|本隶外消|辖区支付
	@property (nonatomic, readonly, copy) NSNumber *storeAmount;
	//推荐会员|外辖本消|外隶本消|推荐收益
	@property (nonatomic, readonly, copy) NSNumber *userAmount;
	//类型|1注册返润2辖区返润3隶属返润4支付手续
	@property (nonatomic, readonly, copy) NSNumber *type;
	//推荐购买分润
	@property (nonatomic, readonly, copy) NSNumber *rcRebate;
	//推荐产品分润
	@property (nonatomic, readonly, copy) NSNumber *rsRebate;
	
@end
