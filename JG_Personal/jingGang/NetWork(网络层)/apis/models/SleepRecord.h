//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface SleepRecord : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//用户id
	@property (nonatomic, readonly, copy) NSNumber *uid;
	//睡眠时长
	@property (nonatomic, readonly, copy) NSNumber *sleepSecond;
	//深睡时长
	@property (nonatomic, readonly, copy) NSNumber *deepSleepSecond;
	//浅睡时长 
	@property (nonatomic, readonly, copy) NSNumber *shallowSleepSecond;
	//星期 
	@property (nonatomic, readonly, copy) NSNumber *week;
	//开始日期|yyyy/MM/dd
	@property (nonatomic, readonly, copy) NSString *startDate;
	//结束日期 |yyyy/MM/dd
	@property (nonatomic, readonly, copy) NSString *endDate;
	
@end
