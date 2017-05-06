//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "ShopOrderList.h"
#import "ShopUserAddress.h"

@interface ShopOrderListDetail : MTLModel <MTLJSONSerializing>

	//默认地址对象
	@property (nonatomic, readonly, copy) ShopUserAddress *shopUserAddress;
	//订单列表
	@property (nonatomic, readonly, copy) NSArray *orderList;
	
@end
