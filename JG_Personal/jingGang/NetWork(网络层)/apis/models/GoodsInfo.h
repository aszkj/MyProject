//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface GoodsInfo : MTLModel <MTLJSONSerializing>

	//商品价格
	@property (nonatomic, readonly, copy) NSNumber *goodsPrice;
	//商品快照
	@property (nonatomic, readonly, copy) NSString *goodsSnapshoot;
	//商品规格
	@property (nonatomic, readonly, copy) NSString *goodsGspVal;
	//商品总价
	@property (nonatomic, readonly, copy) NSNumber *goodsAllPrice;
	//商品id
	@property (nonatomic, readonly, copy) NSNumber *goodsId;
	//商品类型
	@property (nonatomic, readonly, copy) NSNumber *goodsType;
	//商品名称
	@property (nonatomic, readonly, copy) NSString *goodsName;
	//商品主图
	@property (nonatomic, readonly, copy) NSString *goodsDomainPath;
	//商品是否实体  0实体商品，1为虚拟商品
	@property (nonatomic, readonly, copy) NSString *goodsChoiceType;
	//商品主图片
	@property (nonatomic, readonly, copy) NSString *goodsMainphotoPath;
	//goodsGspIds
	@property (nonatomic, readonly, copy) NSString *goodsGspIds;
	//goodsPayoffPrice
	@property (nonatomic, readonly, copy) NSString *goodsPayoffPrice;
	//goodsCommissionPrice
	@property (nonatomic, readonly, copy) NSString *goodsCommissionPrice;
	//goodsCommissionRate
	@property (nonatomic, readonly, copy) NSString *goodsCommissionRate;
	//storeDomainPath
	@property (nonatomic, readonly, copy) NSString *storeDomainPath;
	//商品数量
	@property (nonatomic, readonly, copy) NSNumber *goodsCount;
	//退货商品状态|-2为超过退货时间未能输入退货物流 -1为申请被拒绝，1为可以退货 5为退货申请中 6为审核通过可进行退货 7为退货中，10为退货完成,等待退款，11为平台退款完成
	@property (nonatomic, readonly, copy) NSString *goodsReturnStatus;
	//手机专享价
	@property (nonatomic, readonly, copy) NSNumber *goodsMobilePrice;
	//积分价
	@property (nonatomic, readonly, copy) NSNumber *goodsIntegralPrice;
	
@end
