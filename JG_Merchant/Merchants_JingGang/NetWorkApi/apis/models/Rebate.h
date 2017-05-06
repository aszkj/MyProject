//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Rebate : MTLModel <MTLJSONSerializing>

	//分润总收入
	@property (nonatomic, readonly, copy) NSNumber *totalRebateAmout;
	//分润金额
	@property (nonatomic, readonly, copy) NSNumber *rebateAmount;
	//年
	@property (nonatomic, readonly, copy) NSNumber *years;
	//月
	@property (nonatomic, readonly, copy) NSNumber *months;
	//线下服务名称
	@property (nonatomic, readonly, copy) NSString *localGroupName;
	//消费者昵称
	@property (nonatomic, readonly, copy) NSString *nickname;
	//消费者电话
	@property (nonatomic, readonly, copy) NSString *mobile;
	//消费码
	@property (nonatomic, readonly, copy) NSString *groupSn;
	//如果是会员则是昵称否则电话号码
	@property (nonatomic, readonly, copy) NSString *userNickName;
	//创建时间
	@property (nonatomic, readonly, copy) NSDate *createTime;
	//月总收入
	@property (nonatomic, readonly, copy) NSNumber *monthTotalPrice;
	//服务名称
	@property (nonatomic, readonly, copy) NSString *ggName;
	//分润类型
	@property (nonatomic, readonly, copy) NSString *rabate;
	//返利类型
	@property (nonatomic, readonly, copy) NSString *rebateType;
	
@end
