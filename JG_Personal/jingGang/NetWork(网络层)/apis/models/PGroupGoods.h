//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface PGroupGoods : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//商品名称
	@property (nonatomic, readonly, copy) NSString *ggName;
	//原价
	@property (nonatomic, readonly, copy) NSNumber *costPrice;
	//团购折扣
	@property (nonatomic, readonly, copy) NSNumber *ggRebate;
	//团队价 
	@property (nonatomic, readonly, copy) NSNumber *groupPrice;
	//商品状态 |  0为上架，1为在仓库中，3为店铺过期自动下架，-2为违规下架状态
	@property (nonatomic, readonly, copy) NSNumber *ggStatus;
	//团购图片
	@property (nonatomic, readonly, copy) NSString *groupAccPath;
	//服务描述
	@property (nonatomic, readonly, copy) NSString *groupDesc;
	//店铺名称
	@property (nonatomic, readonly, copy) NSString *storeName;
	//店铺地址
	@property (nonatomic, readonly, copy) NSString *storeAddress;
	//距离
	@property (nonatomic, readonly, copy) NSNumber *distance;
	//店铺id 
	@property (nonatomic, readonly, copy) NSNumber *storeId;
	//服务评分
	@property (nonatomic, readonly, copy) NSNumber *evaluationAverage;
	//已经售出的数量
	@property (nonatomic, readonly, copy) NSNumber *selledCount;
	//店铺等级
	@property (nonatomic, readonly, copy) NSNumber *gradeId;
	
@end
