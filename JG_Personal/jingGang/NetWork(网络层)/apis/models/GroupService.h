//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface GroupService : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *goodsId;
	//商品名称
	@property (nonatomic, readonly, copy) NSString *goodsName;
	//结束时间
	@property (nonatomic, readonly, copy) NSDate *goodsEndTime;
	//开始时间
	@property (nonatomic, readonly, copy) NSDate *goodBeginTime;
	//商品价格
	@property (nonatomic, readonly, copy) NSNumber *goodsPrice;
	//商品类型
	@property (nonatomic, readonly, copy) NSNumber *goodsType;
	//图片
	@property (nonatomic, readonly, copy) NSString *goodsMainphotoPath;
	//订单总价
	@property (nonatomic, readonly, copy) NSNumber *goodsTotalPrice;
	//商品数量
	@property (nonatomic, readonly, copy) NSNumber *goodsCount;
	
@end
