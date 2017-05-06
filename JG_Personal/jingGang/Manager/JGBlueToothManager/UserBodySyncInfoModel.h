//
//  UserBodySyncInfoModel.h
//  WKLBle
//
//  Created by 张康健 on 15/6/9.
//  Copyright (c) 2015年 baoyx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class UerBodyModel;

@interface UserBodySyncInfoModel : NSObject


//人体基本信息模型，计算需要
@property(nonatomic,strong)UerBodyModel *userBodyModel;

#pragma mark - 步数相关

//步数
@property (nonatomic,assign)NSInteger steps;

//里程
@property (nonatomic,assign)CGFloat licheng;

//卡洛里
@property (nonatomic,assign)CGFloat kaluoli;

//每天最后一次步数同步的时间字符串
@property (nonatomic,copy)NSString *perDaylastStepSyncTime;


#pragma mark - 睡眠
//总睡眠时长
@property (nonatomic,assign)NSInteger totalSleepTime;

//深度睡眠时长
@property (nonatomic,assign)NSInteger deepSleepTime;

//浅度睡眠时长
@property (nonatomic,assign)NSInteger lightSleepTime;

//每天最后一次睡眠同步的时间字符串
@property (nonatomic,copy)NSString *perDaylastSleepSyncTime;



//计算步数相关的，，包括，里程和卡洛里
-(void)culculateStepwithStepArr:(NSArray *)stepArr;


//计算深度，浅度睡眠
-(void)culculateSleepWithSleepArr:(NSArray *)sleepArr;

@end
