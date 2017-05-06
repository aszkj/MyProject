//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface OperatorRelationList : MTLModel <MTLJSONSerializing>

	//注册运营商
	@property (nonatomic, readonly, copy) NSNumber *operatorRegisterCount;
	//注册的商户
	@property (nonatomic, readonly, copy) NSNumber *storeRegisterCount;
	//注册的会员
	@property (nonatomic, readonly, copy) NSNumber *userRegisterCount;
	// 辖区运营商
	@property (nonatomic, readonly, copy) NSNumber *areaOperatorCount;
	//隶属的商户
	@property (nonatomic, readonly, copy) NSNumber *membershipCount;
	//隶属商户的会员
	@property (nonatomic, readonly, copy) NSNumber *membershipUserCount;
	
@end
