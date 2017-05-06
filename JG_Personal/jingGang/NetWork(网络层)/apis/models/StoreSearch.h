//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface StoreSearch : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//店铺名称
	@property (nonatomic, readonly, copy) NSString *storeName;
	//店铺图片
	@property (nonatomic, readonly, copy) NSString *storeInfoPath;
	//店铺地址
	@property (nonatomic, readonly, copy) NSString *storeAddress;
	//销量
	@property (nonatomic, readonly, copy) NSNumber *sales;
	//距离|米
	@property (nonatomic, readonly, copy) NSNumber *distance;
	//评论数量
	@property (nonatomic, readonly, copy) NSNumber *storeEvaluationCount;
	//星级
	@property (nonatomic, readonly, copy) NSNumber *storeEvaluationAverage;
	
@end
