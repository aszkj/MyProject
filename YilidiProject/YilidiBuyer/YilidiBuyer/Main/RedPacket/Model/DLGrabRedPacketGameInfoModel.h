//
//  DLGrabRedPacketGameInfoModel.h
//  YilidiBuyer
//
//  Created by mm on 16/10/28.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseModel.h"

@interface DLGrabRedPacketGameInfoModel : BaseModel

@property (nonatomic,copy)NSString *activityId;

@property (nonatomic,copy)NSString *activityRule;

/**
用户当前活动剩余参与次数
 */
@property (nonatomic,assign)NSInteger residueTimes;
/**
用户当前活动已抢到的红包个数
 */
@property (nonatomic,assign)NSInteger receivedRedEnvelopCount;
/**
 当前活动最多每日参与次数
 */
@property (nonatomic,assign)NSInteger maxJoinTimes;
/**
每次抢红包的最大时间
 */
@property (nonatomic,assign)NSInteger maxTimePerTimes;
/**
 每次抢红包的最大总数量
 */
@property (nonatomic,assign)NSInteger maxCountPerTimes;
/**
接口调用几率（为百分比的单位：0-100）
 */
@property (nonatomic,assign)NSInteger interfaceInvokedProbability;


@end
