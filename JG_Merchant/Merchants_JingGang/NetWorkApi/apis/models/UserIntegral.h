//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface UserIntegral : MTLModel <MTLJSONSerializing>

	//用户id
	@property (nonatomic, readonly, copy) NSNumber *uid;
	//冻结余额 
	@property (nonatomic, readonly, copy) NSNumber *freezeBlance;
	//用户积分
	@property (nonatomic, readonly, copy) NSNumber *integral;
	//金币
	@property (nonatomic, readonly, copy) NSNumber *gold;
	
@end
