//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"
#import "GroupService.h"

@interface MyselfGroupOrder : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//服务图片
	@property (nonatomic, readonly, copy) NSString *groupAccPath;
	//服务名称
	@property (nonatomic, readonly, copy) NSString *ggName;
	//总价
	@property (nonatomic, readonly, copy) NSNumber *totalPrice;
	//状态|默认为0，使用后为1，过期为-1
	@property (nonatomic, readonly, copy) NSNumber *status;
	//订单状态  订单状态，0为订单取消，10为已提交待付款，20为已付款，30为买家已使用，全部使用后更新该值,50买家评价完毕 ,60卖家已评价,65订单不可评价
	@property (nonatomic, readonly, copy) NSNumber *orderStatus;
	//商品数量
	@property (nonatomic, readonly, copy) NSNumber *goodsCount;
	//groupInfo
	@property (nonatomic, readonly, copy) NSString *groupInfo;
	//服务信息
	@property (nonatomic, readonly, copy) GroupService *service;
	
@end
