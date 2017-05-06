//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"
#import "GroupService.h"

@interface OrderDetails : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//昵称
	@property (nonatomic, readonly, copy) NSString *nickname;
	//手机号码
	@property (nonatomic, readonly, copy) NSString *mobile;
	//消费码
	@property (nonatomic, readonly, copy) NSString *groupSn;
	//下单时间
	@property (nonatomic, readonly, copy) NSDate *addTime;
	//订单总价格 
	@property (nonatomic, readonly, copy) NSNumber *totalPrice;
	//groupInfo
	@property (nonatomic, readonly, copy) NSString *groupInfo;
	//服务
	@property (nonatomic, readonly, copy) GroupService *groupService;
	//用户昵称,非会员的就显示手机号码
	@property (nonatomic, readonly, copy) NSString *userNickname;
	//线下服务名称 
	@property (nonatomic, readonly, copy) NSString *localGroupName;
	//消费码价格
	@property (nonatomic, readonly, copy) NSNumber *groupPrice;
	//收益
	@property (nonatomic, readonly, copy) NSNumber *profitPrice;
	//买家id
	@property (nonatomic, readonly, copy) NSNumber *userId;
	//返润比例
	@property (nonatomic, readonly, copy) NSNumber *proportion;
	
@end
