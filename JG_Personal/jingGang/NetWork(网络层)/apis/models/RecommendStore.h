//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface RecommendStore : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSString *apiId;
	//店铺名称
	@property (nonatomic, readonly, copy) NSString *storeName;
	//城市id
	@property (nonatomic, readonly, copy) NSNumber *cityId;
	//地区id
	@property (nonatomic, readonly, copy) NSNumber *areaId;
	//地区
	@property (nonatomic, readonly, copy) NSString *areaInfo;
	//店铺图片
	@property (nonatomic, readonly, copy) NSString *storeInfoPath;
	//storeEvaluationCount
	@property (nonatomic, readonly, copy) NSNumber *storeEvaluationCount;
	//storeEvaluationAverage
	@property (nonatomic, readonly, copy) NSNumber *storeEvaluationAverage;
	//店铺地址
	@property (nonatomic, readonly, copy) NSString *storeAddress;
	//商户评分
	@property (nonatomic, readonly, copy) NSNumber *evaluationAverage;
	//商户图片
	@property (nonatomic, readonly, copy) NSString *storeMainInfoPath;
	//总销量
	@property (nonatomic, readonly, copy) NSNumber *sales;
	//距离，米
	@property (nonatomic, readonly, copy) NSNumber *distance;
	
@end
