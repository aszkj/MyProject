//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "StepRecordBO.h"
#import "WeekOfMonthRecordBO.h"

@interface EquipWeekQueryResponse :  AbstractResponse
//总步数
@property (nonatomic, readonly, copy) NSNumber *stepNumber;
//卡路里
@property (nonatomic, readonly, copy) NSNumber *calories;
//总里程
@property (nonatomic, readonly, copy) NSNumber *distance;
//一周数据
@property (nonatomic, readonly, copy) NSArray *weekStep;
//月中的周数据
@property (nonatomic, readonly, copy) NSArray *weekOfMonDataList;
//日期范围内的总步数记录
@property (nonatomic, readonly, copy) NSNumber *totalStepNumber;
//日期范围内的总卡路里记录
@property (nonatomic, readonly, copy) NSNumber *totalCalories;
//日期范围内的总里程记录
@property (nonatomic, readonly, copy) NSNumber *totalDistance;
//范围期间的记录
@property (nonatomic, readonly, copy) NSArray *rangeSteps;
//一年中个月的统计记录
@property (nonatomic, readonly, copy) NSArray *monthRecordList;
@end
