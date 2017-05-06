//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface OrderOnLine : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//订单号
	@property (nonatomic, readonly, copy) NSString *orderId;
	//用户昵称
	@property (nonatomic, readonly, copy) NSString *nickName;
	//下单时间
	@property (nonatomic, readonly, copy) NSString *addTime;
	
@end
