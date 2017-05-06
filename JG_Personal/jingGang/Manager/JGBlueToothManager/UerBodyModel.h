//
//  UerBodyModel.h
//  WKLBle
//
//  Created by 张康健 on 15/6/9.
//  Copyright (c) 2015年 baoyx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QBleClient.h"
#define kGoalStep @"kGoalStep"

@interface UerBodyModel : NSObject

//目标步数
@property (nonatomic,assign)NSInteger goalSteps;

//目标睡眠时长
@property (nonatomic,assign)NSInteger goalSleepMinute;

//性别
@property (nonatomic,assign)GenderType genderType;

//年龄
@property (nonatomic,assign)int age;

//身高
@property (nonatomic,assign)int height;

//体重
@property (nonatomic,assign)float weight;


////单位类型
//@property (nonatomic,assign)UnitType unitType;
//
////防丢
//@property (nonatomic,assign)LostType lostType;
//
//
////是不是第一次同步
//@property (nonatomic,assign)BOOL isFirstSync;

-(void)setAllValueWithGoalSteps:(NSInteger)goalSteps
                     genderType:(GenderType)genderType
                            age:(NSInteger)age
                         height:(NSInteger)height
                         weight:(NSInteger)weight;









@end
