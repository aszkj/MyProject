//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface AwayStore : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//店铺名称
	@property (nonatomic, readonly, copy) NSString *storeName;
	//距离|米
	@property (nonatomic, readonly, copy) NSNumber *distance;
	//服务名称
	@property (nonatomic, readonly, copy) NSString *goodsName;
	//服务图片
	@property (nonatomic, readonly, copy) NSString *goodsPath;
	//价格
	@property (nonatomic, readonly, copy) NSNumber *price;
	//销量
	@property (nonatomic, readonly, copy) NSNumber *sales;
	//服务id
	@property (nonatomic, readonly, copy) NSNumber *goodsId;
	
@end
