//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface StoreCustomer : MTLModel <MTLJSONSerializing>

	//会员来源0邀请码1首次消费
	@property (nonatomic, readonly, copy) NSNumber *relationType;
	//注册时间
	@property (nonatomic, readonly, copy) NSDate *accountCreateTime;
	//昵称
	@property (nonatomic, readonly, copy) NSString *nickname;
	//手机 
	@property (nonatomic, readonly, copy) NSString *mobile;
	
@end
