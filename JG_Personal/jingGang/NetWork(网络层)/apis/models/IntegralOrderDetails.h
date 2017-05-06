//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"
#import "IGo.h"

@interface IntegralOrderDetails : MTLModel <MTLJSONSerializing>

	//订单id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//订单号
	@property (nonatomic, readonly, copy) NSString *igoOrderSn;
	//订单状态|0为已提交未付款，20为付款成功，30为已发货，40为已收货完成,-1为已经取消，此时不归还用户积分
	@property (nonatomic, readonly, copy) NSNumber *orderStatus;
	//订单状态
	@property (nonatomic, readonly, copy) NSString *status;
	//总共消费积分
	@property (nonatomic, readonly, copy) NSNumber *igoTotalIntegral;
	//购物车运费
	@property (nonatomic, readonly, copy) NSNumber *igoTransFee;
	//时间
	@property (nonatomic, readonly, copy) NSDate *addTime;
	//支付方式，使用mark标识 
	@property (nonatomic, readonly, copy) NSString *igoPayment;
	//支付方式
	@property (nonatomic, readonly, copy) NSString *payment;
	//支付时间
	@property (nonatomic, readonly, copy) NSDate *igoPayTime;
	//兑换附言 
	@property (nonatomic, readonly, copy) NSString *igoMsg;
	//收货人姓名,确认订单后，将买家的收货地址所有信息添加到订单中，该订单与买家收货地址没有任何关联 
	@property (nonatomic, readonly, copy) NSString *receiverName;
	//收货人地区,例如：辽宁省沈阳市铁西区 
	@property (nonatomic, readonly, copy) NSString *receiverArea;
	//收货人邮政编码  
	@property (nonatomic, readonly, copy) NSString *receiverZip;
	//收货人详细地址，例如：凌空二街56-1号，4单元2楼1号  
	@property (nonatomic, readonly, copy) NSString *receiverAreaInfo;
	//收货人联系电话 
	@property (nonatomic, readonly, copy) NSString *receiverTelephone;
	//收货人手机号码 
	@property (nonatomic, readonly, copy) NSString *receiverMobile;
	//物流公司信息
	@property (nonatomic, readonly, copy) NSString *igoExpressInfo;
	//物流公司信息
	@property (nonatomic, readonly, copy) NSString *expressInfo;
	//物流公司id
	@property (nonatomic, readonly, copy) NSString *expressCompanyId;
	//物流单号 
	@property (nonatomic, readonly, copy) NSString *igoShipCode;
	//发货时间 
	@property (nonatomic, readonly, copy) NSDate *igoShipTime;
	//发货说明
	@property (nonatomic, readonly, copy) NSString *igoShipContent;
	//礼品信息
	@property (nonatomic, readonly, copy) NSArray *igoList;
	
@end
