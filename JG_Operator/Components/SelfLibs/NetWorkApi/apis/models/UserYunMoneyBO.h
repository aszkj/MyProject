//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface UserYunMoneyBO : MTLModel <MTLJSONSerializing>

	//操作类型，分为充值、提现、消费、兑换金币、人工操作
	@property (nonatomic, readonly, copy) NSString *pdOpType;
	//添加时间
	@property (nonatomic, readonly, copy) NSDate *addTime;
	//金额
	@property (nonatomic, readonly, copy) NSNumber *pdLogAmount;
	//云币详情描述
	@property (nonatomic, readonly, copy) NSString *pdLogInfo;
	
@end
