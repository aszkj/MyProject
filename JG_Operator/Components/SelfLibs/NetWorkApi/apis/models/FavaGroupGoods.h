//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface FavaGroupGoods : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//店铺名称
	@property (nonatomic, readonly, copy) NSString *storeName;
	//服务名称
	@property (nonatomic, readonly, copy) NSString *ggName;
	//团队价 
	@property (nonatomic, readonly, copy) NSNumber *groupPrice;
	//团购图片 
	@property (nonatomic, readonly, copy) NSString *groupAccPath;
	
@end
