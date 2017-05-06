//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface StepRecord : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//用户id
	@property (nonatomic, readonly, copy) NSNumber *uid;
	//步数
	@property (nonatomic, readonly, copy) NSNumber *stepNumber;
	//时间
	@property (nonatomic, readonly, copy) NSDate *recordDate;
	//里程
	@property (nonatomic, readonly, copy) NSNumber *totalKm;
	//卡路里
	@property (nonatomic, readonly, copy) NSNumber *calories;
	//星期
	@property (nonatomic, readonly, copy) NSNumber *week;
	//开始时间
	@property (nonatomic, readonly, copy) NSString *startDate;
	//结束时间
	@property (nonatomic, readonly, copy) NSString *endDate;
	//步数月统计记录
	@property (nonatomic, readonly, copy) NSNumber *stepTotalMonth;
	//里程月统计记录
	@property (nonatomic, readonly, copy) NSNumber *kmTotalMonth;
	//卡路里月月记录
	@property (nonatomic, readonly, copy) NSNumber *calTotalMonth;
	//月份
	@property (nonatomic, readonly, copy) NSNumber *month;
	
@end
