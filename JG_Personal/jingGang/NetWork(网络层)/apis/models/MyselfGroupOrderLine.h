//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface MyselfGroupOrderLine : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//状态|默认为0，使用后为1，过期为-1，审核中为3，审核通过为5，审核不通过为6，退款完成为7
	@property (nonatomic, readonly, copy) NSNumber *status;
	//店铺名称
	@property (nonatomic, readonly, copy) NSString *storeName;
	//线下服务名称
	@property (nonatomic, readonly, copy) NSString *localGroupName;
	//订单总价格
	@property (nonatomic, readonly, copy) NSNumber *totalPrice;
	//订单状态  订单状态，0为订单取消，10为已提交待付款，20为已付款，30为买家已使用，全部使用后更新该值,50买家评价完毕 ,65订单不可评价，到达设定时间，系统自动关闭订单相互评价功能
	@property (nonatomic, readonly, copy) NSNumber *orderStatus;
	//线下服务退款状态|1为未退款   2为已退款
	@property (nonatomic, readonly, copy) NSNumber *localReturnStatus;
	//用户昵称,非会员的就显示手机号码 
	@property (nonatomic, readonly, copy) NSString *userNickname;
	//手机号码
	@property (nonatomic, readonly, copy) NSString *mobile;
	//订单号 
	@property (nonatomic, readonly, copy) NSString *orderId;
	//下单时间 
	@property (nonatomic, readonly, copy) NSDate *addTime;
	
@end
