//
//  RedPacketSoundPlayer.h
//  soundPlayTest
//
//  Created by mm on 16/11/15.
//  Copyright © 2016年 mm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RedPacketSoundPlayer : NSObject
/**
 将要开始倒计时
 */
- (void)playRedPacketGameWillBeginSound;
/**
 将要开始倒计时最后一声
 */
- (void)playRedPacketGameWillBeginLastSound;
/**
 正在播放
 */
- (void)playRedPacketGamePlayingSound;
/**
 点击没抢到
 */
- (void)playClickNotGrabedRedPacketSound;
/**
 点击抢到
 */
- (void)playClickGrabedRedPacketSound;

/**
 prepare所有的player
 */
- (void)prepareAllSoundPlaer;

/**
 暂停所有的player
 */
- (void)stopAllSoundPlaer;

/**
 清空所有的player
 */
- (void)clearAllSoundPlayer;

@end
