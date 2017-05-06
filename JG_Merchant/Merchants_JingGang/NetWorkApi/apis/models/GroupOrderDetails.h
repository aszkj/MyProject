//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "GroupService.h"
#import "GroupInfo.h"

@interface GroupOrderDetails : MTLModel <MTLJSONSerializing>

	//订单号
	@property (nonatomic, readonly, copy) NSString *orderId;
	//下单时间
	@property (nonatomic, readonly, copy) NSDate *addTime;
	//昵称
	@property (nonatomic, readonly, copy) NSString *nickName;
	//手机号码
	@property (nonatomic, readonly, copy) NSString *mobile;
	//商品信息
	@property (nonatomic, readonly, copy) GroupService *serviceBO;
	//券列表
	@property (nonatomic, readonly, copy) NSArray *groupInfo;
	
@end
