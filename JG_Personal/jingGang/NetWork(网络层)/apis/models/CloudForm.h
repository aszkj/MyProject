//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface CloudForm : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//创建时间
	@property (nonatomic, readonly, copy) NSDate *addTime;
	//删除状态
	@property (nonatomic, readonly, copy) NSNumber *deleteStatus;
	//收款账号
	@property (nonatomic, readonly, copy) NSString *cashAccount;
	//提现金额
	@property (nonatomic, readonly, copy) NSNumber *cashAmount;
	//收款银行
	@property (nonatomic, readonly, copy) NSString *cashBank;
	//收款支付状态，0为等待支付，1为支付完成 
	@property (nonatomic, readonly, copy) NSNumber *cashPayStatus;
	//提现方式
	@property (nonatomic, readonly, copy) NSString *cashPayment;
	//提现编号以cash开头
	@property (nonatomic, readonly, copy) NSString *cashSn;
	//提现状态 0为审核中，1为已经完成, -1为审核拒绝
	@property (nonatomic, readonly, copy) NSNumber *cashStatus;
	//收款人姓名
	@property (nonatomic, readonly, copy) NSString *cashUserName;
	//充值请求处理的管理员 
	@property (nonatomic, readonly, copy) NSNumber *cashAdminId;
	//申请用户
	@property (nonatomic, readonly, copy) NSNumber *cashUserId;
	//请求处理备注
	@property (nonatomic, readonly, copy) NSString *cashAdminInfo;
	//提现备注
	@property (nonatomic, readonly, copy) NSString *cashInfo;
	//银行支行
	@property (nonatomic, readonly, copy) NSString *cashSubbranch;
	//提现类型0,web端1,APP端
	@property (nonatomic, readonly, copy) NSNumber *cashRelation;
	
@end
