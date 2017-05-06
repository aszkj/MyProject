//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface GoodsRefund : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//昵称
	@property (nonatomic, readonly, copy) NSString *nickName;
	//消费码
	@property (nonatomic, readonly, copy) NSString *groupSn;
	//下单时间
	@property (nonatomic, readonly, copy) NSDate *orderTime;
	//原价
	@property (nonatomic, readonly, copy) NSNumber *costPrice;
	//商品名称 
	@property (nonatomic, readonly, copy) NSString *ggName;
	//团购折扣
	@property (nonatomic, readonly, copy) NSNumber *ggRebate;
	//团队价
	@property (nonatomic, readonly, copy) NSNumber *groupPrice;
	//手机号
	@property (nonatomic, readonly, copy) NSString *mobile;
	//团购信息状态，默认为0，使用后为1，过期为-1，审核中为3，审核通过为5，审核不通过为6，退款完成为7
	@property (nonatomic, readonly, copy) NSNumber *status;
	
@end
