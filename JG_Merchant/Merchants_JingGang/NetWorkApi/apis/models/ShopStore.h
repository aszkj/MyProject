//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ShopStore : MTLModel <MTLJSONSerializing>

	//店铺名称
	@property (nonatomic, readonly, copy) NSString *storeName;
	//店铺id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//店铺等级，根据好评数累加 
	@property (nonatomic, readonly, copy) NSNumber *storeCredit;
	//店铺介绍
	@property (nonatomic, readonly, copy) NSString *storeInfo;
	//店铺logo
	@property (nonatomic, readonly, copy) NSString *storeLogoPath;
	//描述相符
	@property (nonatomic, readonly, copy) NSNumber *storeDescription;
	//服务态度
	@property (nonatomic, readonly, copy) NSNumber *storeService;
	//发货速度
	@property (nonatomic, readonly, copy) NSNumber *storeShip;
	
@end
