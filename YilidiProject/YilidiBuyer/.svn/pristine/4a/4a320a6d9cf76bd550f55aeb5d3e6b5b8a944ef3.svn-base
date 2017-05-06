//
//  SeckillActivityModel.h
//  YilidiBuyer
//
//  Created by yld on 16/8/20.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ActivityModel.h"
#import "ProjectRelativEmerator.h"

#define hasGoneLeftCount -1000
#define crazySaleNoLeftCount -1001

@interface SeckillActivityModel : ActivityModel

@property (nonatomic,copy)NSString *serverSystemTime;


@property (nonatomic,copy)NSString *activityStatusName;
/**
 *  活动状态
 */
@property (nonatomic,assign)SeckillActivityStatus seckillActivityStatus;
/**
 *  每个模型的计数，疯抢和即将开始状态才有实际值，已经开始为-1000和疯抢最后一个场次情况下-1001
 */
@property (nonatomic,assign)long leftCount;

@end


@interface SeckillActivityModel (extral)

-(long long)beginTimeInterval;
-(long long)endTimeInterval;


@end