//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface GroupStoreFava : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//店铺等级，根据好评数累加
	@property (nonatomic, readonly, copy) NSNumber *storeCredit;
	//店铺名称
	@property (nonatomic, readonly, copy) NSString *storeName;
	//距离
	@property (nonatomic, readonly, copy) NSNumber *distance;
	//买家id
	@property (nonatomic, readonly, copy) NSNumber *createUserId;
	//经度
	@property (nonatomic, readonly, copy) NSNumber *storeLat;
	//纬度 
	@property (nonatomic, readonly, copy) NSNumber *storeLon;
	//服务评分
	@property (nonatomic, readonly, copy) NSNumber *evaluationAverage;
	//图片
	@property (nonatomic, readonly, copy) NSString *storeInfoPath;
	
@end
