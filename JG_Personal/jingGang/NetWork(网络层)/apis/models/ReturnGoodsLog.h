//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface ReturnGoodsLog : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//申请时间
	@property (nonatomic, readonly, copy) NSDate *addTime;
	//快递号
	@property (nonatomic, readonly, copy) NSString *expressCode;
	//快递公司名称
	@property (nonatomic, readonly, copy) NSString *expressCompanyName;
	//快递公司 id
	@property (nonatomic, readonly, copy) NSNumber *expressCompanyId;
	//商品总价格
	@property (nonatomic, readonly, copy) NSString *goodsAllPrice;
	//退货的商品id
	@property (nonatomic, readonly, copy) NSNumber *goodsId;
	//退货的商品 sku ids
	@property (nonatomic, readonly, copy) NSString *goodsGspIds;
	// 商品图片路径 
	@property (nonatomic, readonly, copy) NSString *goodsMainphotoPath;
	//商品的名称
	@property (nonatomic, readonly, copy) NSString *goodsName;
	//商品价格
	@property (nonatomic, readonly, copy) NSString *goodsPrice;
	//退货商品状态 -2为超过退货时间未能输入退货物流 -1为申请被拒绝，1为可以退货 5为退货申请中 6为审核通过可进行退货 7为退货中，10为退货完成,等待退款，11为平台退款完成
	@property (nonatomic, readonly, copy) NSString *goodsReturnStatus;
	//商品的类型 0为自营 1为第三方经销商
	@property (nonatomic, readonly, copy) NSNumber *goodsType;
	//退款状态 0为未退款 1为退款完成
	@property (nonatomic, readonly, copy) NSNumber *refundStatus;
	//退货描述
	@property (nonatomic, readonly, copy) NSString *returnContent;
	//商品对应的订单id 
	@property (nonatomic, readonly, copy) NSNumber *returnOrderId;
	//退货服务单号
	@property (nonatomic, readonly, copy) NSString *returnServiceId;
	//收货时向买家发送的收货地址，买家通过此将货物发送给卖家
	@property (nonatomic, readonly, copy) NSString *selfAddress;
	//商品对应的店铺id
	@property (nonatomic, readonly, copy) NSNumber *storeId;
	
@end
