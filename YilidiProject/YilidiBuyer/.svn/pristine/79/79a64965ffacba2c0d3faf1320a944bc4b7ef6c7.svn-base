//
//  RedPacketGameManager.h
//  YilidiBuyer
//
//  Created by mm on 16/10/29.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProjectRelativEmerator.h"

@class DLGrabRedPacketGameInfoModel;
typedef void(^RequestRedPacketGameInfoBackBlock)(DLGrabRedPacketGameInfoModel *redPacketGameInfoModel,RequestRedPacketGameInfoResultErrorType requestRedPacketGameInfoResultErrorType);

@interface RedPacketGameManager : NSObject

-(void)requestGrabRedPacketGameInfoResultBlock:(RequestRedPacketGameInfoBackBlock)requestRedPacketGameInfoBackBlock;

-(void)requestBeginGrabRedPacketGameInfoResultBlock:(RequestRedPacketGameInfoBackBlock)requestRedPacketGameInfoBackBlock;


/**
 标志已经开始了抢红包
 */
- (void)markHasBeganGrabedRedPacket;

/**
 标志抢到了红包
 */
- (void)markHasGotRedPacket;
/**
 标志抢红包游戏正常结束了
 */
- (void)markRedPacketGameNormalEnded;

/**
 重置抢红包流程的状态
 */
- (void)resetGrabRedPacketGameFlowStatus;
/**
每次进入app查看上次抢红包游戏是否出现了异常退出情况
 */
- (BOOL)hasTheExceptionConditionForLastRedPacketGame;




@end
