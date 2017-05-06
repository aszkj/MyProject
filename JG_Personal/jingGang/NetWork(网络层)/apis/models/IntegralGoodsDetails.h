//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface IntegralGoodsDetails : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//兑换开始时间
	@property (nonatomic, readonly, copy) NSDate *igBeginTime;
	//兑换结束时间
	@property (nonatomic, readonly, copy) NSDate *igEndTime;
	//礼品兑出数量
	@property (nonatomic, readonly, copy) NSNumber *igExchangeCount;
	//礼品库存数量
	@property (nonatomic, readonly, copy) NSNumber *igGoodsCount;
	//礼品兑换积分
	@property (nonatomic, readonly, copy) NSNumber *igGoodsIntegral;
	//礼品名称
	@property (nonatomic, readonly, copy) NSString *igGoodsName;
	//礼品原价
	@property (nonatomic, readonly, copy) NSNumber *igGoodsPrice;
	//礼品编号 
	@property (nonatomic, readonly, copy) NSString *igGoodsSn;
	//运费 
	@property (nonatomic, readonly, copy) NSNumber *igTransfee;
	//运费承担方式，0为卖家承担，1为买家承担
	@property (nonatomic, readonly, copy) NSNumber *igTransfeeType;
	//礼品兑换所需的用户等级，0—铜牌1—银牌2—金牌3—超级
	@property (nonatomic, readonly, copy) NSNumber *igUserLevel;
	//礼品图片
	@property (nonatomic, readonly, copy) NSString *igGoodsImg;
	//礼品详情
	@property (nonatomic, readonly, copy) NSString *igContent;
	//是否限制兑换时间
	@property (nonatomic, readonly, copy) NSNumber *igTimeType;
	
@end
