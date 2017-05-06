//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"
#import "PGroupGoods.h"
#import "PStoreInfo.h"

@interface PGroup : MTLModel <MTLJSONSerializing>

	//店铺信息
	@property (nonatomic, readonly, copy) PStoreInfo *storeInfoBO;
	//套餐券
	@property (nonatomic, readonly, copy) NSArray *packageList;
	//现金券
	@property (nonatomic, readonly, copy) NSArray *cashList;
	
@end
