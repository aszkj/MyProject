//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface RecommStoreInfo : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//店铺名称
	@property (nonatomic, readonly, copy) NSString *storeName;
	//店铺详细地址
	@property (nonatomic, readonly, copy) NSString *storeAddress;
	//地区
	@property (nonatomic, readonly, copy) NSString *area;
	//星级
	@property (nonatomic, readonly, copy) NSNumber *star;
	//距离
	@property (nonatomic, readonly, copy) NSNumber *distance;
	//banner图片
	@property (nonatomic, readonly, copy) NSString *storeInfoPath;
	//服务评分
	@property (nonatomic, readonly, copy) NSNumber *evaluationAverage;
	
@end
