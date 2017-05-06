//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface AddressListBO : MTLModel <MTLJSONSerializing>

	//收货地址ID
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//收货人详细地址
	@property (nonatomic, readonly, copy) NSString *areaInfo;
	//是否是默认地址
	@property (nonatomic, readonly, copy) NSNumber *defaultVal;
	//联系手机
	@property (nonatomic, readonly, copy) NSString *mobile;
	//收货人姓名
	@property (nonatomic, readonly, copy) NSString *trueName;
	//收货人地区
	@property (nonatomic, readonly, copy) NSString *areaName;
	
@end
