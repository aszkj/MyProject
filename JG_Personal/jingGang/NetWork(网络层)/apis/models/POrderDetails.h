//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"
#import "Pservice.h"

@interface POrderDetails : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//订单号
	@property (nonatomic, readonly, copy) NSString *orderId;
	//消费码
	@property (nonatomic, readonly, copy) NSString *groupSn;
	//购买人手机号码
	@property (nonatomic, readonly, copy) NSString *mobile;
	//支付方式
	@property (nonatomic, readonly, copy) NSString *paymentMark;
	//付款时间 
	@property (nonatomic, readonly, copy) NSDate *payTime;
	//订单总价格
	@property (nonatomic, readonly, copy) NSNumber *totalPrice;
	//结束时间
	@property (nonatomic, readonly, copy) NSDate *endTime;
	//用户昵称,非会员的就显示手机号码
	@property (nonatomic, readonly, copy) NSString *userNickname;
	//详细地址
	@property (nonatomic, readonly, copy) NSString *storeAddress;
	//店铺名称
	@property (nonatomic, readonly, copy) NSString *storeName;
	//店铺电话
	@property (nonatomic, readonly, copy) NSString *storeTelephone;
	//服务列表
	@property (nonatomic, readonly, copy) NSArray *serviceList;
	//订单状态|订单状态，0为订单取消，10为已提交待付款，20为已付款，30为买家已使用，全部使用后更新该值,50买家评价完毕 ,60卖家已评价,65订单不可评价
	@property (nonatomic, readonly, copy) NSNumber *orderStatus;
	//线下服务名称
	@property (nonatomic, readonly, copy) NSString *localGroupName;
	//距离
	@property (nonatomic, readonly, copy) NSNumber *distance;
	//纬度
	@property (nonatomic, readonly, copy) NSNumber *storeLat;
	//经度
	@property (nonatomic, readonly, copy) NSNumber *storeLon;
	//订单类型，1 线上订单  2 线下刷卡订单
	@property (nonatomic, readonly, copy) NSNumber *orderType;
	//服务id
	@property (nonatomic, readonly, copy) NSNumber *groupId;
	
@end
