//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface PStoreInfo : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//店铺名称
	@property (nonatomic, readonly, copy) NSString *storeName;
	//店铺详细地址
	@property (nonatomic, readonly, copy) NSString *storeAddress;
	//店铺等级，根据好评数累加
	@property (nonatomic, readonly, copy) NSNumber *storeCredit;
	//服务评分
	@property (nonatomic, readonly, copy) NSNumber *storeEvaluationAverage;
	//店铺介绍
	@property (nonatomic, readonly, copy) NSString *storeInfo;
	//图片
	@property (nonatomic, readonly, copy) NSString *photoPath;
	//图片数量
	@property (nonatomic, readonly, copy) NSNumber *photoSize;
	//距离
	@property (nonatomic, readonly, copy) NSNumber *distance;
	//纬度
	@property (nonatomic, readonly, copy) NSNumber *storeLon;
	//经度
	@property (nonatomic, readonly, copy) NSNumber *storeLat;
	//店铺电话
	@property (nonatomic, readonly, copy) NSString *storeTelephone;
	//公司简介
	@property (nonatomic, readonly, copy) NSString *licenseCDesc;
	
@end
