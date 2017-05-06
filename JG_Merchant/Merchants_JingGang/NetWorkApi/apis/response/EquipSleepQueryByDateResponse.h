//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "SleepRecord.h"

@interface EquipSleepQueryByDateResponse :  AbstractResponse
//睡眠信息
@property (nonatomic, readonly, copy) SleepRecord *sleepRecordBO;
//一周睡眠信息
@property (nonatomic, readonly, copy) NSArray *sleeps;
@end
