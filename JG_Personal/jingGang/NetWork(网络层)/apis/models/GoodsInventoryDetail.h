//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface GoodsInventoryDetail : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSString *apiId;
	//积分价
	@property (nonatomic, readonly, copy) NSNumber *integralPrice;
	//价格
	@property (nonatomic, readonly, copy) NSNumber *price;
	//积分
	@property (nonatomic, readonly, copy) NSNumber *integralCount;
	//数量
	@property (nonatomic, readonly, copy) NSNumber *count;
	//手机专享价
	@property (nonatomic, readonly, copy) NSNumber *mobilePrice;
	
@end
