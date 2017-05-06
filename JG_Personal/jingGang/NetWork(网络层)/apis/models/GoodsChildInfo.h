//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"
#import "GoodsInfo.h"

@interface GoodsChildInfo : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSString *orderId;
	//子订单信息
	@property (nonatomic, readonly, copy) NSArray *orderGoodsInfo;
	
@end
