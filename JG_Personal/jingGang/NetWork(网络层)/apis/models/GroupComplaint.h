//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface GroupComplaint : MTLModel <MTLJSONSerializing>

	//订单状态
	@property (nonatomic, readonly, copy) NSNumber *orderStatus;
	//订单编号
	@property (nonatomic, readonly, copy) NSString *orderId;
	//下单时间
	@property (nonatomic, readonly, copy) NSDate *payTime;
	//订单总额
	@property (nonatomic, readonly, copy) NSNumber *goodsAmount;
	//商户名称
	@property (nonatomic, readonly, copy) NSString *groupInfo;
	//商户电话
	@property (nonatomic, readonly, copy) NSString *storeTelephone;
	//地区id
	@property (nonatomic, readonly, copy) NSString *areaId;
	//商户所在址
	@property (nonatomic, readonly, copy) NSString *areaText;
	//商户详细地址
	@property (nonatomic, readonly, copy) NSString *storeAddress;
	//投诉人|买家名称
	@property (nonatomic, readonly, copy) NSString *name;
	//投诉状态
	@property (nonatomic, readonly, copy) NSString *status;
	//投诉人手机
	@property (nonatomic, readonly, copy) NSString *mobile;
	//投诉时间
	@property (nonatomic, readonly, copy) NSDate *addTime;
	//投诉id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//问题描述
	@property (nonatomic, readonly, copy) NSString *problemDesc;
	//投诉内容
	@property (nonatomic, readonly, copy) NSString *fromUserContent;
	//被投诉商户|服务商家
	@property (nonatomic, readonly, copy) NSString *storeName;
	//投诉证据1
	@property (nonatomic, readonly, copy) NSString *fromAcc1;
	//投诉证据2
	@property (nonatomic, readonly, copy) NSString *fromAcc2;
	//投诉证据3
	@property (nonatomic, readonly, copy) NSString *fromAcc3;
	//服务名称
	@property (nonatomic, readonly, copy) NSString *groupName;
	//服务图片
	@property (nonatomic, readonly, copy) NSString *groupPhoto;
	//服务价格
	@property (nonatomic, readonly, copy) NSNumber *price;
	//投诉证据数组
	@property (nonatomic, readonly, copy) NSArray *fromAccArry;
	//昵称
	@property (nonatomic, readonly, copy) NSString *nickname;
	//仲裁意见 
	@property (nonatomic, readonly, copy) NSString *handleContent;
	
@end
