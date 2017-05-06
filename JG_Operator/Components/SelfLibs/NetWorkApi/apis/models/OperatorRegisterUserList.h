//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface OperatorRegisterUserList : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//会员昵称
	@property (nonatomic, readonly, copy) NSString *nickname;
	//会员辖区
	@property (nonatomic, readonly, copy) NSString *areaName;
	//隶属商户昵称
	@property (nonatomic, readonly, copy) NSString *sellerNickName;
	//隶属商户运营商
	@property (nonatomic, readonly, copy) NSString *operatorName;
	//隶属运营商编号
	@property (nonatomic, readonly, copy) NSString *operatorCode;
	//注册时间
	@property (nonatomic, readonly, copy) NSDate *createTime;
	//店铺名称
	@property (nonatomic, readonly, copy) NSString *storeName;
	
@end
