//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "StepRecord.h"

@interface EquipDayQueryByDateResponse :  AbstractResponse
//总步数
@property (nonatomic, readonly, copy) NSNumber *stepNumber;
//卡路里
@property (nonatomic, readonly, copy) NSNumber *calories;
//总里程
@property (nonatomic, readonly, copy) NSNumber *distance;
//一周数据
@property (nonatomic, readonly, copy) NSArray *weekStep;
@end
