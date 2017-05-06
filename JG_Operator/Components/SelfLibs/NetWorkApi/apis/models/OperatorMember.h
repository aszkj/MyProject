//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface OperatorMember : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//会员来源：0邀请码1首次消费
	@property (nonatomic, readonly, copy) NSNumber *relationType;
	//注册时间
	@property (nonatomic, readonly, copy) NSDate *createTime;
	//商户名称
	@property (nonatomic, readonly, copy) NSString *groupStoreName;
	//昵称
	@property (nonatomic, readonly, copy) NSString *nickname;
	//会员类型
	@property (nonatomic, readonly, copy) NSString *relationName;
	//商户名称
	@property (nonatomic, readonly, copy) NSString *storeName;
	
@end
