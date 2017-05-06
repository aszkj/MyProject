//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface WeekOfMonthRecordBO : MTLModel <MTLJSONSerializing>

	//步数
	@property (nonatomic, readonly, copy) NSNumber *stepNumSumOfWeek;
	//里程
	@property (nonatomic, readonly, copy) NSNumber *totalKmSumOfWeek;
	//卡路里
	@property (nonatomic, readonly, copy) NSNumber *caloriesSumOfWeek;
	//睡眠时长
	@property (nonatomic, readonly, copy) NSNumber *sleepSecondSumOfWeek;
	//深睡时长
	@property (nonatomic, readonly, copy) NSNumber *deepSleepSecondSumOfWeek;
	//浅睡时长 
	@property (nonatomic, readonly, copy) NSNumber *shallowSleepSecondSumOfWeek;
	
@end
