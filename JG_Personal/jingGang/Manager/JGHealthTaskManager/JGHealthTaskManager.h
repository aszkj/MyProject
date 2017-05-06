//
//  JGHealthTaskManager.h
//  jingGang
//
//  Created by 张康健 on 15/6/24.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGHealthTaskManager : NSObject

//健康任务管理单例
+ (id)shareInstances;

//健康大任务编号
@property (nonatomic,assign)NSInteger healthBigTaskNum;

//健康大任务下的小任务编号
@property (nonatomic,assign)NSInteger healthSmallTaskNum;


//视力保健任务完成情况数组
@property (nonatomic,strong)NSMutableArray *eyesightMaintainceCompletedArr;

//听力保健任务完成情况数组
@property (nonatomic,strong)NSMutableArray *hearingMaintainceCompletedArr;


//血压控制任务完成情况数组
@property (nonatomic,strong)NSMutableArray *blooControlceCompletedArr;

//体重控制完成情况数组
@property (nonatomic,strong)NSMutableArray *weightControlCompletedArr;


//视力完成个数
-(NSInteger)eyeCompletedCount;

//听力完成个数
-(NSInteger)hearingCompletedCount;

//血压控制完成个数
-(NSInteger)bloodControlCompletedCount;

//体重控制完成个数
-(NSInteger)weightControlCompletedCount;


//根据大任务和小任务编号去设置任务完成
- (void)setTaskCompletedBybigTaskNum:(NSInteger)bigTaskNum
                     andSmallTaskNum:(NSInteger)smallTaskNum;

//保存任务信息
-(void)saveTaskInfo;



@end
