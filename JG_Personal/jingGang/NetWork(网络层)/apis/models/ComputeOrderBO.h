//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface ComputeOrderBO : MTLModel <MTLJSONSerializing>

	//总共需要消费的积分
	@property (nonatomic, readonly, copy) NSNumber *totalIntegral;
	//总共需要支付的邮费
	@property (nonatomic, readonly, copy) NSNumber *totalTransportFee;
	//用户当前剩余的积分
	@property (nonatomic, readonly, copy) NSNumber *userIntegral;
	
@end
