//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "GroupService.h"
#import "GroupInfo.h"

@interface GroupOrder : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, copy) NSNumber *apiId;
	//用户昵称
	@property (nonatomic, copy) NSString *nickName;
	//手机
	@property (nonatomic, copy) NSString *mobile;
	//消费码
	@property (nonatomic, copy) NSString *groupSn;
	//订单总价格
	@property (nonatomic, copy) NSNumber *totalPrice;
	//下单时间
	@property (nonatomic, copy) NSDate *addTime;
	//订单状态|0为订单取消，10为已提交待付款，20为已付款，30为买家已使用，全部使用后更新该值,50买家评价完毕 ,65订单不可评价
	@property (nonatomic, copy) NSNumber *orderStatus;
	//团购商品详情
	@property (nonatomic, copy) NSString *groupInfo;
	//线下服务退款状态|1为未退款   2为已退款
	@property (nonatomic, copy) NSNumber *localReturnStatus;
	//线下服务名称
	@property (nonatomic, copy) NSString *localGroupName;
	//订单号 
	@property (nonatomic, copy) NSString *orderId;
	//服务
	@property (nonatomic, copy) GroupService *groupService;
	//券列表
	@property (nonatomic, copy) NSArray *groupInfoBOs;
	//支付方式 
	@property (nonatomic, copy) NSString *paymentMark;
	
@end
