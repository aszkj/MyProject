//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "GoodsInfo.h"
#import "Goods.h"

@interface SelfOrder : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//订单号
	@property (nonatomic, readonly, copy) NSString *orderId;
	//子订单
	@property (nonatomic, readonly, copy) NSString *childOrderDetail;
	//订单状态  订单状态，0为订单取消，10为已提交待付款，15为线下付款提交申请，16为货到付款，20为已付款待发货，30为已发货待收货，40为已收货，50买家评价完毕 ,65订单不可评价，到达设定时间，系统自动关闭订单相互评价功能
	@property (nonatomic, readonly, copy) NSNumber *orderStatus;
	//配送价格 
	@property (nonatomic, readonly, copy) NSNumber *shipPrice;
	//商品信息
	@property (nonatomic, readonly, copy) Goods *goods;
	//收货人姓名
	@property (nonatomic, readonly, copy) NSString *receiverName;
	//收货人地区 
	@property (nonatomic, readonly, copy) NSString *receiverArea;
	//收货人详细地址
	@property (nonatomic, readonly, copy) NSString *receiverAreaInfo;
	//商品信息
	@property (nonatomic, readonly, copy) NSArray *goodsInfos;
	//订单商品详情 订单商品信息
	@property (nonatomic, readonly, copy) NSString *goodsInfo;
	//订单总价
	@property (nonatomic, readonly, copy) NSNumber *totalPrice;
	//收货人手机号码
	@property (nonatomic, readonly, copy) NSString *receiverMobile;
	//订单对应店铺id
	@property (nonatomic, readonly, copy) NSString *storeId;
	//订单对应店铺名称
	@property (nonatomic, readonly, copy) NSString *storeName;
	//优惠券金额
	@property (nonatomic, readonly, copy) NSNumber *couponAmount;
	//下单时间
	@property (nonatomic, readonly, copy) NSDate *addTime;
	//商品总价格
	@property (nonatomic, readonly, copy) NSNumber *goodsAmount;
	//快递公司id
	@property (nonatomic, readonly, copy) NSNumber *expressCompanyId;
	//物流单号
	@property (nonatomic, readonly, copy) NSString *shipCode;
	//订单种类 0为商家，1为自营商品订单
	@property (nonatomic, readonly, copy) NSNumber *orderForm;
	//支付方式
	@property (nonatomic, readonly, copy) NSString *payWay;
	
@end
