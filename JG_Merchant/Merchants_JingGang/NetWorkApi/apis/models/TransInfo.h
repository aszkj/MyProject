//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "TransContent.h"

@interface TransInfo : MTLModel <MTLJSONSerializing>

	//快递公司信息
	@property (nonatomic, readonly, copy) NSString *expressEompanyName;
	// 快递单号
	@property (nonatomic, readonly, copy) NSString *expressShipCode;
	//详细信息
	@property (nonatomic, readonly, copy) NSArray *data;
	//快递公司名称
	@property (nonatomic, readonly, copy) NSString *expressName;
	
@end
