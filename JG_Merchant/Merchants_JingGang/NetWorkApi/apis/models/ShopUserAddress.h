//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ShopUserAddress : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//地址|省+市+区
	@property (nonatomic, readonly, copy) NSString *areaName;
	//详细地址
	@property (nonatomic, readonly, copy) NSString *areaInfo;
	//收件人姓名
	@property (nonatomic, readonly, copy) NSString *trueName;
	//收件人手机
	@property (nonatomic, readonly, copy) NSString *mobile;
	//邮编
	@property (nonatomic, readonly, copy) NSString *zip;
	//收货人地区 
	@property (nonatomic, readonly, copy) NSNumber *areaId;
	//是否是默认地址
	@property (nonatomic, readonly, copy) NSNumber *defaultVal;
	
@end
