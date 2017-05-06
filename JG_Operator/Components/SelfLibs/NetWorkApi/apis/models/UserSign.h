//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface UserSign : MTLModel <MTLJSONSerializing>

	//当天是否已签到|true已签到false签到成功返回签到积分和天数
	@property (nonatomic, readonly, copy) NSNumber *isSign;
	//签到所得积分
	@property (nonatomic, readonly, copy) NSNumber *integral;
	//连续签到几天
	@property (nonatomic, readonly, copy) NSNumber *day;
	
@end
